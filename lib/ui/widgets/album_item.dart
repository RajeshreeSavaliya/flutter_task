import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_task_m/data/models/photos.dart';
import 'package:flutter_task_m/ui/widgets/photo_item.dart';

class AlbumItem extends StatelessWidget {
  final int index;
  final List<Photos> photosList;
  final String? albumTitle;

  const AlbumItem({
    super.key,
    required this.index,
    required this.photosList,
    required this.albumTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            albumTitle!,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
            maxLines: 1,
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
            height: MediaQuery.of(context).size.width / 3.5,
            child: CarouselSlider.builder(
                itemCount: photosList.length,
                itemBuilder: (BuildContext context, int index, int pageViewIndex) {
                  return PhotoItem(index: index, photoUrl: photosList[index].url ?? "");
                },
                options: CarouselOptions(
                  height: MediaQuery.of(context).size.width / 3.5,
                  viewportFraction: 0.3,
                  initialPage: 0,
                  disableCenter: true,
                  enableInfiniteScroll: true,
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                ))),
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
