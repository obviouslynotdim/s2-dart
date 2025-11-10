import 'person.dart';

class Doctor extends Person {
  final String specialization;
  final double fees;

  Doctor({
    required super.id,
    required super.name,
    required super.gender,
    required super.email,
    required super.phoneNumber,
    required this.specialization,
    required this.fees,
  });

  @override
  void displayInfo() {
    super.displayInfo();
    print('Specialization: $specialization | Fees: \$${fees.toStringAsFixed(2)}');
  }

  @override
  Map<String, dynamic> toJson() => {
        ...super.toJson(), // Includes id, name, gender, etc.
        'specialization': specialization,
        'fees': fees,
      };

  @override
  // copyWith method for editing
  Doctor copyWith({
    String? id,
    String? name,
    String? gender,
    String? email,
    String? phoneNumber,

    String? specialization,
    double? fees,
  }) {
    return Doctor(
      id: id ?? this.id,
      name: name ?? this.name,
      gender: gender ?? this.gender,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      specialization: specialization ?? this.specialization,
      fees: fees ?? this.fees,
    );
  }

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        id: json['id'] as String? ?? '',
        name: json['name'] as String? ?? '',
        gender: json['gender'] as String? ?? '',
        email: json['email'] as String? ?? '',
        phoneNumber: json['phoneNumber'] as String? ?? '',
        specialization: json['specialization'] as String? ?? '',
        // FIX: Use as num? and null check before converting to double
        fees: (json['fees'] as num?)?.toDouble() ?? 0.0,
      );
  @override
  String toString() => '$name ($id) - $specialization';
}
