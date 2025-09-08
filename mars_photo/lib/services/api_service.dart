import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/photo.dart';

class ApiService {
  static final String _apiKey = dotenv.get('NASA_API_KEY');
  static const String _baseurl = 'https://api.nasa.gov/mars-photos/api/v1/rovers';

  Future<List<Photo>> getPhotos() async {
    final response = await http.get(
      Uri.parse('$_baseurl/opportunity/photos?sol=110&api_key=$_apiKey')
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final photos = data['photos'] as List;
      return photos.map((photo) => Photo.fromJson(photo)).toList();
    } else {
      throw Exception('Ошибка загрузки изображаний');
    }
  }
}