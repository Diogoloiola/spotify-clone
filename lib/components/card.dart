import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final double width;
  final double height;
  final int type;
  final String pathImage;
  final int id;

  const MyCard(
      {Key? key,
      required this.width,
      required this.height,
      required this.type,
      required this.pathImage,
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
            color: Colors.red,
          ),
          child: Image.network(pathImage)),
    );
  }

  double getRadius() {
    return type == 1 ? 10 : 80;
  }
}
