import 'package:hospital_management_system/data/hospital_repo.dart';
import 'package:hospital_management_system/ui/console_ui.dart';

void main() {
  final repo = HospitalRepository();
  final ui = ConsoleUI(repo);
  ui.start();
}
