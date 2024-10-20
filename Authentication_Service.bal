import ballerina/http;
import ballerina/sql;
import ballerinax/mysql;

// Define the User record type
public type User record {|
    int user_id?;
    string first_name;
    string last_name;
    string email;
    string password; // Store password in hashed form in production 
    string role; // client or lawyer 
|};

// Define a SignIn record type
public type SignIn record {|
    string email;
    string password;
|};

// Database configuration
configurable string USER2 = "root";
configurable string PASSWORD2 = "Thusitha@123";
configurable string HOST2 = "localhost";
configurable int PORT2 = 3306;
configurable string DATABASE2 = "law_firm";

// Initialize the MySQL client
public final mysql:Client dbClient2 = check new (
    host = HOST2, user = USER2, password = PASSWORD2, port = PORT2, database = DATABASE2
);

// Function to register a new user
isolated function registerUser(User user) returns int|error {
    sql:ExecutionResult result = check dbClient2->execute(`
        INSERT INTO Users (first_name, last_name, email, password, role) 
        VALUES (${user.first_name}, ${user.last_name}, ${user.email}, ${user.password}, ${user.role})
    `);
    int|string? lastInsertId = result.lastInsertId;
    if lastInsertId is int {
        return lastInsertId;
    } else {
        return error("Unable to obtain last insert ID");
    }
}

// Function to authenticate a user based on email and password
isolated function loginUser(string email, string password) returns User|error {
    User[] users = []; // Renamed for clarity
    stream<User, error?> resultStream = dbClient2->query(`
        SELECT * FROM Users WHERE email = ${email} AND password = ${password}
    `);

    // Iterate over the stream and assign the first user to the 'users' array
    check from User usr in resultStream
        do {
            users.push(usr);
            return usr; // Return the user object on the first match
        };

    check resultStream.close(); // Close the stream

    // If no user was found, return an error
    return error("Invalid email or password");
}

// Function to log out a user (dummy function for logging purposes)
isolated function logoutUser(string email) returns string {
    return "User " + email + " logged out successfully.";
}

// Define the HTTP service for sign-in and sign-up related endpoints
service /auth on new http:Listener(8081) {

    // CORS preflight handling
    resource function options signup(http:Caller caller, http:Request req) returns error? {
        return handleCORSPreflight(caller);
    }

    resource function options signin(http:Caller caller, http:Request req) returns error? {
        return handleCORSPreflight(caller);
    }

    resource function options logout(http:Caller caller, http:Request req) returns error? {
        return handleCORSPreflight(caller);
    }

    // Endpoint to register a new user
    isolated resource function post signup(http:Caller caller, @http:Payload User user) returns error? {
        int result = check registerUser(user);
        json response = {message: "User signed up successfully", userId: result};

        http:Response res = new;
        res.setJsonPayload(response);

        // Add CORS headers
        addCORSHeaders(res);

        return caller->respond(res);
    }

    // Endpoint to authenticate a user by verifying credentials in the database
    isolated resource function post signin(http:Caller caller, @http:Payload SignIn signInData) returns error? {
        http:Response res = new;
        addCORSHeaders(res); // Function to add CORS headers

        User|error userResult = loginUser(signInData.email, signInData.password);
        if (userResult is User) {
            res.setJsonPayload(userResult); // Return user data as JSON
            return caller->respond(res); // Send response to caller
        } else {
            res.statusCode = 401; // Unauthorized
            json response = {message: "Invalid email or password"};
            res.setJsonPayload(response); // Set error response
            return caller->respond(res); // Respond with error
        }
    }

    // Endpoint to log out a user (dummy function for logging purposes)
    isolated resource function post logout(http:Caller caller, http:Request req, @http:Query string email) returns error? {
        string result = logoutUser(email);
        json response = {message: result};

        http:Response res = new;
        res.setJsonPayload(response);

        // Add CORS headers
        addCORSHeaders(res);

        return caller->respond(res);
    }
}

// Function to handle CORS preflight requests
isolated function handleCORSPreflight(http:Caller caller) returns error? {
    http:Response res = new;
    addCORSHeaders(res);
    res.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
    res.setHeader("Access-Control-Allow-Headers", "Content-Type");

    return caller->respond(res);
}

// Isolated function to add CORS headers
isolated function addCORSHeaders(http:Response res) {
    res.setHeader("Access-Control-Allow-Origin", "*");
    res.setHeader("Access-Control-Allow-Methods", "GET, POST, OPTIONS");
    res.setHeader("Access-Control-Allow-Headers", "Content-Type");
}
