class CustomDuration {
  final int _milliseconds;

  CustomDuration.fromHours(int hours) : _milliseconds = hours * 60 * 60 * 1000 {
    if (hours < 0) throw ("duration cannot be negative!");
  }

  CustomDuration.fromMinute(int minutes) : _milliseconds = minutes * 60 * 1000 {
    if (minutes < 0) throw ("duration cannot be negative!");
  }

  CustomDuration.fromSeconds(int seconds) : _milliseconds = seconds * 1000 {
    if (seconds < 0) throw ("duration cannot be negative!");
  }

  int get inMilliseconds => _milliseconds; // immutable read but cannot change value

  bool operator >(CustomDuration other) => _milliseconds > other._milliseconds;

  CustomDuration operator +(CustomDuration other) =>
      CustomDuration._(_milliseconds + other._milliseconds);

  CustomDuration operator -(CustomDuration other) {
    int result = _milliseconds - other._milliseconds;
    if (result < 0) throw ArgumentError("result duration cannot be negative!");
    return CustomDuration._(result);
  }

  CustomDuration._(this._milliseconds); // private constructor + - result

  @override
  String toString() => "${_milliseconds} ms";
}

void main() {
  var d1 = CustomDuration.fromMinute(2);
  var d2 = CustomDuration.fromSeconds(30);

  print("d1: $d1");              // 120000 ms
  print("d2: $d2");              // 30000 ms
  print("d1 > d2: ${d1 > d2}");  // true
  print("d1 + d2 = ${d1 + d2}"); // 150000 ms
  print("d1 - d2 = ${d1 - d2}"); // 90000 ms
}
