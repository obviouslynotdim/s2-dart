import 'dart:convert';
import 'dart:io';
import '../domain/main.dart';

class DataManager {
  final File doctorFile = File('assets/doctors.json');
  final File nurseFile = File('assets/nurses.json');
  final File adminFile = File('assets/admins.json');

  DataManager() {
    _ensureFilesExist();
  }

  // Ensure folders and files exist before using
  void _ensureFilesExist() {
    final directory = Directory('assets');
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
    }

    if (!doctorFile.existsSync()) doctorFile.writeAsStringSync('[]');
    if (!nurseFile.existsSync()) nurseFile.writeAsStringSync('[]');
    if (!adminFile.existsSync()) adminFile.writeAsStringSync('[]');
  }

  // -------------------- Doctor --------------------
  List<Doctor> loadDoctors() {
    final jsonString = doctorFile.readAsStringSync();
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Doctor.fromJson(json)).toList();
  }

  void saveDoctors(List<Doctor> doctors) {
    final jsonList = doctors.map((d) => d.toJson()).toList();
    doctorFile.writeAsStringSync(jsonEncode(jsonList));
  }

  // -------------------- Nurse --------------------
  List<Nurse> loadNurses() {
    final jsonString = nurseFile.readAsStringSync();
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => Nurse.fromJson(json)).toList();
  }

  void saveNurses(List<Nurse> nurses) {
    final jsonList = nurses.map((n) => n.toJson()).toList();
    nurseFile.writeAsStringSync(jsonEncode(jsonList));
  }

  // -------------------- AdminStaff --------------------
  List<AdminStaff> loadAdmins() {
    final jsonString = adminFile.readAsStringSync();
    final List<dynamic> jsonList = jsonDecode(jsonString);
    return jsonList.map((json) => AdminStaff.fromJson(json)).toList();
  }

  void saveAdmins(List<AdminStaff> admins) {
    final jsonList = admins.map((a) => a.toJson()).toList();
    adminFile.writeAsStringSync(jsonEncode(jsonList));
  }
}
