import ballerina/http;
import ballerina/io;

// Read environment variables

configurable string serviceURL = os:getEnv("CHOREO_ECHOTOHELLOCONNECTION_SERVICEURL");
configurable string consumerKey = os:getEnv("CHOREO_ECHOTOHELLOCONNECTION_CONSUMERKEY");
configurable string consumerSecret = os:getEnv("CHOREO_ECHOTOHELLOCONNECTION_CONSUMERSECRET");
configurable string tokenURL = os:getEnv("CHOREO_ECHOTOHELLOCONNECTION_TOKENURL");
configurable string choreoApiKey = os:getEnv("CHOREO_ECHOTOHELLOCONNECTION_APIKEY");

// Create OAuth2 client with client ID, client secret and token URL
http:Client httpClient = check new (serviceURL,
  auth = {
    tokenUrl: tokenURL,
    clientId: consumerKey,
    clientSecret: consumerSecret
  }
);

service / on new http:Listener(8090) {
    resource function post .(@http:Payload string textMsg) returns string|error {
        io:println("Received message: " + textMsg);
        string response = check httpClient->get("/greeting", {"Choreo-API-Key": choreoApiKey});
        io:println("Response from the service: " + response);
        return response;
    }
}
