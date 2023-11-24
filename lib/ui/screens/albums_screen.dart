import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_m/blocs/albums/albums_bloc.dart';
import 'package:flutter_task_m/blocs/network/network_bloc.dart';
import 'package:flutter_task_m/blocs/network/network_event.dart';
import 'package:flutter_task_m/blocs/network/network_state.dart';
import 'package:flutter_task_m/blocs/photos/photos_bloc.dart';
import 'package:flutter_task_m/data/repositories/repository.dart';
import 'package:flutter_task_m/ui/widgets/album_item.dart';

import '../../data/models/photos.dart';

class AlbumScreen extends StatelessWidget {
  AlbumScreen({super.key});

  final AlbumsBloc _albumsBloc = AlbumsBloc(Repository());

  final PhotosBloc _photosBloc = PhotosBloc(Repository());

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => NetworkBloc()..add(NetworkObserve())),
          BlocProvider(
            create: (_) => _albumsBloc,
          ),
          BlocProvider(
            create: (_) => _photosBloc,
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Albums"),
            centerTitle: true,
          ),
          body: BlocBuilder<NetworkBloc, NetworkState>(
            builder: (context, state) {
              if (state is NetworkFailure) {
                _albumsBloc.add(FetchAlbumsFromDB());
                _photosBloc.add(FetchPhotosFromDB());
                return networkAvailableState();
              } else if (state is NetworkSuccess) {
                _albumsBloc.add(FetchAlbums());
                _photosBloc.add(FetchPhotos());
                return networkAvailableState();
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ));
  }

  Widget networkAvailableState() {
    return BlocConsumer<AlbumsBloc, AlbumsState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AlbumsLoaded) {
          return BlocConsumer<PhotosBloc, PhotosState>(
              listener: (context, state) {},
              builder: (context, photosState) {
                if (photosState is PhotosLoaded) {
                  return CarouselSlider.builder(
                      itemCount: state.albums.length,
                      itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                        List<Photos> photos = photosState.photos.where((element) => element.albumId == state.albums[index].id).toList();
                        return Padding(
                          padding: const EdgeInsets.only(left: 12, bottom: 12),
                          child: AlbumItem(
                            index: index,
                            photosList: photos,
                            albumTitle: state.albums[index].title,
                          ),
                        );
                      },
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height,
                        viewportFraction: 0.3,
                        initialPage: 0,
                        disableCenter: true,
                        enableInfiniteScroll: true,
                        scrollDirection: Axis.vertical,
                      ));
                } else if (state is AlbumsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AlbumsError) {
                  return const Text("Something went wrong");
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              });
        } else if (state is AlbumsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is AlbumsError) {
          return const Text("Something went wrong");
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
