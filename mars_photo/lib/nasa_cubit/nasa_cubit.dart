import 'package:flutter_bloc/flutter_bloc.dart';
import 'nasa_state.dart';
import '../services/api_service.dart';


class NasaCubit extends Cubit<NasaState>{
  final ApiService apiService;

  NasaCubit(this.apiService) : super(NasaInitial());

  void loadPhotos() async {
    emit(NasaLoading());

    try {
      final photos = await apiService.getPhotos();
      emit(NasaLoaded(photos));
    } catch (e) {
      emit(NasaError(e.toString()));
    }
  }
}