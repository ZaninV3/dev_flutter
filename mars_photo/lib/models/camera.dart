class Camera {
  final String name;
  final String fullName;

  Camera({
    required this.name,
    required this.fullName
  });

  factory Camera.fromJson(Map<String, dynamic> json) {
    return Camera(
      name: json['name'],
      fullName: json['full_name']
    );
  }
}