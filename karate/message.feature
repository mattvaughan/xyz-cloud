Feature: Getting a Message
 
Scenario: The message should have this constant shape
  * url baseUrl + '/Message'
  * method GET
  * status 200
  * match $.message == "Automate all the things!"
