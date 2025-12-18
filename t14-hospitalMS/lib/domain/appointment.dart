class Appointment {
  final String id;
  final String patientId;
  final String doctorId;
  final DateTime dateTime;

  Appointment({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.dateTime,
  });

  @override
  String toString() =>
      '$id | Patient: $patientId | Doctor: $doctorId | Date: ${dateTime.toString().split('.').first}';

  Map<String, dynamic> toJson() => {
        'id': id,
        'patientId': patientId,
        'doctorId': doctorId,
        'dateTime': dateTime.toIso8601String(),
      };

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json['id'] as String? ?? '',
        patientId: json['patientId'] as String? ?? '',
        doctorId: json['doctorId'] as String? ?? '',
        // FIX: Use tryParse and provide a fallback date
        dateTime: DateTime.tryParse(json['dateTime'] as String? ?? '') ?? DateTime.now(),
      );
}