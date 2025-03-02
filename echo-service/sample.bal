import ballerina/http;

// Read environment variables
configurable string serviceURL = "https://eee550ec-010e-41aa-8160-5e2e8c0a1416-dev.e1-us-east-azure.st.choreoapis.dev/default/hello-world/v1";
configurable string consumerKey = "uFL6SLNJilHGQqc5aUJyMPDflrfC";
configurable string consumerSecret = "9jUKvvv9DDGXqJF9akNMpnBTJ8zl";
configurable string tokenURL = "https://eee550ec-010e-41aa-8160-5e2e8c0a1416-dev.e1-us-east-azure.st.choreosts.dev/oauth2/token";

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
        string response = check httpClient->get("/greeting");
        return response;
    }
}
