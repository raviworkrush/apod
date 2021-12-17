import 'package:apod/data/models/model.dart';
import 'package:apod/data/services/api_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'todays_picture_state.dart';

class TodaysPictureCubit extends Cubit<TodaysPictureState> {
  TodaysPictureCubit() : super(TodaysPictureInitial());

  Future<void> getTodaysPicture() async {
    emit(TodaysPictureLoading());
    try {
      final Map<String, dynamic> _apiResponse =
          await APIService.getTodaysPicture();
      if (_apiResponse['status'] == true) {
        final Model data = _apiResponse['data'];
        emit(TodaysPictureLoaded(data: data));
      } else {
        emit(TodaysPictureError(error: _apiResponse['message']));
      }
    } on Exception catch (e) {
      emit(TodaysPictureError(error: e.toString()));
    }
  }

  Future<void> getParticularDatePicture(String date) async {
    emit(TodaysPictureLoading());
    try {
      final Map<String, dynamic> _apiResponse =
          await APIService.getParticularDatePicture(date);
      if (_apiResponse['status'] == true) {
        final Model data = _apiResponse['data'];
        emit(TodaysPictureLoaded(data: data));
      } else {
        emit(TodaysPictureError(error: _apiResponse['message']));
      }
    } on Exception catch (e) {
      emit(TodaysPictureError(error: e.toString()));
    }
  }
}
