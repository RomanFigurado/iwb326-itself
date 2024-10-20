import ballerina/http;
import ballerina/sql;
import ballerina/time;
import ballerinax/mysql;

// Define the ClientProfile record type 
public type ClientProfile record {|
    int user_id?; // Make user_id optional if it is auto-generated
    string first_name;
    string last_name;
    string email;
    string role; // should be "client"
    string gender;
    time:Date date_of_birth;
|};

configurable string USER9 = "root";
configurable string PASSWORD9 = "Thusitha@123";
configurable string HOST9 = "localhost";
configurable int PORT9 = 3306;
configurable string DATABASE9 = "law_firm";

// Initialize MySQL client
public final mysql:Client dbClient9 = check new (
    host = HOST9, user = USER9, password = PASSWORD9, port = PORT9, database = DATABASE9
);

// Function to get a specific client profile using user_id
isolated function getClientProfile(int userId) returns ClientProfile|error {
    ClientProfile profile = check dbClient9->queryRow(`
        SELECT * FROM clientprofile WHERE user_id = ${userId}
    `);
    return profile;
}

// Function to add a new client profile
isolated function addClientProfile(ClientProfile profile) returns int|error {
    sql:ExecutionResult result = check dbClient9->execute(`
        INSERT INTO clientprofile (first_name, last_name, email, role, date_of_birth, gender) 
        VALUES (${profile.first_name}, ${profile.last_name}, ${profile.email}, ${profile.role}, ${profile.date_of_birth}, ${profile.gender})
    `);

    int|string? lastInsertId = result.lastInsertId;
    if lastInsertId is int {
        return lastInsertId; // Return the new profile ID
    } else {
        return error("Unable to obtain last insert ID");
    }
}

// Function to update the profile of a client
isolated function updateClientProfile(ClientProfile profile) returns int|error {
    sql:ExecutionResult result = check dbClient9->execute(`
        UPDATE clientprofile SET
            first_name = ${profile.first_name},
            last_name = ${profile.last_name},
            email = ${profile.email},
            date_of_birth = ${profile.date_of_birth},
            gender = ${profile.gender}
        WHERE user_id = ${profile.user_id}
    `);

    int? affectedRowCount = result.affectedRowCount;
    if affectedRowCount is int {
        return affectedRowCount;
    } else {
        return error("Unable to obtain the affected row count");
    }
}

// Define the HTTP service for client profiles
service /clientprofile on new http:Listener(8088) {

    // Endpoint to get a specific client profile
    isolated resource function get [int userId]() returns ClientProfile|error? {
        return getClientProfile(userId);
    }

    // Endpoint to add a new client profile
    isolated resource function post .(@http:Payload ClientProfile profile) returns int|error? {
        return addClientProfile(profile);
    }

    // Endpoint to update the profile of a client
    isolated resource function put [int userId]/update(@http:Payload ClientProfile profile) returns int|error? {
        return updateClientProfile(profile);
    }
}
