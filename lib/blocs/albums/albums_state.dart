part of 'albums_bloc.dart';

@immutable
abstract class AlbumsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AlbumsInitial extends AlbumsState {}

class AlbumsLoading extends AlbumsState {}

class AlbumsError extends AlbumsState {}

@immutable
class AlbumsLoaded extends AlbumsState {
  final List<Albums> albums;

  AlbumsLoaded(this.albums);
}
