import 'dart:io';
import 'package:uuid/uuid.dart';
import '../domain/doctor.dart';
import '../domain/patient.dart';
import '../domain/appointment.dart';
import '../domain/working_hours.dart';
import '../domain/hospital_repo.dart';

const uuid = Uuid();

class ConsoleUI {
  final HospitalRepository repo;

  ConsoleUI(this.repo);

  // Helper function to ask for input, showing old value
  String _prompt(String label, String oldValue) {
    stdout.write('$label (Currently: $oldValue) [Press Enter to keep]: ');
    final input = stdin.readLineSync() ?? '';
    return input.isEmpty ? oldValue : input;
  }

  // helper to format DateTime without milliseconds (.000)
  String _formatDateTime(DateTime dt) {
    // Converts to string and splits by the decimal point, returning the first part
    return dt.toString().split('.').first;
  }

  void _loadDataOnStartup() {
    const filePath = 'data/hospital_data.json';
    final file = File(filePath);

    // Ensure the data directory exists
    final directory = Directory('data/');
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    if (file.existsSync()) {
      try {
        final jsonString = file.readAsStringSync();
        // Only attempt to import if the file has content other than an empty JSON object
        if (jsonString.isNotEmpty && jsonString.trim() != '{}') {
          // Assumes repo.importFromJson is implemented in hospital_repo.dart
          repo.importFromJson(jsonString);
          print("Data successfully loaded from $filePath");
        }
      } catch (e) {
        print("error");
      }
    }
  }

  void _exportData() {
    final jsonData = repo.exportToJson();

    // Ensures this path matches the load path
    const directoryPath = 'data/';
    final directory = Directory(directoryPath);

    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    final filePath = '$directoryPath/hospital_data.json';
    final file = File(filePath);

    file.writeAsStringSync(jsonData);
  }

  // start menu
  void start() {
    _loadDataOnStartup();

    int choice;
    do {
      print('\n================= Hospital Management =================');
      print('1. Doctor Management');
      print('2. Patient Management');
      print('3. Appointment Management');
      print('4. Exit(Auto Save)');
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
          print('Exiting system...');
          return;
        default:
          print('Invalid choice. Please try again.');
      }
    } while (true);
  }

