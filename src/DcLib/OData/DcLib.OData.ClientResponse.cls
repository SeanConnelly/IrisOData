Class DcLib.OData.ClientResponse Extends %RegisteredObject
{

Property InternalStatus As %Status [ Private ];

Property HttpResponse As %Net.HttpResponse;

Property Payload As %Library.DynamicObject;

Property Value;

Method %OnNew(pRequestStatus As %Status, pHttpResponse As %Net.HttpResponse, pValueMode As %String = "") As %Status [ Private, ServerOnly = 1 ]
{
	//check for immediate HTTP error
	set ..InternalStatus = pRequestStatus
	set ..HttpResponse = pHttpResponse
	if $$$ISERR(pRequestStatus) {
		if $SYSTEM.Status.GetOneErrorText(pRequestStatus)["<READ>" set ..InternalStatus=$$$ERROR($$$GeneralError,"Could not get a response from HTTP server, server could be uncontactable or server details are incorrect") 
		return $$$OK
	}
	
	//if mode is count, then the response is not JSON, its just a numeric value
	//validate that it is a number and return all ok if true, else let it fall through
	//to pick up any errors that are presented as JSON
	if pValueMode="count" {
		set value=pHttpResponse.Data.Read(32000)
		if value?1.N {
			set ..Value=value
			return $$$OK
		}
	}
	
	//serialise JSON payload, catch any serialisation errors
	try {
		set ..Payload={}.%FromJSON(pHttpResponse.Data)	
	} catch err {
		//check for HTTP status code error first
		if $e(pHttpResponse.StatusCode,1)'="2" {
			set ..InternalStatus = $$$ERROR($$$GeneralError,"Unexpected HTTP Status Code "_pHttpResponse.StatusCode)
			if pHttpResponse.Data.Size>0 return $$$OK
		}
		set ..InternalStatus=err.AsStatus()
		return $$$OK
	}
	
	//check payload for an OData error
	if ..Payload.%IsDefined("error") {
		do ..HttpResponse.Data.Rewind()
		set error=..HttpResponse.Data.Read(32000)
		set ..InternalStatus=$$$ERROR($$$GeneralError,..Payload.error.message)	
		return $$$OK
	}
	
	//all ok, set the response value to match the required modes (many, one, count)
	if pValueMode="one" {
		set ..Value=..Payload
	} else {
		set iterator=..Payload.value.%GetIterator()
		set ..Value=iterator
	}
	
	return $$$OK
}

Method IsOK()
{
	return $$$ISOK(..InternalStatus)
}

Method IsError()
{
	return $$$ISERR(..InternalStatus)
}

Method GetStatus()
{
	return ..InternalStatus
}

Method GetStatusText()
{
	return $SYSTEM.Status.GetOneStatusText(..InternalStatus)
}

Method ThrowException()
{
	Throw ##class(%Exception.General).%New("OData Fetch Exception","999",,$SYSTEM.Status.GetOneStatusText(..InternalStatus))
}

Method OutputToDevice()
{
	do ..HttpResponse.OutputToDevice()
}

}

