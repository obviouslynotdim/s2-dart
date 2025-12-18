import 'person.dart';

class Patient extends Person {
  final String disease;

  Patient({
    required super.id,
    required super.name,
    required super.gender,
    required super.email,
    required super.phoneNumber,
    required this.disease,
  });

  @override
  void displayInfo() {
    super.displayInfo();
    print('Disease: $disease');
  }

  // copyWith for editing
  Patient copyWith({
    String? id,
    String? name,
    String? gender,
    String? disease,
    String? email,
    String? phoneNumber,
  }) {
    return Patient(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      disease: disease ?? this.disease,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
  
  @override
  Map<String, dynamic> toJson() {
    // get all the common fields from the Person class
    final map = super.toJson();
    // add the fields to specific to Patient
    map.addAll({
      'disease': disease,
    });
    return map;
  }
  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        gender: json['gender'] as String? ?? '',
        disease: json['disease'] as String? ?? '',
        email: json['email'] as String? ?? '',
        phoneNumber: json['phoneNumber'] as String? ?? '',
      );

  @override
  String toString() => '$name ($id) - $disease';
}
