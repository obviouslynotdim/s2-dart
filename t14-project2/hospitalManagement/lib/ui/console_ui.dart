import 'dart:io';
import 'package:uuid/uuid.dart';
import '../domain/doctor.dart';
import '../domain/patient.dart';
import '../domain/appointment.dart';
import '../domain/working_hours.dart';
import '../data/hospital_repo.dart';

const uuid = Uuid();

class ConsoleUI {
  final HospitalRepository repo;

  ConsoleUI(this.repo);

  void start() {
    int choice;
    do {
      print('\n================= Hospital Management =================');
      print('1. Doctor Management');
      print('2. Patient Management');
      print('3. Appointment Management');
      print('4. Export All Data (JSON)');
      print('5. Exit');
      stdout.write('Enter your choice: ');
      choice = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

      switch (choice) {
        case 1:
          _doctorMenu();
          break;
        case 2:
          _patientMenu();
          break;
        case 3:
          _appointmentMenu();
          break;
        case 4:
          _exportData();
          break;
        case 5:
          print('Exiting system...');
          return;
        default:
          print('Invalid choice. Please try again.');
      }
    } while (true);
  }

  // ----------------------------------------------------------
  // DOCTOR MENU
  // ----------------------------------------------------------
  void _doctorMenu() {
    int choice;
    do {
      print('\n--- Doctor Menu ---');
      print('1. Add Doctor');
      print('2. View All Doctors');
      print('3. Assign Working Hours');
      print('4. Back');
      stdout.write('Enter choice: ');
      choice = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

      switch (choice) {
        case 1:
          _addDoctor();
          break;
        case 2:
          _displayDoctors();
          break;
        case 3:
          _addWorkingHours();
          break;
        case 4:
          return;
        default:
          print('Invalid choice.');
      }
    } while (true);
  }

  void _addDoctor() {
    print('\n--- Add Doctor ---');
    final id = 'D-' + uuid.v4().substring(0, 4).toUpperCase();
    stdout.write('Name: ');
    final name = stdin.readLineSync() ?? '';
    stdout.write('Gender (M/F/O): ');
    final gender = stdin.readLineSync() ?? 'O';
    stdout.write('Email: ');
    final email = stdin.readLineSync() ?? '';
    stdout.write('Phone Number: ');
    final phone = stdin.readLineSync() ?? '';
    stdout.write('Specialization: ');
    final specialization = stdin.readLineSync() ?? '';
    stdout.write('Fees: ');
    final fees = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;

    final doctor = Doctor(
      id: id,
      name: name,
      gender: gender,
      email: email,
      phoneNumber: phone,
      specialization: specialization,
      fees: fees,
    );

    repo.addDoctor(doctor);
    print('SUCCESS: Doctor $id added.');
  }

  void _displayDoctors() {
    final doctors = repo.getAllDoctors();
    if (doctors.isEmpty) {
      print('No doctors found.');
      return;
    }
    print('\n--- Registered Doctors ---');
    for (var d in doctors) {
      d.displayInfo();
    }
  }

  void _addWorkingHours() {
    stdout.write('Enter Doctor ID: ');
    final id = stdin.readLineSync()?.toUpperCase() ?? '';
    stdout.write('Day (e.g., Monday): ');
    final day = stdin.readLineSync() ?? '';
    stdout.write('Start Time (HH:MM): ');
    final start = stdin.readLineSync() ?? '';
    stdout.write('End Time (HH:MM): ');
    final end = stdin.readLineSync() ?? '';

    final wh = WorkingHours(
      doctorId: id,
      day: day,
      startTime: start,
      endTime: end,
    );

    repo.addWorkingHours(wh);
    print('SUCCESS: Working hours added.');
  }

  // ----------------------------------------------------------
  // PATIENT MENU
  // ----------------------------------------------------------
  void _patientMenu() {
    int choice;
    do {
      print('\n--- Patient Menu ---');
      print('1. Add Patient');
      print('2. View All Patients');
      print('3. Back');
      stdout.write('Enter choice: ');
      choice = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

      switch (choice) {
        case 1:
          _addPatient();
          break;
        case 2:
          _displayPatients();
          break;
        case 3:
          return;
        default:
          print('Invalid choice.');
      }
    } while (true);
  }

