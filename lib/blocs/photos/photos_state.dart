part of 'photos_bloc.dart';

@immutable
abstract class PhotosState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PhotosInitial extends PhotosState {}

class PhotosLoading extends PhotosState {}
class PhotosError extends PhotosState {}

@immutable
class PhotosLoaded extends PhotosState {
  final List<Photos> photos;
  PhotosLoaded(this.photos);
}

