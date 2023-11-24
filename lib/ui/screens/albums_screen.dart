import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_m/blocs/albums/albums_bloc.dart';
import 'package:flutter_task_m/data/repositories/repository.dart';
import 'package:flutter_task_m/ui/widgets/album_item.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {

  AlbumsBloc _albumsBloc = AlbumsBloc(Repository());

  @override
  void initState() {
    _albumsBloc.add(FetchAlbums());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _albumsBloc,
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Albums"),
            centerTitle: true,
          ),
          body: BlocConsumer<AlbumsBloc, AlbumsState>(
            listener: (context, state) {},
            builder: (context, state) {
              print("bloc states : $state");
              if (state is AlbumsLoaded) {
                return ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 12, bottom: 12),
                      child: AlbumItem(index: index, photosList: [
                        "https://via.placeholder.com/600/92c952",
                        "https://via.placeholder.com/600/92c952",
                        "https://via.placeholder.com/600/92c952",
                        "https://via.placeholder.com/600/92c952",
                        "https://via.placeholder.com/600/92c952",
                      ]),
                    );
                  },
                );
              } else if (state is AlbumsLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AlbumsError) {
                return const Text("Something went wrong");
              } else {
                return const Center(child: CircularProgressIndicator());
                ;
              }
            },
          )),
    );
  }
}
