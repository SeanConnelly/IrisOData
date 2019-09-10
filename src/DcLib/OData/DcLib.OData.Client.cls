Class DcLib.OData.Client Extends %RegisteredObject
{

Parameter BaseURL;

Parameter SSLConfiguration;

Parameter EntityName;

Property HttpRequest As %Net.HttpRequest;

Property BaseURL As %String;

Property EntityName As %String;

Property Debug As %Boolean [ InitialExpression = 0 ];

Method %OnNew(pBaseURL As %String = "", pSSLConfiguration As %String = "") As %Status [ Private, ServerOnly = 1 ]
{
	set ..HttpRequest=##class(%Net.HttpRequest).%New()
	set ..BaseURL=$select(pBaseURL'="":pBaseURL,1:..#BaseURL)
	set ..EntityName=..#EntityName
	set sslConfiguration=$select(pSSLConfiguration'="":pSSLConfiguration,1:..#SSLConfiguration)
	if sslConfiguration'="" set ..HttpRequest.SSLConfiguration=sslConfiguration
	quit $$$OK
}

Method DebugOn()
{
	set ..Debug=1
	return $this
}

Method Select(pSelect As %String) As DcLib.OData.Client
{
	do ..HttpRequest.SetParam("$select",pSelect)
	return $this
}

Method Filter(pFilter As %String) As DcLib.OData.Client
{
	do ..HttpRequest.SetParam("$filter",pFilter)
	return $this
}

Method Search(pSearch As %String) As DcLib.OData.Client
{
	do ..HttpRequest.SetParam("$search",pSearch)
	return $this
}

Method OrderBy(pOrderBy As %String) As DcLib.OData.Client
{
	do ..HttpRequest.SetParam("$orderby",pOrderBy)
	return $this
}

Method Top(pTop As %String) As DcLib.OData.Client
{
	do ..HttpRequest.SetParam("$top",pTop)
	return $this
}

Method Skip(pSkip As %String) As DcLib.OData.Client
{
	do ..HttpRequest.SetParam("$skip",pSkip)
	return $this
}

Method Fetch(pEntityId As %String = "") As DcLib.OData.ClientResponse
{
	if pEntityId="" return ##class(DcLib.OData.ClientResponse).%New($$$ERROR($$$GeneralError,"Entity ID must be provided"),"")
	set pEntityId="('"_pEntityId_"')"
	if $extract(..BaseURL,*)'="/" set ..BaseURL=..BaseURL_"/"
	set sc=..HttpRequest.Get(..BaseURL_..EntityName_pEntityId,..Debug)
	set response=##class(DcLib.OData.ClientResponse).%New(sc,..HttpRequest.HttpResponse,"one")
	quit response
}

Method FetchCount() As DcLib.OData.ClientResponse
{
	if $extract(..BaseURL,*)'="/" set ..BaseURL=..BaseURL_"/"
	set sc=..HttpRequest.Get(..BaseURL_..EntityName_"/$count")
	set response=##class(DcLib.OData.ClientResponse).%New(sc,..HttpRequest.HttpResponse,"count")
	quit response
}

Method FetchAll() As DcLib.OData.ClientResponse
{
	#dim response As DcLib.OData.ClientResponse
	if $extract(..BaseURL,*)'="/" set ..BaseURL=..BaseURL_"/"
	set sc=..HttpRequest.Get(..BaseURL_..EntityName,..Debug)
	set response=##class(DcLib.OData.ClientResponse).%New(sc,..HttpRequest.HttpResponse,"many")
	if response.IsError() return response
	//if the response has a nextLink then we need to keep going back to fetch more data
	while response.Payload.%IsDefined("@odata.nextLink") {
		//stash the previous value array, push the new values on to it and then
		//set it back to the new response and create a new value iterator
		set previousValueArray=response.Payload.value
		set sc=..HttpRequest.Get(response.Payload."@odata.nextLink",..Debug)
		set response=##class(DcLib.OData.ClientResponse).%New(sc,..HttpRequest.HttpResponse)
		if response.IsError() return response
		while response.Value.%GetNext(.key,.value) {
			do previousValueArray.%Push(value)	
		}
		set response.Payload.value=previousValueArray
		set response.Value=response.Payload.value.%GetIterator()
	}
	return response
}

ClassMethod With(pEntityName As %String) As DcLib.OData.Client
{
	set client=..%New()
	set client.EntityName=pEntityName
	return client
}

}

