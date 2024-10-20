import ballerina/http;
import ballerina/sql;
import ballerinax/mysql;

// Define the Review record type
public type ReviewClient record {|
    int id?;
    int client_id;
    int lawyer_id;
    decimal rating;
    string comments?;
|};

// Database configuration
configurable string USER5 = "root";
configurable string PASSWORD5 = "Thusitha@123";
configurable string HOST5 = "localhost";
configurable int PORT5 = 3306;
configurable string DATABASE5 = "law_firm";

// Create a MySQL client
final mysql:Client dbClient5 = check new (
    host = HOST5, user = USER5, password = PASSWORD5, port = PORT5, database = DATABASE5
);

// Add a new review
isolated function addReview(ReviewClient review) returns int|error {
    sql:ExecutionResult result = check dbClient5->execute(`
        INSERT INTO Reviews (client_id, lawyer_id, rating, comments)
        VALUES (${review.client_id}, ${review.lawyer_id}, ${review.rating}, ${review.comments})
    `);
    int|string? lastInsertId = result.lastInsertId;
    if lastInsertId is int {
        return lastInsertId;
    } else {
        return error("Unable to obtain last insert ID");
    }
}

// Get a review by ID
isolated function getReview(int id) returns ReviewClient|error {
    ReviewClient review = check dbClient5->queryRow(
        `SELECT * FROM Reviews WHERE lawyer_id = ${id}`
    );
    return review;
}

// Get all reviews
isolated function getAllReviews(int id) returns ReviewClient[]|error {
    ReviewClient[] reviews = [];
    stream<ReviewClient, error?> resultStream = dbClient5->query(
        `SELECT * FROM Reviews WHERE lawyer_id = ${id}`
    );
    check from ReviewClient review in resultStream
        do {
            reviews.push(review);
        };
    check resultStream.close();
    return reviews;
}

// Update a review by ID
isolated function updateReview(ReviewClient review) returns int|error {
    sql:ExecutionResult result = check dbClient5->execute(`
        UPDATE Reviews SET
            client_id = ${review.client_id}, 
            lawyer_id = ${review.lawyer_id},
            rating = ${review.rating},
            comments = ${review.comments}
        WHERE id = ${review.id}
    `);
    int? affectedRowCount = result.affectedRowCount;
    if affectedRowCount is int {
        return affectedRowCount;
    } else {
        return error("Unable to update review");
    }
}

// Delete a review by ID
isolated function removeReview(int id) returns int|error {
    sql:ExecutionResult result = check dbClient5->execute(`
        DELETE FROM Reviews WHERE id = ${id}
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
// Define the HTTP service
service /reviewsclient on new http:Listener(8084) {

    // POST resource to add a new review
    isolated resource function post .(@http:Payload ReviewClient review) returns int|error? {
        return addReview(review);
    }

    // GET resource to retrieve a single review by ID
    // isolated resource function get [int id]() returns ReviewClient|error? {
    //     return getReview(id);
    // }

    // GET resource to retrieve all reviews
    isolated resource function get [int id]() returns ReviewClient[]|error? {
        return getAllReviews(id);
    }

    // PUT resource to update a review
    isolated resource function put .(@http:Payload ReviewClient review) returns int|error? {
        return updateReview(review);
    }

    // DELETE resource to remove a review by ID
    isolated resource function delete [int id]() returns int|error? {
        return removeReview(id);
    }
}
