class Doctor {
  final String id;
  final String name;
  final String gender;
  final String email;
  final String phoneNumber;
  final String specialization;
  final double fees;

  Doctor({
    required this.id,
    required this.name,
    required this.gender,
    required this.email,
    required this.phoneNumber,
    required this.specialization,
    required this.fees,
  });

  void displayInfo() {
    print(
        'Doctor: $id | Name: $name | Gender: $gender | Specialization: $specialization | Fees: $fees | Email: $email | Phone: $phoneNumber');
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'gender': gender,
        'email': email,
        'phoneNumber': phoneNumber,
        'specialization': specialization,
        'fees': fees,
      };

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json['id'],
        name: json['name'],
        gender: json['gender'],
        email: json['email'],
        phoneNumber: json['phoneNumber'],
        specialization: json['specialization'],
        fees: (json['fees'] as num).toDouble(),
      );

  @override
  String toString() => '$name ($id) - $specialization';
}
