part of 'photos_bloc.dart';

@immutable
abstract class PhotosEvent {}

class FetchPhotos extends PhotosEvent {
  FetchPhotos();
}

class FetchPhotosFromDB extends PhotosEvent {
  FetchPhotosFromDB();
}
