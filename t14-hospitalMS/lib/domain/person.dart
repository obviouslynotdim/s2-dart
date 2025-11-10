class Person {
  final String id;
  final String name;
  final String gender;
  final String email;
  final String phoneNumber;

  Person({
    required this.id,
    required this.name,
    required this.gender,
    required this.email,
    required this.phoneNumber,
  });

  // Base method for displaying common info
  void displayInfo() {
    print('ID: $id | Name: $name | Gender: $gender\nEmail: $email | Phone: $phoneNumber');
  }

  // Base method for converting common fields to JSON
  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'gender': gender,
    'email': email,
    'phoneNumber': phoneNumber,
  };
  
  // Base copyWith for editing common fields
  Person copyWith({
    String? id,
    String? name,
    String? gender,
    String? email,
    String? phoneNumber,
  }) {
    // Note: The subclass (Doctor) will need to combine its fields with this
    return Person(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }
}