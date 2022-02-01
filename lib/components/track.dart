import 'package:flutter/material.dart';
import 'package:spotify_clone/theme/colors.dart';

class TrackWidget extends StatelessWidget {
  final double width;
  final double height;
  final int type;
  final String urlImage;
  final int id;

  const TrackWidget(
      {Key? key,
      required this.width,
      required this.height,
      required this.type,
      required this.urlImage,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
          width: width,
          height: height,
          margin: const EdgeInsets.only(
            right: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(getRadius())),
          ),
          // child: Image.network(urlImage)),
          child: Column(
            children: [
              Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(80)),
                    color: ColorPalette.dart,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: Image.network(
                      urlImage,
                      height: 140,
                      width: 140,
                      fit: BoxFit.fill,
                      scale: 1,
                    ),
                  )),
            ],
          )),
    );
  }

  double getRadius() {
    return type == 1 ? 10 : 80;
  }
}
