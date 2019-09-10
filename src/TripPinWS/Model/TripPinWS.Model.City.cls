Class TripPinWS.Model.City Extends (%Persistent, %JSON.Adaptor)
{

Property CountryRegion As %String;

Property Name As %String;

Property Region As %String;

Storage Default
{
<Data name="CityDefaultData">
<Subscript>"1"</Subscript>
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
</Data>
<Data name="CityState">
<Value name="1">
<Value>CountryRegion</Value>
</Value>
<Value name="2">
<Value>Name</Value>
</Value>
<Value name="3">
<Value>Region</Value>
</Value>
</Data>
<DataLocation>^TripPinWS.Model.CityD</DataLocation>
<DefaultData>CityDefaultData</DefaultData>
<IdLocation>^TripPinWS.Model.CityD</IdLocation>
<IndexLocation>^TripPinWS.Model.CityI</IndexLocation>
<State>CityState</State>
<StreamLocation>^TripPinWS.Model.CityS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

