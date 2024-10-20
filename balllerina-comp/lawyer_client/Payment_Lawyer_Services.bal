import ballerina/http;
import ballerina/time;
import ballerinax/mysql;

// Define the Payment record type
public type PaymentLawyer record {|
    int payment_id?;
    int user_id;
    int lawyer_id;
    decimal amount;
    string payment_type; // "purchase" or "hire"
    time:Utc? transaction_date;
|};

// Database configuration
configurable string USER8 = "root";
configurable string PASSWORD8 = "Thusitha@123";
configurable string HOST8 = "localhost";
configurable int PORT8 = 3306;
configurable string DATABASE8 = "law_firm";

// Create a MySQL client
final mysql:Client dbClient8 = check new (
    host = HOST8, user = USER8, password = PASSWORD8, port = PORT8, database = DATABASE8
);

// Function to get a payment by lawyerID
isolated function getPaymentlawyer(int id) returns PaymentLawyer|error {
    PaymentLawyer payment = check dbClient8->queryRow(
        `SELECT * FROM Payments WHERE lawyer_id = ${id}`
    );
    return payment;
}

service /paymentslawyer on new http:Listener(8087) {

    // GET resource to retrieve a single payment by lawyerID
    isolated resource function get [int id]() returns PaymentLawyer|error? {
        return getPaymentlawyer(id);
    }
}