// === DOCTOR MENU ===
  void _doctorMenu() {
    int choice;
    do {
      print('\n=== Doctor Menu ===');
      print('1. Add Doctor');
      print('2. View All Doctors (with Working Hours)');
      print('3. Assign/Update Doctor Working Hours');
      print('4. Remove Doctor Working Hours');
      print('5. Edit Doctor');
      print('6. Back');
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
          _removeWorkingHours();
          break;
        case 5:
          _editDoctor();
          break;
        case 6:
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
    stdout.write('Gender (M/F/Other): ');
    final gender = (stdin.readLineSync() ?? 'Other').toUpperCase();
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
    print('\n== Registered Doctors (${doctors.length}) ==');
    for (var d in doctors) {
      d.displayInfo();
      // Display their working hours
      final hours = repo.getWorkingHours(d.id);
      if (hours.isEmpty) {
        print('- Working Hours: Not Assigned');
      } else {
        print('=> Working Hours:');
        // WorkingHours toString() is used here
        for (var wh in hours) {
          print(' $wh');
        }
      }
      print('-------------------------');
    }
  }

  // Helper to standardize day names (Mon -> Monday)
  String _normalizeDayName(String day) {
    final normalized = day.toLowerCase();

    // Use a switch statement to convert shorthands or partial names to full names
    switch (normalized.substring(0, 3)) {
      case 'mon':
        return 'Monday';
      case 'tue':
        return 'Tuesday';
      case 'wed':
        return 'Wednesday';
      case 'thu':
        return 'Thursday';
      case 'fri':
        return 'Friday';
      case 'sat':
        return 'Saturday';
      case 'sun':
        return 'Sunday';
      default:
        // If the name is already a full name or unknown, return it as is
        return day;
    }
  }

  // handles 'Monday-Friday' regardless of spaces/case
  void _addWorkingHours() {
    stdout.write('Enter Doctor ID: ');
    final id = stdin.readLineSync()?.toUpperCase() ?? '';

    stdout.write('Day(s) (e.g., Monday, Mon, or Monday-Friday): ');
    final dayInput = (stdin.readLineSync() ?? '').trim();

    stdout.write('Start Time (HH:MM): ');
    final start = stdin.readLineSync() ?? '';
    stdout.write('End Time (HH:MM): ');
    final end = stdin.readLineSync() ?? '';

    List<String> daysToAdd = [];

    // remove spaces and check the special keyword
    final normalizedInput = dayInput.toLowerCase().replaceAll(' ', '');
    if (normalizedInput == 'monday-friday') {
      // Handle the "Monday-Friday" keyword
      daysToAdd = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'];
    } else {
      // Handle single day or comma-separated lists (like "Mon, Fri")
      daysToAdd = dayInput
          .split(',')
          .map((d) => d.trim())
          .where((d) => d.isNotEmpty)
          .toList();
    }

    if (daysToAdd.isEmpty) {
      print('ERROR: No valid days were entered.');
      return;
    }

    // Loop through the final list of days and add hours for each one
    for (final day in daysToAdd) {
      // standardize the day name before saving
      final standardizedDay = _normalizeDayName(day);

      final wh = WorkingHours(
        doctorId: id,
        day: standardizedDay, // Pass the standardized name
        startTime: start,
        endTime: end,
      );

      // Assumes repo.addOrUpdateWorkingHours is implemented to replace old hours
      repo.addOrUpdateWorkingHours(wh);
    }

    print('SUCCESS: Working hours added for: ${daysToAdd.join(', ')}.');
  }

  void _removeWorkingHours() {
    stdout.write('Enter Doctor ID: ');
    final id = stdin.readLineSync()?.toUpperCase() ?? '';

    stdout.write(
        'Enter Day to remove (e.g., Monday). Leave blank to remove ALL hours for this doctor: ');
    final dayInput = (stdin.readLineSync() ?? '').trim();

    if (dayInput.isEmpty) {
      // Remove all hours for the doctor
      repo.removeWorkingHours(id);
      print('SUCCESS: ALL working hours removed for Doctor $id.');
    } else {
      // Remove a specific day, utilizing the existing normalization helper
      final standardizedDay = _normalizeDayName(dayInput);

      repo.removeWorkingHours(id, day: standardizedDay);
      print(
          'SUCCESS: Working hours removed for Doctor $id on $standardizedDay.');
    }
  }

  void _editDoctor() {
    print('\n--- Edit Doctor ---');
    stdout.write('Enter Doctor ID to edit: ');
    final id = stdin.readLineSync()?.toUpperCase() ?? '';
    final doctor = repo.getDoctorById(id);

    if (doctor == null) {
      print('ERROR: Doctor $id not found.');
      return;
    }

    print('Editing details for ${doctor.name}. Press Enter to keep old value.');

    final name = _prompt('Name', doctor.name);
    final gender = _prompt('Gender', doctor.gender);
    final email = _prompt('Email', doctor.email);
    final phone = _prompt('Phone', doctor.phoneNumber);
    final specialization = _prompt('Specialization', doctor.specialization);
    final feesStr = _prompt('Fees', doctor.fees.toString());
    final fees = double.tryParse(feesStr) ?? doctor.fees;

    final updatedDoctor = doctor.copyWith(
      name: name,
      gender: gender,
      email: email,
      phoneNumber: phone,
      specialization: specialization,
      fees: fees,
    );

    repo.updateDoctor(updatedDoctor);
    print('SUCCESS: Doctor $id updated.');
  }

// == PATIENT MENU ==
  void _patientMenu() {
    int choice;
    do {
      print('\n--- Patient Menu ---');
      print('1. Add Patient');
      print('2. View All Patients');
      print('3. Edit Patient');
      print('4. Back');
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
          _editPatient();
          break;
        case 4:
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
    stdout.write('Gender (M/F/Other): ');
    final gender = (stdin.readLineSync() ?? 'Other').toUpperCase();
    stdout.write('Disease: ');
    final disease = stdin.readLineSync() ?? '';
    stdout.write('Email: ');
    final email = stdin.readLineSync() ?? '';
    stdout.write('Phone Number: ');
    final phone = stdin.readLineSync() ?? '';

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
    print('\n== Registered Patients (${patients.length}) ==');
    for (var p in patients) {
      p.displayInfo();
      print('-------------------------');
    }
  }

  void _editPatient() {
    print('\n--- Edit Patient ---');
    stdout.write('Enter Patient ID to edit: ');
    final id = stdin.readLineSync()?.toUpperCase() ?? '';
    final patient = repo.getPatientById(id);

    if (patient == null) {
      print('ERROR: Patient $id not found.');
      return;
    }

    print(
        'Editing details for ${patient.name}. Press Enter to keep old value.');

    final name = _prompt('Name', patient.name);
    final gender = _prompt('Gender', patient.gender);
    final disease = _prompt('Disease', patient.disease);
    final email = _prompt('Email', patient.email);
    final phone = _prompt('Phone', patient.phoneNumber);

    final updatedPatient = patient.copyWith(
      name: name,
      gender: gender,
      disease: disease,
      email: email,
      phoneNumber: phone,
    );

    repo.updatePatient(updatedPatient);
    print('SUCCESS: Patient $id updated.');
  }

// == APPOINTMENT MENU ==
  void _appointmentMenu() {
    int choice;
    do {
      print('\n=== Appointment Menu ===');
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

  // Uses the improved working hours logic for validation
  void _scheduleAppointment() {
    stdout.write('Enter Patient ID: ');
    final patientId = stdin.readLineSync()?.toUpperCase() ?? '';
    stdout.write('Enter Doctor ID: ');
    final doctorId = stdin.readLineSync()?.toUpperCase() ?? '';
    stdout.write('Enter Date/Time (DD/MM/YYYY HH:MM): ');
    final dtString = stdin.readLineSync() ?? '';

    try {
      // 1. parse the input date/time
      final parts = dtString.trim().split(RegExp(r'[/\s:]+'));
      if (parts.length < 5) throw Exception('Invalid date format.');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);
      final hour = int.parse(parts[3]);
      final minute = int.parse(parts[4]);
      final dateTime = DateTime(year, month, day, hour, minute);

      // start validation

      // 2. Check for appointment conflicts
      final existingAppts = repo.findAppointmentsByDoctor(doctorId);
      final conflict =
          existingAppts.any((appt) => appt.dateTime.isAtSameMomentAs(dateTime));
      if (conflict) {
        throw Exception(
            'Doctor $doctorId already has an appointment at this exact time.');
      }

      // 3. Check if the time is within the doctor's working hours
      final workingHoursList = repo.getWorkingHours(doctorId);
      if (workingHoursList.isEmpty) {
        throw Exception('Doctor $doctorId has no working hours assigned.');
      }

      final dayOfWeek = [
        'Monday',
        'Tuesday',
        'Wednesday',
        'Thursday',
        'Friday',
        'Saturday',
        'Sunday'
      ][dateTime.weekday - 1];

      // Find the schedule for that day
      final daySchedule = workingHoursList
          .where((wh) => wh.day.toLowerCase() == dayOfWeek.toLowerCase());

      if (daySchedule.isEmpty) {
        // Smarter error message suggesting available hours
        String errorMsg =
            'Doctor $doctorId does not work on $dayOfWeek.\n Available hours are:';
        for (var wh in workingHoursList) {
          errorMsg += '\n - ${wh.day}: ${wh.startTime} - ${wh.endTime}';
        }
        throw Exception(errorMsg);
      }

      // We found a schedule for the day, now check the time
      final schedule = daySchedule.first; // Assume one schedule per day
      final startParts = schedule.startTime.split(':');
      final endParts = schedule.endTime.split(':');

      if (startParts.length < 2 || endParts.length < 2) {
        throw Exception(
            'Invalid working hours format for doctor. Expected HH:MM.');
      }

      final startHour = int.parse(startParts[0]);
      final startMin = int.parse(startParts[1]);
      final endHour = int.parse(endParts[0]);
      final endMin = int.parse(endParts[1]);

      final workStart = DateTime(
          dateTime.year, dateTime.month, dateTime.day, startHour, startMin);
      final workEnd = DateTime(
          dateTime.year, dateTime.month, dateTime.day, endHour, endMin);

      if (dateTime.isBefore(workStart) || !dateTime.isBefore(workEnd)) {
        throw Exception(
            'Appointment time is outside working hours ($dayOfWeek ${schedule.startTime} - ${schedule.endTime}).');
      }

      // end validation

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

  // shows Patient Name, Doctor Name, and custom time format
  void _viewDoctorSchedule() {
    stdout.write('Enter Doctor ID: ');
    final id = stdin.readLineSync()?.toUpperCase() ?? '';
    final appts = repo.findAppointmentsByDoctor(id);
    if (appts.isEmpty) {
      print('No appointments found for doctor $id.');
    } else {
      appts.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      print('\n--- Doctor Schedule (${appts.length}) ---');
      for (var a in appts) {
        // Fetch patient and doctor names
        final patient = repo.getPatientById(a.patientId);
        final patientName = patient?.name ?? 'Unknown Patient';
        final doctor = repo.getDoctorById(a.doctorId);
        final doctorName = doctor?.name ?? 'Unknown Doctor';
        final doctorFees = doctor?.fees ?? 0.0;

        // Format and print
        final formattedDate = _formatDateTime(a.dateTime);
        print(
            '${a.id} | Doctor: ${a.doctorId} (${doctorName}) | Patient: ${a.patientId} (${patientName}) | Date: $formattedDate\nTotal Fees: \$${doctorFees.toStringAsFixed(2)}');
      }
    }
  }

  // shows Patient Name, Doctor Name, and custom time format
  void _viewPatientAppointments() {
    stdout.write('Enter Patient ID: ');
    final id = stdin.readLineSync()?.toUpperCase() ?? '';
    final appts = repo.findAppointmentsByPatient(id);
    if (appts.isEmpty) {
      print('No appointments found for patient $id.');
    } else {
      appts.sort((a, b) => a.dateTime.compareTo(b.dateTime));
      print('\n--- Patient Appointments (${appts.length}) ---');
      for (var a in appts) {
        // Fetch patient and doctor names
        final patient = repo.getPatientById(a.patientId);
        final patientName = patient?.name ?? 'Unknown Patient';
        final doctor = repo.getDoctorById(a.doctorId);
        final doctorName = doctor?.name ?? 'Unknown Doctor';
        final doctorFees = doctor?.fees ?? 0.0;

        // format/print
        final formattedDate = _formatDateTime(a.dateTime);
        print(
            '${a.id} | Patient: ${a.patientId} (${patientName}) | Doctor: ${a.doctorId} (${doctorName}) | Date: $formattedDate\nTotal Fees: \$${doctorFees.toStringAsFixed(2)}');
      }
    }
  }

  void _cancelAppointment() {
    stdout.write('Enter Appointment ID to cancel: ');
    final id = stdin.readLineSync()?.toUpperCase() ?? '';
    repo.removeAppointment(id);
    print('Appointment $id canceled.');
  }
}
