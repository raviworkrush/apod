part of 'todays_picture_cubit.dart';

abstract class TodaysPictureState extends Equatable {
  const TodaysPictureState();

  @override
  List<Object> get props => [];
}

class TodaysPictureInitial extends TodaysPictureState {}

class TodaysPictureLoading extends TodaysPictureState {}

class TodaysPictureLoaded extends TodaysPictureState {
  final Model data;
  const TodaysPictureLoaded({required this.data});
  @override
  List<Object> get props => [data];
}

class TodaysPictureError extends TodaysPictureState {
  final String error;
  const TodaysPictureError({required this.error});
  @override
  List<Object> get props => [error];
}
