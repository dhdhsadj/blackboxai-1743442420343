class Employee {
  final String id;
  final String name;
  final String position;
  final String department;
  final DateTime hireDate;
  final String? fingerprintId;

  Employee({
    required this.id,
    required this.name,
    required this.position,
    required this.department,
    required this.hireDate,
    this.fingerprintId,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      name: json['name'],
      position: json['position'],
      department: json['department'],
      hireDate: DateTime.parse(json['hireDate']),
      fingerprintId: json['fingerprintId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'position': position,
      'department': department,
      'hireDate': hireDate.toIso8601String(),
      'fingerprintId': fingerprintId,
    };
  }
}