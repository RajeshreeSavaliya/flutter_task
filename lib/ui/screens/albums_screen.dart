import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_task_m/blocs/albums/albums_bloc.dart';
import 'package:flutter_task_m/ui/widgets/album_item.dart';

class AlbumScreen extends StatelessWidget {
  const AlbumScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AlbumsBloc(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Albums"),
          centerTitle: true,
        ),
        body: ListView.builder(
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
        ),
      ),
    );
  }
}
