class Patient {
  final String id;
  final String name;
  final String phoneNumber;
  final String gender;
  final String email;
  final String disease;

  Patient({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.gender,
    required this.email,
    required this.disease,
  });

  void displayInfo() {
    print(
        'Patient: $id | Name: $name | Gender: $gender | Disease: $disease | Phone: $phoneNumber | Email: $email');
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phoneNumber': phoneNumber,
        'gender': gender,
        'email': email,
        'disease': disease,
      };

  factory Patient.fromJson(Map<String, dynamic> json) => Patient(
        id: json['id'],
        name: json['name'],
        phoneNumber: json['phoneNumber'],
        gender: json['gender'],
        email: json['email'],
        disease: json['disease'],
      );
}
