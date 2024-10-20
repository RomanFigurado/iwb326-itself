import ballerina/http;
import ballerina/sql;
import ballerina/time;
import ballerinax/mysql;

public type AppointmentLawyer record {|
    int appointment_id?;
    int user_id;
    int lawyer_id;
    int phone_number;
    string email;
    time:Date appointment_date;
    string status;
|};

configurable string USER6 = "root";
configurable string PASSWORD6 = "Thusitha@123";
configurable string HOST6 = "localhost";
configurable int PORT6 = 3306;
configurable string DATABASE6 = "law_firm";

public final mysql:Client dbClient6 = check new (
    host = HOST6, user = USER6, password = PASSWORD6, port = PORT6, database = DATABASE6
);

//Get all appointment
isolated function getAllAppointmentsByUser() returns AppointmentLawyer[]|error {
    AppointmentLawyer[] appointments = [];
    stream<AppointmentLawyer, error?> resultStream = dbClient6->query(
        `SELECT * FROM Appointments`
    );
    check from AppointmentLawyer appointment in resultStream
        do {
            appointments.push(appointment);
        };

    check resultStream.close();
    return appointments;
}

// Update the status
isolated function updateAppointmentStatus(int appointmentId, string status) returns int|error {
    sql:ExecutionResult result = check dbClient6->execute(` 
        UPDATE Appointments 
        SET status = ${status} 
        WHERE appointment_id = ${appointmentId} 
    `);
    int? affectedRowCount = result.affectedRowCount;
    if affectedRowCount is int {
        return affectedRowCount;
    } else {
        return error("Unable to obtain the affected row count");
    }
}

service /appointmentslawyer on new http:Listener(8085) {

    // GET resource to retrieve all appointments
    isolated resource function get .() returns AppointmentLawyer[]|error? {
        return getAllAppointmentsByUser();
    }

    // Endpoint to update the status of an appointment

    isolated resource function post [int appointmentId]/update(@http:Query string status) returns int|error? {
        return updateAppointmentStatus(appointmentId, status);
    }

}
