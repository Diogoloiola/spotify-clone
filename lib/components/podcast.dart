import 'package:flutter/material.dart';
import 'package:spotify_clone/screens/result_podcast.dart';
import 'package:spotify_clone/theme/colors.dart';

class PodcastWidget extends StatelessWidget {
  final double width;
  final double height;
  final int id;
  final int type;
  final String urlImage;
  final String title;

  const PodcastWidget(
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ResultPodcast(
                        id: id,
                        pictureMedium: urlImage,
                        title: title,
                      )));
        },
        child: Container(
          width: width,
          height: height,
          margin: const EdgeInsets.only(right: 10),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                    borderRadius:
                        BorderRadius.all(Radius.circular(getRadius())),
                    color: ColorPalette.dart,
                  ),
                  child: Image.network(
                    urlImage,
                    width: 150,
                    height: 150,
                  )),
              Text(
                title.length > 10 ? "${title.substring(0, 14)}..." : title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ));
  }

  double getRadius() {
    return type == 1 ? 10 : 80;
  }
}
