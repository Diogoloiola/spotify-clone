import 'package:flutter/material.dart';
import 'package:spotify_clone/theme/colors.dart';

class Header extends StatelessWidget {
  final String title;
  final String urlImage;
  final String titleButton;

  const Header(
      {Key? key,
      required this.title,
      required this.urlImage,
      required this.titleButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: ColorPalette.darkSecondary,
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              urlImage,
              fit: BoxFit.fill,
              width: 150,
              height: 150,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
          ),
          Container(
            width: 200,
            height: 50,
            margin: const EdgeInsets.only(top: 10),
            decoration: const BoxDecoration(
              color: ColorPalette.redPrimary,
              borderRadius: BorderRadius.all(Radius.circular(50)),
            ),
            child: Center(
                child: Text(
              titleButton,
              style: const TextStyle(color: Colors.white, fontSize: 20),
            )),
          )
        ],
      ),
    );
  }
}
