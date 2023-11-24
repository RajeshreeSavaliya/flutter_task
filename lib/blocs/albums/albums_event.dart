part of 'albums_bloc.dart';

@immutable
abstract class AlbumsEvent {}

class FetchAlbums extends AlbumsEvent{

  FetchAlbums();

}
