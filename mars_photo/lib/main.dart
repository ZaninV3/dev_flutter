import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'nasa_cubit/nasa_cubit.dart';
import 'nasa_cubit/nasa_state.dart';
import 'services/api_service.dart';
import 'models/photo.dart';


void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const NasaApp());
}


class NasaApp extends StatelessWidget {
  const NasaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Марсоход Opportunity, сол 110',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: BlocProvider(
        create: (content) => NasaCubit(ApiService())..loadPhotos(),
        child: const PhotosScreen()
      )
    );
  }
}


class PhotosScreen extends StatelessWidget {
  const PhotosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Opportunity. Сол 110')
      ),
      body: BlocBuilder<NasaCubit, NasaState>(
        builder: (context, state) {
          if (state is NasaLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NasaError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is NasaLoaded) {
            return PhotosList(photos: state.photos);
          } else {
            return const Center(child: Text('Нажмите чтобы выгрузить фото'));
          }
        }
      )
    );
  }
}


class PhotosList extends StatelessWidget {
  final List<Photo> photos;

  const PhotosList({super.key, required this.photos});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: photos.length,
      itemBuilder: (context, index) {
        final photo = photos[index];
        return Card(
          margin: const EdgeInsets.all(8),
          child: Column(
            children: [
              Image.network(photo.imgSrc),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Camera: ${photo.camera.fullName}',
                  style: const TextStyle(fontSize: 16)
                )
              )
            ]
          )
        );
      },
    );
  }
}
