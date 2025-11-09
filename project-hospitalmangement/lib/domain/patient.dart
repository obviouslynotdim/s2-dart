class Patient {
  final String id;
  final String name;
  final String gender;
  final String disease;
  final String email;
  final String phoneNumber;

  Patient({
    required this.id,
    required this.name,
    required this.gender,
    required this.disease,
    required this.email,
    required this.phoneNumber,
  });

  void displayInfo() {
    print(
        'Patient: $id | Name: $name | Gender: $gender\nDisease: $disease | Email: $email | Phone: $phoneNumber');
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

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'gender': gender,
        'disease': disease,
        'email': email,
        'phoneNumber': phoneNumber,
      };

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json['id'],
        name: json['name'],
        gender: json['gender'],
        disease: json['disease'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
      );
}