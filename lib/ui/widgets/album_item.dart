import 'package:flutter/material.dart';
import 'package:flutter_task_m/ui/widgets/photo_item.dart';

class AlbumItem extends StatelessWidget {
  final int index;
  final List photosList;

  const AlbumItem({super.key, required this.index, required this.photosList});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            "title $index",
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width / 3.5,
          child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemCount: photosList.length,
              itemBuilder: (BuildContext context, int index) {
                return PhotoItem(index: index, photoUrl: photosList[index]);
              }),
        ),
        const SizedBox(
          height: 24,
        ),
        const Divider(
          thickness: 2,
          endIndent: 12,
        ),
      ],
    );
  }
}
