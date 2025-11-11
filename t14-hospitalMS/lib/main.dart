import 'domain/hospital_repo.dart';
import 'ui/console_ui.dart';

void main() {
  final repo = HospitalRepository();
  final ui = ConsoleUI(repo);
  ui.start();
}