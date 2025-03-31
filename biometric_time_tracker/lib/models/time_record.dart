class TimeRecord {
  final String id;
  final String employeeId;
  final DateTime timestamp;
  final String actionType; // 'clock_in', 'break_start', 'break_end', 'clock_out'

  TimeRecord({
    required this.id,
    required this.employeeId,
    required this.timestamp,
    required this.actionType,
  });

  factory TimeRecord.fromJson(Map<String, dynamic> json) {
    return TimeRecord(
      id: json['id'],
      employeeId: json['employeeId'],
      timestamp: DateTime.parse(json['timestamp']),
      actionType: json['actionType'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'employeeId': employeeId,
      'timestamp': timestamp.toIso8601String(),
      'actionType': actionType,
    };
  }

  String get displayAction {
    switch (actionType) {
      case 'clock_in':
        return 'Clocked In';
      case 'break_start':
        return 'Break Started';
      case 'break_end':
        return 'Break Ended';
      case 'clock_out':
        return 'Clocked Out';
      default:
        return actionType;
    }
  }
}