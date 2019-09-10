# Simple OData Client for IRIS

### Introduction

A simple IRIS client for conneting and consuming RESTful OData API services.

Includes a number of example tests for implementing the OData TripPinWS service at www.odata.org

### Motivation

IRIS includes a robust HTTP client for requesting and processing HTTP services.

OData is a specification for building consistent RESTful API services. With a small amount of boiler plate code it is possible to extend the IRIS HTTP client with a number of helpful methods.

### Installation

The full project code and tests are provided in this Git repository. To install the code, import the **DcLib_OData1.0.xml** file found in the build folder.

### A full explanation of the project can be found in this DC article

<TODO: link>

### Running the tests

```
DC>d ##class(TripPinWS.Tests).TestGenericFetchAllUsingWithPeople()

Russell Whyte
Scott Ketchum
Ronald Mundy
Javier Alfred
Willie Ashmore
Vincent Calabrese
Clyde Guess
Keith Pinckney
Marshall Garay
Ryan Theriault
Elaine Stewart
Sallie Sampson
Joni Rosales
Georgina Barlow
Angel Huffman
Laurel Osborn
Sandy Osborn
Ursula Bright
Genevieve Reeves
Krista Kemp
```
 
```
DC>d ##class(TripPinWS.Tests).TestFetchAllPeople()
 
Russell Whyte
Scott Ketchum
Ronald Mundy
Javier Alfred
Willie Ashmore
Vincent Calabrese
Clyde Guess
Keith Pinckney
Marshall Garay
Ryan Theriault
Elaine Stewart
Sallie Sampson
Joni Rosales
Georgina Barlow
Angel Huffman
Laurel Osborn
Sandy Osborn
Ursula Bright
Genevieve Reeves
Krista Kemp
```

```
DC>d ##class(TripPinWS.Tests).TestFetchPersonWithID()

{
  "@odata.context":"http://services.odata.org/V4/(S(jndgbgy2tbu1vjtzyoei2w3e))/TripPinServiceRW/$metadata#People/$entity",
  "@odata.id":"http://services.odata.org/V4/(S(jndgbgy2tbu1vjtzyoei2w3e))/TripPinServiceRW/People('russellwhyte')",
  "@odata.etag":"W/\"08D73618931971BD\"",
  "@odata.editLink":"http://services.odata.org/V4/(S(jndgbgy2tbu1vjtzyoei2w3e))/TripPinServiceRW/People('russellwhyte')",
  "UserName":"russellwhyte",
  "FirstName":"Russell",
  "LastName":"Whyte",
  "Emails":[
    "Russell@example.com",
    "Russell@contoso.com"
  ],
  "AddressInfo":[
    {
      "Address":"187 Suffolk Ln.",
      "City":{
        "CountryRegion":"United States",
        "Name":"Boise",
        "Region":"ID"
      }
    }
  ],
  "Gender":"Male",
  "Concurrency":637037351471247805
}
```

```
DC>d ##class(TripPinWS.Tests).TestFetchAllAirlines()
 
AA American Airlines
FM Shanghai Airline
MU China Eastern Airlines
AF Air France
AZ Alitalia
AC Air Canada
OS Austrian Airlines
TK Turkish Airlines
JL Japan Airlines
SQ Singapore Airlines
KE Korean Air
CZ China Southern
AK AirAsia
HX Hong Kong Airlines
EK Emirates
```
 
```
DC>d ##class(TripPinWS.Tests).TestFetchAllAirports()
 
SFO San Francisco International Airport
LAX Los Angeles International Airport
SHA Shanghai Hongqiao International Airport
PEK Beijing Capital International Airport
JFK John F. Kennedy International Airport
CIA Rome Ciampino Airport
YYZ Toronto Pearson International Airport
SYD Sydney Airport
IST Istanbul Ataturk Airport
SIN Singapore Changi Airport
AUH Abu Dhabi International Airport
CAN Guangzhou Baiyun International Airport
ORD O'Hare International Airport
ATL Hartsfield-Jackson Atlanta International Airport
SEA Seattle-Tacoma International Airport
```
 
```
DC>d ##class(TripPinWS.Tests).TestForError1()
 
Resource not found for the segment 'Peoples'.
```
 
```
DC>d ##class(TripPinWS.Tests).TestForError2()
 
Entity ID must be provided
``` 
 
```
DC>d ##class(TripPinWS.Tests).TestFetchAllPeopleWithFilter()
 
Ronald Mundy
```

```
DC>d ##class(TripPinWS.Tests).TestFetchAllPeopleWithSelect()

russellwhyte
  Russell@example.com
  Russell@contoso.com
 
scottketchum
  Scott@example.com
 
ronaldmundy
  Ronald@example.com
  Ronald@contoso.com
 
javieralfred
  Javier@example.com
  Javier@contoso.com
 
willieashmore
  Willie@example.com
  Willie@contoso.com
 
vincentcalabrese
  Vincent@example.com
  Vincent@contoso.com
 
clydeguess
  Clyde@example.com
 
keithpinckney
  Keith@example.com
  Keith@contoso.com
 
marshallgaray
  Marshall@example.com
  Marshall@contoso.com
 
ryantheriault
  Ryan@example.com
  Ryan@contoso.com
 
elainestewart
  Elaine@example.com
  Elaine@contoso.com
 
salliesampson
  Sallie@example.com
  Sallie@contoso.com
 
jonirosales
  Joni@example.com
  Joni@contoso.com
 
georginabarlow
  Georgina@example.com
  Georgina@contoso.com
 
angelhuffman
  Angel@example.com
 
laurelosborn
  Laurel@example.com
  Laurel@contoso.com
 
sandyosborn
  Sandy@example.com
  Sandy@contoso.com
 
ursulabright
  Ursula@example.com
  Ursula@contoso.com
 
genevievereeves
  Genevieve@example.com
  Genevieve@contoso.com
 
kristakemp
  Krista@example.com
```

```
DC>d ##class(TripPinWS.Tests).TestFetchAllAirportsWithSearch()
 
IataCode: KJFK
Name:     John F. Kennedy International Airport
Address:  Jamaica, New York, NY 11430
          New York City
          United States
Coords    -73.7788888888889
          40.6397222222222
```

```
DC>d ##class(TripPinWS.Tests).TestFetchAllAirportsWithAndWithoutOrderBy()
  
Unordered...
KSFO
KLAX
ZSSS
ZBAA
KJFK
LIRA
CYYZ
YSSY
LTBA
WSSS
OMAA
ZGGG
KORD
KATL
KSEA
 
Ordered...
CYYZ
KATL
KJFK
KLAX
KORD
KSEA
KSFO
LIRA
LTBA
OMAA
WSSS
YSSY
ZBAA
ZGGG
ZSSS
```

```
DC>d ##class(TripPinWS.Tests).TestFetchAirportCount()

Count of airports = 15
```
