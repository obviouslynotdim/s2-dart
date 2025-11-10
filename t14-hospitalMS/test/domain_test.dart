import 'package:test/test.dart';
import 'package:uuid/uuid.dart';
import '../lib/domain/doctor.dart';
import '../lib/domain/patient.dart';
import '../lib/domain/appointment.dart';
import '../lib/domain/working_hours.dart';
import '../lib/data/hospital_repo.dart';

const uuid = Uuid();

void main() {
  group('Hospital Domain Tests', () {
    late HospitalRepository repo;

    setUp(() {
      repo = HospitalRepository();
    });

    test('Add and retrieve doctor', () {
      final doctor = Doctor(
        id: 'D-1234',
        name: 'Dr. Alice',
        gender: 'F',
        email: 'alice@example.com',
        phoneNumber: '0123456789',
        specialization: 'Cardiology',
        fees: 100.0,
      );

      repo.addDoctor(doctor);
      final doctors = repo.getAllDoctors();

      expect(doctors.length, 1);
      expect(doctors.first.name, 'Dr. Alice');
    });

    test('Add and retrieve patient', () {
      final patient = Patient(
        id: 'P-5678',
        name: 'Bob',
        gender: 'M',
        email: 'bob@example.com',
        phoneNumber: '0987654321',
        disease: 'Flu',
      );

      repo.addPatient(patient);
      final patients = repo.getAllPatients();

      expect(patients.length, 1);
      expect(patients.first.disease, 'Flu');
    });

    test('Add working hours to doctor', () {
      final wh = WorkingHours(
        doctorId: 'D-1234',
        day: 'Monday',
        startTime: '09:00',
        endTime: '17:00',
      );

      repo.addOrUpdateWorkingHours(wh);
      final hours = repo.getWorkingHours('D-1234');

      expect(hours.length, 1);
      expect(hours.first.day, 'Monday');
    });

    test('Schedule appointment', () {
      final doctor = Doctor(
        id: 'D-1234',
        name: 'Dr. Alice',
        gender: 'F',
        email: 'alice@example.com',
        phoneNumber: '0123456789',
        specialization: 'Cardiology',
        fees: 100.0,
      );
      final patient = Patient(
        id: 'P-5678',
        name: 'Bob',
        gender: 'M',
        email: 'bob@example.com',
        phoneNumber: '0987654321',
        disease: 'Flu',
      );

      repo.addDoctor(doctor);
      repo.addPatient(patient);

      final appointment = Appointment(
        id: 'A-0001',
        doctorId: doctor.id,
        patientId: patient.id,
        dateTime: DateTime(2025, 11, 10, 10, 0),
      );

      repo.addAppointment(appointment);
      final apptsDoctor = repo.findAppointmentsByDoctor(doctor.id);
      final apptsPatient = repo.findAppointmentsByPatient(patient.id);

      expect(apptsDoctor.length, 1);
      expect(apptsPatient.length, 1);
      expect(apptsDoctor.first.patientId, patient.id);
    });

    test('Cancel appointment', () {
      final appointment = Appointment(
        id: 'A-0002',
        doctorId: 'D-1234',
        patientId: 'P-5678',
        dateTime: DateTime(2025, 11, 11, 11, 0),
      );

      repo.addAppointment(appointment);
      expect(repo.findAppointmentsByDoctor('D-1234').length, 1);

      repo.removeAppointment('A-0002');
      expect(repo.findAppointmentsByDoctor('D-1234').length, 0);
    });

    test('Export data to JSON', () {
      final doctor = Doctor(
        id: 'D-1234',
        name: 'Dr. Alice',
        gender: 'F',
        email: 'alice@example.com',
        phoneNumber: '0123456789',
        specialization: 'Cardiology',
        fees: 100.0,
      );
      final patient = Patient(
        id: 'P-5678',
        name: 'Bob',
        gender: 'M',
        email: 'bob@example.com',
        phoneNumber: '0987654321',
        disease: 'Flu',
      );
      repo.addDoctor(doctor);
      repo.addPatient(patient);

      final json = repo.exportToJson();
      expect(json.contains('Dr. Alice'), true);
      expect(json.contains('Bob'), true);
    });
  });
}
