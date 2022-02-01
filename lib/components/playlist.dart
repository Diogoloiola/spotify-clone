import 'package:flutter/material.dart';
import 'package:spotify_clone/models/playlist.dart';
import 'package:spotify_clone/theme/colors.dart';

class PlayListWidget extends StatelessWidget {
  final double width;
  final double height;
  final int type;
  final String coverMedium;
  final String title;
  final int id;
  const PlayListWidget(
      {Key? key,
      required this.width,
      required this.height,
      required this.type,
      required this.coverMedium,
      required this.id,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/result_playlist',
            arguments: Playlist.arguments(title, coverMedium, id));
      },
      child: Container(
          width: width,
          height: height,
          margin: const EdgeInsets.only(
            right: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(getRadius())),
            color: ColorPalette.dart,
          ),
          child: Image.network(coverMedium)),
    );
  }

  double getRadius() {
    return type == 1 ? 10 : 80;
  }
}