  void _addPatient() {
    print('\n--- Add Patient ---');
    final id = 'P-' + uuid.v4().substring(0, 4).toUpperCase();
    stdout.write('Name: ');
    final name = stdin.readLineSync() ?? '';
    stdout.write('Phone Number: ');
    final phone = stdin.readLineSync() ?? '';
    stdout.write('Gender (M/F/O): ');
    final gender = stdin.readLineSync() ?? 'O';
    stdout.write('Email: ');
    final email = stdin.readLineSync() ?? '';
    stdout.write('Disease: ');
    final disease = stdin.readLineSync() ?? '';

    final patient = Patient(
      id: id,
      name: name,
      phoneNumber: phone,
      gender: gender,
      email: email,
      disease: disease,
    );
    repo.addPatient(patient);
    print('SUCCESS: Patient $id added.');
  }

  void _displayPatients() {
    final patients = repo.getAllPatients();
    if (patients.isEmpty) {
      print('No patients found.');
      return;
    }
    print('\n--- Registered Patients ---');
    for (var p in patients) {
      p.displayInfo();
    }
  }

  // ----------------------------------------------------------
  // APPOINTMENT MENU
  // ----------------------------------------------------------
  void _appointmentMenu() {
    int choice;
    do {
      print('\n--- Appointment Menu ---');
      print('1. Schedule Appointment');
      print('2. View Doctor Schedule');
      print('3. View Patient Appointments');
      print('4. Cancel Appointment');
      print('5. Back');
      stdout.write('Enter choice: ');
      choice = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

      switch (choice) {
        case 1:
          _scheduleAppointment();
          break;
        case 2:
          _viewDoctorSchedule();
          break;
        case 3:
          _viewPatientAppointments();
          break;
        case 4:
          _cancelAppointment();
          break;
        case 5:
          return;
        default:
          print('Invalid choice.');
      }
    } while (true);
  }

  void _scheduleAppointment() {
    stdout.write('Enter Patient ID: ');
    final patientId = stdin.readLineSync()?.toUpperCase() ?? '';
    stdout.write('Enter Doctor ID: ');
    final doctorId = stdin.readLineSync()?.toUpperCase() ?? '';
    stdout.write('Enter Date/Time (DD/MM/YYYY HH:MM): ');
    final dtString = stdin.readLineSync() ?? '';

    try {
      final parts = dtString.trim().split(RegExp(r'[/\s:]+'));
      if (parts.length < 5) throw Exception('Invalid date format.');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      final hour = int.parse(parts[3]);
      final minute = int.parse(parts[4]);
      final dateTime = DateTime(year, month, day, hour, minute);

      final appointment = Appointment(
        id: 'A-' + uuid.v4().substring(0, 6).toUpperCase(),
        patientId: patientId,
        doctorId: doctorId,
        dateTime: dateTime,
      );

      repo.addAppointment(appointment);
      print('SUCCESS: Appointment ${appointment.id} scheduled.');
    } catch (e) {
      print('ERROR: ${e.toString()}');
    }
  }

  void _viewDoctorSchedule() {
    stdout.write('Enter Doctor ID: ');
    final id = stdin.readLineSync()?.toUpperCase() ?? '';
    final appts = repo.findAppointmentsByDoctor(id);
    if (appts.isEmpty) {
      print('No appointments found for doctor $id.');
    } else {
      appts.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      print('\n--- Doctor Schedule (${appts.length}) ---');
      for (var a in appts) print(a);
    }
  }

  void _viewPatientAppointments() {
    stdout.write('Enter Patient ID: ');
    final id = stdin.readLineSync()?.toUpperCase() ?? '';
    final appts = repo.findAppointmentsByPatient(id);
    if (appts.isEmpty) {
      print('No appointments found for patient $id.');
    } else {
      appts.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      print('\n--- Patient Appointments (${appts.length}) ---');
      for (var a in appts) print(a);
    }
  }

  void _cancelAppointment() {
    stdout.write('Enter Appointment ID to cancel: ');
    final id = stdin.readLineSync()?.toUpperCase() ?? '';
    repo.removeAppointment(id);
    print('Appointment $id canceled.');
  }

  void _exportData() {
    final jsonData = repo.exportToJson();
    final file = File('hospital_data.json');
    file.writeAsStringSync(jsonData);
    print('All data exported to hospital_data.json');
  }
}
