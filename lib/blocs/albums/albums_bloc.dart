import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_m/data/repositories/repository.dart';
import '../../data/models/albums.dart';
part 'albums_event.dart';
part 'albums_state.dart';

class AlbumsBloc extends Bloc<AlbumsEvent, AlbumsState> {
  late List<Albums> albums;
  final Repository repository;

  AlbumsBloc(this.repository) : super(AlbumsInitial()) {
    on<AlbumsEvent>((event, emit) async {
      if (event is FetchAlbums) {
        emit(AlbumsLoading());
        albums = await repository.getAlbums();
        emit(AlbumsLoaded(albums));
      }
    });
  }
}
