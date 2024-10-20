import ballerina/http;
import ballerinax/mysql;

// Define the Review record type
public type ReviewLawyer record {|
    int id?;
    int client_id;
    int lawyer_id;
    decimal rating;
    string comments?;
|};

// Database configuration
configurable string USER7 = "root";
configurable string PASSWORD7 = "Thusitha@123";
configurable string HOST7 = "localhost";
configurable int PORT7 = 3306;
configurable string DATABASE7 = "law_firm";

// Create a MySQL client
final mysql:Client dbClient7 = check new (
    host = HOST7, user = USER7, password = PASSWORD7, port = PORT7, database = DATABASE7
);

// Get all reviews
isolated function getAllReviewslawyer() returns ReviewLawyer[]|error {
    ReviewLawyer[] reviews = [];
    stream<ReviewLawyer, error?> resultStream = dbClient7->query(
        `SELECT * FROM Reviews`
    );
    check from ReviewLawyer review in resultStream
        do {
            reviews.push(review);
        };
    check resultStream.close();
    return reviews;
}

service /reviewslawyer on new http:Listener(8086) {
    isolated resource function get .() returns ReviewLawyer[]|error? {
        return getAllReviewslawyer();
    }

}
