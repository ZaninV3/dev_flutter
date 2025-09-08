import 'camera.dart';
import 'rover.dart';

class Photo {
  final int id;
  final String imgSrc;
  final Camera camera;
  final Rover rover;

  Photo({
    required this.id,
    required this.imgSrc,
    required this.camera,
    required this.rover
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id'],
      imgSrc: json['img_src'],
      camera: Camera.fromJson(json['camera']),
      rover: Rover.fromJson(json['rover'])
    );
  }
}