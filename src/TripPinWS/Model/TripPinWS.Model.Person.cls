Class TripPinWS.Model.Person Extends (%Persistent, %JSON.Adaptor)
{

Parameter %JSONIGNOREINVALIDFIELD = 1;

Property UserName As %String;

Property FirstName As %String;

Property LastName As %String;

Property Emails As list Of %String;

Property Gender As %String;

Property Concurrency As %Integer;

Relationship AddressInfo As Address [ Cardinality = many, Inverse = Person ];

Index UserNameIndex On UserName [ IdKey, PrimaryKey, Unique ];

Storage Default
{
<Data name="PersonDefaultData">
<Value name="1">
<Value>%%CLASSNAME</Value>
</Value>
<Value name="2">
<Value>UserName</Value>
</Value>
<Value name="3">
<Value>FirstName</Value>
</Value>
<Value name="4">
<Value>LastName</Value>
</Value>
<Value name="5">
<Value>Emails</Value>
</Value>
<Value name="6">
<Value>Gender</Value>
</Value>
<Value name="7">
<Value>Concurrency</Value>
</Value>
<Value name="8">
<Value>AddressInfo</Value>
</Value>
</Data>
<DataLocation>^TripPinWS.Model.PersonD</DataLocation>
<DefaultData>PersonDefaultData</DefaultData>
<IdLocation>^TripPinWS.Model.PersonD</IdLocation>
<IndexLocation>^TripPinWS.Model.PersonI</IndexLocation>
<StreamLocation>^TripPinWS.Model.PersonS</StreamLocation>
<Type>%Storage.Persistent</Type>
}

}

