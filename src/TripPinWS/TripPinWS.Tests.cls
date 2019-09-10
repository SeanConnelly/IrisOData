Class TripPinWS.Tests Extends %RegisteredObject
{

/// Fetch all with "People" entity using the base client class and .With("People")
ClassMethod TestGenericFetchAllUsingWithPeople()
{
	#dim response As DcLib.OData.ClientResponse
	set response=##class(TripPinWS.Client).With("People").FetchAll()
	
	if response.IsError() write !,response.GetStatusText() quit
	
	while response.Value.%GetNext(.key,.person) {
		write !,person.FirstName," ",person.LastName	
	}
}

/// Fetch all "People" entity using the People class
ClassMethod TestFetchAllPeople()
{
	#dim people As DcLib.OData.ClientResponse
	set people=##class(TripPinWS.People).%New().FetchAll()
	
	if people.IsError() write !,people.GetStatusText() quit
	
	while people.Value.%GetNext(.key,.person) {
		write !,person.FirstName," ",person.LastName	
	}
}

/// Fetch single "People" entity using the persons ID
ClassMethod TestFetchPersonWithID()
{
	#dim response As DcLib.OData.ClientResponse
	set response=##class(TripPinWS.People).%New().Fetch("russellwhyte")
	
	if response.IsError() write !,response.GetStatusText() quit
	
	//lets use the new formatter to pretty print to the output (latest version of IRIS only)
	set jsonFormatter = ##class(%JSON.Formatter).%New()
	do jsonFormatter.Format(response.Value)
}

/// Fetch all "Airlines"
ClassMethod TestFetchAllAirlines()
{
	#dim airlines As DcLib.OData.ClientResponse
	set airlines=##class(TripPinWS.Airlines).%New().FetchAll()
	
	if airlines.IsError() write !,airlines.GetStatusText() quit
	
	while airlines.Value.%GetNext(.key,.airline) {
		write !,airline.AirlineCode," ",airline.Name	
	}
}

/// Fetch all "Airports"
ClassMethod TestFetchAllAirports()
{
	#dim airports As DcLib.OData.ClientResponse
	set airports=##class(TripPinWS.Airports).%New().FetchAll()
	
	if airports.IsError() write !,airports.GetStatusText() quit
	
	while airports.Value.%GetNext(.key,.airport) {
		write !,airport.IataCode," ",airport.Name	
	}
}

/// Should raise an intentional error, the entity "Peoples" should be "People"
/// Error should be: Resource not found for the segment 'Peoples'.
ClassMethod TestForError1()
{
	#dim people As DcLib.OData.ClientResponse
	set people=##class(TripPinWS.Client).With("Peoples").FetchAll()
	
	if people.IsError() write !,people.GetStatusText() quit
}

/// Should raise an intentiional error, Fetch expects an ID
/// Error should be: Entity ID must be provided
ClassMethod TestForError2()
{
	#dim people As DcLib.OData.ClientResponse
	set people=##class(TripPinWS.Client).With("Peoples").Fetch()
	
	if people.IsError() write !,people.GetStatusText() quit
}

/// Use .Filter() to fetch all People
ClassMethod TestFetchAllPeopleWithFilter()
{
	#dim people As DcLib.OData.ClientResponse
	set people=##class(TripPinWS.People).%New().Filter("UserName eq 'ronaldmundy'").FetchAll()
	
	if people.IsError() write !,people.GetStatusText() quit
	
	while people.Value.%GetNext(.key,.person) {
		write !,person.FirstName," ",person.LastName	
	}
}

/// Only .Select() UserName and Emails of all users
ClassMethod TestFetchAllPeopleWithSelect()
{
	#dim people As DcLib.OData.ClientResponse
	set people=##class(TripPinWS.People).%New().Select("UserName,Emails").FetchAll()
	
	if people.IsError() write !,people.GetStatusText() quit
	
	while people.Value.%GetNext(.key,.person) {
		write !!,person.UserName
		set emails=person.Emails.%GetIterator()
		while emails.%GetNext(.key2,.email) {
			write !,"  ",email	
		}
	}
}

/// Use .Search() to fetch all airpots that include the word "Kennedy" anywhere in the data
ClassMethod TestFetchAllAirportsWithSearch()
{
	#dim airports As DcLib.OData.ClientResponse
	set airports=##class(TripPinWS.Airports).%New().Search("Kennedy").FetchAll()
	
	if airports.IsError() write !,airports.GetStatusText() quit
	
	while airports.Value.%GetNext(.key,.airport) {
		write !,"IataCode: ",airport.IcaoCode
		write !,"Name:     ",airport.Name
		write !,"Address:  ",airport.Location.Address
		write !,"          ",airport.Location.City.Name
		write !,"          ",airport.Location.City.CountryRegion
		write !,"Coords    ",airport.Location.Loc.coordinates.%Get(0)
		write !,"          ",airport.Location.Loc.coordinates.%Get(1)
	}
}

/// Fetch all airports using order by
ClassMethod TestFetchAllAirportsWithAndWithoutOrderBy()
{
	set airportClient=##class(TripPinWS.Airports).%New()
	
	#dim airports As DcLib.OData.ClientResponse
	set airports=airportClient.FetchAll()
	
	write !!,"Unordered..."
	
	while airports.Value.%GetNext(.key,.airport) {
		write !,airport.IcaoCode	
	}
	
	write !!,"Ordered..."
	
	set airports=airportClient.OrderBy("IcaoCode").FetchAll()
	while airports.Value.%GetNext(.key,.airport) {
		write !,airport.IcaoCode	
	}
}

/// Fetch total count of airports only
ClassMethod TestFetchAirportCount()
{
	#dim airports As DcLib.OData.ClientResponse
	set airports=##class(TripPinWS.Airports).%New().FetchCount()

	if airports.IsError() write !,airports.GetStatusText() quit
	
	write "Count of airports = ",airports.Value
}

ClassMethod TestPersonModel()
{
	#dim response As DcLib.OData.ClientResponse
	set response=##class(TripPinWS.People).%New().Fetch("russellwhyte")
	
	if response.IsError() write !,response.GetStatusText() quit
	
	set person=##class(TripPinWS.Model.Person).%New()
	
	set sc=person.%JSONImport(response.Value)
	if $$$ISERR(sc) write !!,$SYSTEM.Status.GetOneErrorText(sc) return
	
	set sc=person.%Save()
	if $$$ISERR(sc) write !!,$SYSTEM.Status.GetOneErrorText(sc) return
}

/// This person has two address
ClassMethod TestPersonModel2()
{
	#dim response As DcLib.OData.ClientResponse
	set response=##class(TripPinWS.People).%New().Fetch("salliesampson")
	
	if response.IsError() write !,response.GetStatusText() quit
	
	set person=##class(TripPinWS.Model.Person).%New()
	
	set sc=person.%JSONImport(response.Value)
	if $$$ISERR(sc) write !!,$SYSTEM.Status.GetOneErrorText(sc) return
	
	set sc=person.%Save()
	if $$$ISERR(sc) write !!,$SYSTEM.Status.GetOneErrorText(sc) return
}

}

