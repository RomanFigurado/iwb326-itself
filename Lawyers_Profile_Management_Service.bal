import ballerina/http;
import ballerina/sql;
import ballerinax/mysql;

public type LawyerProfile record {|
    int user_id?; // Make user_id optional if it is auto-generated
    string first_name;
    string last_name;
    string email;
    string role; // client or lawyer, use "lawyer" for this
    string? expertise; // specific areas of expertise
    decimal? fees; // fees charged by the lawyer
    boolean? availability; // availability of the lawyer
|};

configurable string USER4 = "root";
configurable string PASSWORD4 = "Thusitha@123";
configurable string HOST4 = "localhost";
configurable int PORT4 = 3306;
configurable string DATABASE4 = "law_firm";

public final mysql:Client dbClient4 = check new (
    host = HOST4, user = USER4, password = PASSWORD4, port = PORT4, database = DATABASE4
);

// Function to get a specific lawyer profile using user_id
isolated function getLawyerProfile(int userId) returns LawyerProfile|error {
    LawyerProfile profile = check dbClient4->queryRow(`
        SELECT user_id, first_name, last_name, email, role, expertise, fees, availability 
        FROM LawyerProfile WHERE user_id = ${userId}
    `);
    return profile;
}

isolated function getAllLawyerProfiles() returns LawyerProfile[]|error {
    LawyerProfile[] profiles = [];
    stream<LawyerProfile, error?> resultStream = dbClient7->query(
        `SELECT * FROM LawyerProfile`
    );
    check from LawyerProfile profile in resultStream
        do {
            profiles.push(profile);
        };
    check resultStream.close();
    return profiles;
}

// Function to add a new lawyer profile
isolated function addLawyerProfile(LawyerProfile profile) returns int|error {
    sql:ExecutionResult result = check dbClient4->execute(`
        INSERT INTO LawyerProfile (first_name, last_name, email, role, expertise, fees, availability) 
        VALUES (${profile.first_name}, ${profile.last_name}, ${profile.email}, 
                ${profile.role}, ${profile.expertise}, ${profile.fees}, ${profile.availability})
    `);

    int|string? lastInsertId = result.lastInsertId;
    if lastInsertId is int {
        return lastInsertId; // Return the new profile ID
    } else {
        return error("Unable to obtain last insert ID");
    }
}

// Function to update the profile of a lawyer
isolated function updateLawyerProfile(LawyerProfile profile) returns int|error {
    sql:ExecutionResult result = check dbClient4->execute(`
        UPDATE LawyerProfile SET
            first_name = ${profile.first_name},
            last_name = ${profile.last_name},
            email = ${profile.email},
            expertise = ${profile.expertise},
            fees = ${profile.fees},
            availability = ${profile.availability}
        WHERE user_id = ${profile.user_id}
    `);

    int? affectedRowCount = result.affectedRowCount;
    if affectedRowCount is int {
        return affectedRowCount;
    } else {
        return error("Unable to obtain the affected row count");
    }
}

@http:ServiceConfig {
    cors: {
        allowOrigins: ["*"]
    }
}
// Define the HTTP service for lawyer profiles
service /lawyerprofile on new http:Listener(8083) {

    // Endpoint to get a specific lawyer profile
    isolated resource function get [int userId]() returns LawyerProfile|error? {
        return getLawyerProfile(userId);
    }

    isolated resource function get .() returns LawyerProfile[]|error? {
        return getAllLawyerProfiles();
    }

    // Endpoint to add a new lawyer profile
    isolated resource function post .(@http:Payload LawyerProfile profile) returns int|error? {
        return addLawyerProfile(profile);
    }

    // Endpoint to update the profile of a lawyer
    isolated resource function put [int userId]/update(@http:Payload LawyerProfile profile) returns int|error? {
        return updateLawyerProfile(profile);
    }
}
