import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_m/data/models/photos.dart';
import 'package:flutter_task_m/data/repositories/repository.dart';
import 'package:hive/hive.dart';
part 'photos_event.dart';

part 'photos_state.dart';

class PhotosBloc extends Bloc<PhotosEvent, PhotosState> {
  late List<Photos> photos;
  final Repository repository;

  PhotosBloc(this.repository) : super(PhotosInitial()) {
    on<PhotosEvent>((event, emit) async {
      if (event is FetchPhotos) {
        emit(PhotosLoading());
        photos = await repository.getPhotos();
var images =

        emit(PhotosLoaded(photos));
      }
    });
  }

}
