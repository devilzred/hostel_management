class Activity {
  final String id;
  final int status;
  final String time;
  final String uid;

  Activity({
    required this.id,
    required this.status,
    required this.time,
    required this.uid,
  });

  // Factory constructor to parse JSON data
  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      status: json['status'],
      time: json['time'],
      uid: json['uid'],
    );
  }
}
