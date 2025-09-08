import 'package:equatable/equatable.dart';
import '../models/photo.dart';


abstract class NasaState extends Equatable {
  const NasaState();

  @override
  List<Object> get props => [];
}


class NasaInitial extends NasaState {}

class NasaLoading extends NasaState {}

class NasaLoaded extends NasaState {
  final List<Photo> photos;

  const NasaLoaded(this.photos);

  @override
  List<Object> get props => [photos];
}


class NasaError extends NasaState {
  final String message;

  const NasaError(this.message);

  @override
  List<Object> get props => [message];
}
