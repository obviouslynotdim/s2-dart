import 'package:test/test.dart';
import 'package:uuid/uuid.dart';
import '../lib/domain/doctor.dart';
import '../lib/domain/patient.dart';
import '../lib/domain/appointment.dart';
import '../lib/domain/working_hours.dart';
import '../lib/domain/hospital_repo.dart';

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
        name: 'Dr. JC',
        gender: 'M',
        email: 'alice@example.com',
        phoneNumber: '012880880',
        specialization: 'Cardiology',
        fees: 100.0,
      );

      repo.addDoctor(doctor);
      final doctors = repo.getAllDoctors();

      expect(doctors.length, 1);
      expect(doctors.first.name, 'Dr. JC');
    });

    test('Add and retrieve patient', () {
      final patient = Patient(
        id: 'P-5678',
        name: 'Dim',
        gender: 'M',
        email: 'dim@example.com',
        phoneNumber: '098545602',
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
        name: 'Dr. Jen',
        gender: 'F',
        email: 'Jen@example.com',
        phoneNumber: '012487122',
        specialization: 'Cardiology',
        fees: 100.0,
      );
      final patient = Patient(
        id: 'P-5678',
        name: 'Benz',
        gender: 'M',
        email: 'benz@example.com',
        phoneNumber: '091856634',
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
        name: 'Dr. Jen',
        gender: 'F',
        email: 'jen123@example.com',
        phoneNumber: '01224873',
        specialization: 'Cardiology',
        fees: 100.0,
      );
      final patient = Patient(
        id: 'P-5678',
        name: 'Pop',
        gender: 'M',
        email: 'pop11@example.com',
        phoneNumber: '097889201',
        disease: 'Flu',
      );
      repo.addDoctor(doctor);
      repo.addPatient(patient);

      final json = repo.exportToJson();
      expect(json.contains('Dr. Jen'), true);
      expect(json.contains('Pop'), true);
    });
  });
}

