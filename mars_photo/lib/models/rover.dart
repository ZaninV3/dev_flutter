class Rover {
  final String name;
  final String status;

  Rover({
    required this.name,
    required this.status
  });

  factory Rover.fromJson(Map<String, dynamic> json) {
    return Rover(
      name: json['name'],
      status: json['status']
    );
  }
}