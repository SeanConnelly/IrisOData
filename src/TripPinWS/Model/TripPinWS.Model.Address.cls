Class TripPinWS.Model.Address Extends (%Persistent, %JSON.Adaptor)
{

Property Address As %String;

Property City As TripPinWS.Model.City;

Relationship Person As Person [ Cardinality = one, Inverse = AddressInfo ];

Storage Default
{
<Data name="AddressDefaultData">
<Subscript>"1"</Subscript>
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
</Data>
<Data name="AddressState">
<Value name="1">
<Value>Address</Value>
</Value>
<Value name="2">
<Value>City</Value>
</Value>
<Value name="3">
<Value>Person</Value>
</Value>
</Data>
<DataLocation>^TripPinWS.Model.AddressD</DataLocation>
<DefaultData>AddressDefaultData</DefaultData>
<IdLocation>^TripPinWS.Model.AddressD</IdLocation>
<IndexLocation>^TripPinWS.Model.AddressI</IndexLocation>
<State>AddressState</State>
<StreamLocation>^TripPinWS.Model.AddressS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

