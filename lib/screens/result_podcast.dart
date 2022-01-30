import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotify_clone/models/podcast.dart';

class ResultPodcast extends StatelessWidget {
  const ResultPodcast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Podcast;

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black, actions: const [
        IconButton(
          icon: FaIcon(
            FontAwesomeIcons.bell,
            color: Colors.white,
          ),
          tooltip: 'Notificações',
          onPressed: null,
        ),
      ]),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.black,
        child: Column(
          children: [
            Header(
              title: args.title,
              urlImage: args.pictureMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  final String title;
  final String urlImage;

  const Header({Key? key, required this.title, required this.urlImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              urlImage,
              fit: BoxFit.fill,
              width: 140,
              height: 140,
            ),
          ),
          Text(
            title,
            style: const TextStyle(
                color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}
