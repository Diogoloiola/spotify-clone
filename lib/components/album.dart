import 'package:flutter/material.dart';
import 'package:spotify_clone/models/album.dart';
import 'package:spotify_clone/theme/colors.dart';

class AlbumWidget extends StatelessWidget {
  final double width;
  final double height;
  final int type;
  final String urlImage;
  final int id;
  final String title;

  const AlbumWidget(
      {Key? key,
      required this.width,
      required this.height,
      required this.type,
      required this.urlImage,
      required this.id,
      required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/result_album',
            arguments: Album.arguments(title, urlImage, id));
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
          child: Image.network(urlImage)),
    );
  }

  double getRadius() {
    return type == 1 ? 10 : 80;
  }
}
