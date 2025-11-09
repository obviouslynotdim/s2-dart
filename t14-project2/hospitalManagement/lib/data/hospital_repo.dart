// hospital_repo.dart
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
  void addWorkingHours(WorkingHours wh) => _workingHours.add(wh);

  List<WorkingHours> getWorkingHours(String doctorId) =>
      _workingHours.where((wh) => wh.doctorId == doctorId).toList();

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