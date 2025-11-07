import '../ui/main_ui.dart';

class Doctor{

  String id;
  String name;
  int age;
  String specialization;
  final double salary;

  Doctor({required this.id, required this.name, required this.age, required this.salary, required this.specialization});

   /// Convert Doctor object to Map (for JSON encoding)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'specialization': specialization,
      'salary': salary,
    };
  }

  /// Create Doctor object from Map (from JSON decoding)
  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      specialization: json['specialization'],
      salary: (json['salary'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'Doctor(id: $id, name: $name, age: $age, specialization: $specialization, salary: \$$salary)';
  }

}

class Nurse{

  String id;
  String name;
  int age;
  final double salary;

  Nurse({required this.id, required this.name, required this.age, required this.salary});

   Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'salary': salary,
    };
  }

  factory Nurse.fromJson(Map<String, dynamic> json) {
    return Nurse(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      salary: (json['salary'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'Nurse(id: $id, name: $name, age: \$$age, salary: $salary)';
  }
}

class AdminStaff{

  String id;
  String name;
  int age;
  final double salary;

  AdminStaff({required this.id, required this.name, required this.age, required this.salary});

     Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'salary': salary,
    };
  }

  factory AdminStaff.fromJson(Map<String, dynamic> json) {
    return AdminStaff(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      salary: (json['salary'] as num).toDouble(),
    );
  }

  @override
  String toString() {
    return 'Admin(id: $id, name: $name, age: \$$age, salary: $salary)';
  }
}
void main() {
  HospitalUI().start();
}

