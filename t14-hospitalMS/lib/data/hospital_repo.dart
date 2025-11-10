import 'dart:convert';
import '../domain/doctor.dart';
import '../domain/patient.dart';
import '../domain/appointment.dart';
import '../domain/working_hours.dart';

class HospitalRepository {
  final List<Doctor> _doctors = [];
  final List<Patient> _patients = [];
  final List<Appointment> _appointments = [];
  final List<WorkingHours> _workingHours = [];

  // Doctors
  void addDoctor(Doctor d) => _doctors.add(d);
  List<Doctor> getAllDoctors() => _doctors;

  // Find a single doctor by ID (for editing)
  Doctor? getDoctorById(String id) {
    try {
      return _doctors.firstWhere((d) => d.id == id);
    } catch (e) {
      return null;
    }
  }

  // ADD: Update an existing doctor (for editing)
  void updateDoctor(Doctor updatedDoctor) {
    final index = _doctors.indexWhere((d) => d.id == updatedDoctor.id);
    if (index != -1) {
      _doctors[index] = updatedDoctor;
    }
  }

  // Patients
  void addPatient(Patient p) => _patients.add(p);
  List<Patient> getAllPatients() => _patients;

  // ADD: Find a single patient by ID (for editing)
  Patient? getPatientById(String id) {
    try {
      return _patients.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  // ADD: Update an existing patient (for editing)
  void updatePatient(Patient updatedPatient) {
    final index = _patients.indexWhere((p) => p.id == updatedPatient.id);
    if (index != -1) {
      _patients[index] = updatedPatient;
    }
  }

  // Appointments
  void addAppointment(Appointment a) => _appointments.add(a);
  void removeAppointment(String id) =>
      _appointments.removeWhere((a) => a.id == id);

  List<Appointment> findAppointmentsByDoctor(String id) =>
      _appointments.where((a) => a.doctorId == id).toList();
  List<Appointment> findAppointmentsByPatient(String id) =>
      _appointments.where((a) => a.patientId == id).toList();

  // Working Hours
  // method checks for and removes existing entries before adding the new one
  void addOrUpdateWorkingHours(WorkingHours wh) {
    _workingHours.removeWhere(
      (existingWh) =>
          existingWh.doctorId == wh.doctorId &&
          existingWh.day.toLowerCase() == wh.day.toLowerCase(),
    );

    _workingHours.add(wh);
  }

  List<WorkingHours> getWorkingHours(String doctorId) =>
      _workingHours.where((wh) => wh.doctorId == doctorId).toList();

  void removeWorkingHours(String doctorId, {String? day}) {
    if (day != null) {
      // 1. If a day is provided, remove only that day for the doctor
      final normalizedDay = day.toLowerCase();
      _workingHours.removeWhere(
        (wh) =>
            wh.doctorId == doctorId && wh.day.toLowerCase() == normalizedDay,
      );
    } else {
      // 2. If no day is provided, remove ALL working hours for the doctor
      _workingHours.removeWhere((wh) => wh.doctorId == doctorId);
    }
  }

  // Import JSON (for loading data from file)
void importFromJson(String jsonString) {
  final map = jsonDecode(jsonString) as Map<String, dynamic>;

  // Clear existing data to ensure a fresh load
  _doctors.clear();
  _patients.clear();
  _appointments.clear();
  _workingHours.clear();

  // Helper function to safely read a list and map it to a domain object
  List<T> _loadList<T>(String key, T Function(Map<String, dynamic>) fromJson) {
    final list = map[key] as List<dynamic>? ?? [];
    return list.map((json) => fromJson(json as Map<String, dynamic>)).toList();
  }

  // Load all lists using the 'fromJson' factories in your domain classes
  _doctors.addAll(_loadList('doctors', Doctor.fromJson));
  _patients.addAll(_loadList('patients', Patient.fromJson));
  _appointments.addAll(_loadList('appointments', Appointment.fromJson));
  _workingHours.addAll(_loadList('workingHours', WorkingHours.fromJson));
}

  // Export JSON
  String exportToJson() {
    final map = {
      'doctors': _doctors.map((d) => d.toJson()).toList(),
      'patients': _patients.map((p) => p.toJson()).toList(),
      'appointments': _appointments.map((a) => a.toJson()).toList(),
      'workingHours': _workingHours.map((w) => w.toJson()).toList(),
    };
    return JsonEncoder.withIndent('  ').convert(map);
  }
}
