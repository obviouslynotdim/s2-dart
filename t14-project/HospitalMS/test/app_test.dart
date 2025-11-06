import 'package:hospital_ms_project/domain/main.dart'; // adjust path if needed
import 'package:test/test.dart';

void main() {
  group('Doctor', () {
    test('toJson returns correct map', () {
      final doctor = Doctor(
        id: 'D001',
        name: 'Dr. Dara',
        age: 45,
        specialization: 'Cardiology',
        salary: 6000.0,
      );

      expect(doctor.toJson(), {
        'id': 'D001',
        'name': 'Dr. Dara',
        'age': 45,
        'specialization': 'Cardiology',
        'salary': 6000.0,
      });
    });

    test('fromJson creates correct object', () {
      final json = {
        'id': 'D001',
        'name': 'Dr. Dara',
        'age': 45,
        'specialization': 'Cardiology',
        'salary': 6000,
      };

      final doctor = Doctor.fromJson(json);

      expect(doctor.name, 'Dr. Dara');
      expect(doctor.salary, 6000.0);
    });
  });
}