import ballerina/http;
import ballerina/sql;
import ballerina/time;
import ballerinax/mysql;

// Define the Payment record type
public type PaymentClient record {|
    int payment_id?;
    int user_id;
    int lawyer_id;
    decimal amount;
    string payment_type; // "purchase" or "hire"
    time:Utc? transaction_date;
|};

// Database configuration
configurable string USER3 = "root";
configurable string PASSWORD3 = "Thusitha@123";
configurable string HOST3 = "localhost";
configurable int PORT3 = 3306;
configurable string DATABASE3 = "law_firm";

// Create a MySQL client
final mysql:Client dbClient3 = check new (
    host = HOST3, user = USER3, password = PASSWORD3, port = PORT3, database = DATABASE3
);

// Function to add a new payment
isolated function addPayment(PaymentClient payment) returns int|error {

    sql:ExecutionResult result = check dbClient3->execute(`
        INSERT INTO Payments (user_id,lawyer_id, amount, payment_type, transaction_date)
        VALUES (${payment.user_id},${payment.lawyer_id}, ${payment.amount}, ${payment.payment_type}, 
                ${payment.transaction_date})
    `);
    int|string? lastInsertId = result.lastInsertId;
    if lastInsertId is int {
        return lastInsertId;
    } else {
        return error("Unable to obtain last insert ID");
    }
}

// Function to get a payment by clientID
isolated function getPayment(int id) returns PaymentClient|error {
    PaymentClient payment = check dbClient3->queryRow(
        `SELECT * FROM Payments WHERE user_id = ${id}`
    );
    return payment;
}

// Define the HTTP service for payment-related endpoints
service /paymentsclient on new http:Listener(8082) {

    // POST resource to add a new payment
    isolated resource function post .(@http:Payload PaymentClient payment) returns int|error? {
        return addPayment(payment);
    }

    // GET resource to retrieve a single payment by clientID
    isolated resource function get [int id]() returns PaymentClient|error? {
        return getPayment(id);
    }
}
