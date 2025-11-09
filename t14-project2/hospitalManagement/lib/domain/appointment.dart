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
      '$id | Patient: $patientId | Doctor: $doctorId | Date: $dateTime';

  Map<String, dynamic> toJson() => {
        'id': id,
        'patientId': patientId,
        'doctorId': doctorId,
        'dateTime': dateTime.toIso8601String(),
      };

  factory Appointment.fromJson(Map<String, dynamic> json) => Appointment(
        id: json['id'],
        patientId: json['patientId'],
        doctorId: json['doctorId'],
        dateTime: DateTime.parse(json['dateTime']),
      );
}