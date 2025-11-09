class WorkingHours {
  final String doctorId;
  final String day;
  final String startTime;
  final String endTime;

  WorkingHours({
    required this.doctorId,
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() => {
        'doctorId': doctorId,
        'day': day,
        'startTime': startTime,
        'endTime': endTime,
      };

  factory WorkingHours.fromJson(Map<String, dynamic> json) => WorkingHours(
        doctorId: json['doctorId'],
        day: json['day'],
        startTime: json['startTime'],
        endTime: json['endTime'],
      );

  @override
  String toString() => '  - $day: $startTime - $endTime';
}