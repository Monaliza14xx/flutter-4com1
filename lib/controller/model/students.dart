class Student {
  final String id;
  final String stdId;
  final String name;
  final String surname;

  Student({
    required this.id,
    required this.stdId,
    required this.name,
    required this.surname,
  });

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'],
      stdId: json['std_id'],
      name: json['name'],
      surname: json['surname'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'std_id': stdId,
      'name': name,
      'surname': surname,
    };
  }
}
