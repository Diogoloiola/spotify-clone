import 'package:flutter/material.dart';
import 'package:spotify_clone/screens/result_playlist.dart';
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
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => ResultPlayList(
                        id: id,
                        pictureMedium: coverMedium,
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
                    coverMedium,
                    width: 150,
                    height: 150,
                  )),
              Text(
                title.length >= 20 ? title.substring(0, 18) : title,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
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
