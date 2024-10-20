import ballerina/http;
import ballerina/sql;
import ballerina/time;
import ballerinax/mysql;

public type AppointmentClient record {|
    int appointment_id?;
    int user_id;
    int lawyer_id;
    int phone_number;
    string email;
    time:Date appointment_date;
    string status;
|};

configurable string USER = "root";
configurable string PASSWORD = "Thusitha@123";
configurable string HOST = "localhost";
configurable int PORT = 3306;
configurable string DATABASE = "law_firm";

public final mysql:Client dbClient1 = check new (
    host = HOST, user = USER, password = PASSWORD, port = PORT, database = DATABASE
);

// Function to request a new appointment
isolated function requestAppointment(AppointmentClient appointment) returns int|error {
    sql:ExecutionResult result = check dbClient1->execute(` 
        INSERT INTO Appointments (user_id, lawyer_id,phone_number,email, appointment_date, status) 
        VALUES (${appointment.user_id}, ${appointment.lawyer_id},${appointment.phone_number},${appointment.email}, ${appointment.appointment_date}, ${appointment.status}) 
    `);
    int|string? lastInsertId = result.lastInsertId;
    if lastInsertId is int {
        return lastInsertId;
    } else {
        return error("Unable to obtain last insert ID");
    }
}

// Function to get all appointments for a specific user
isolated function getAppointmentsByUser(int userId) returns AppointmentClient[]|error {
    AppointmentClient[] appointments = [];
    stream<AppointmentClient, error?> resultStream = dbClient1->query(
        `SELECT * FROM Appointments WHERE user_id = ${userId}`
    );
    check from AppointmentClient appointment in resultStream
        do {
            appointments.push(appointment);
        };
    check resultStream.close();
    return appointments;
}

service /appointmentsclient on new http:Listener(8080) {

    // Endpoint to request a new appointment
    isolated resource function post .(@http:Payload AppointmentClient appointment) returns int|error? {
        return requestAppointment(appointment);
    }

    // Endpoint to get all appointments for a specific user
    isolated resource function get [int userId]() returns AppointmentClient[]|error? {
        return getAppointmentsByUser(userId);
    }

}
