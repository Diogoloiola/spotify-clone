import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotify_clone/components/header.dart';
import 'package:spotify_clone/models/playlist.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/repositories/playlist_repositorire.dart';
import 'package:spotify_clone/repositories/resource.dart';
import 'package:spotify_clone/theme/colors.dart';

class ResultPlayList extends StatelessWidget {
  const ResultPlayList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Resource client = Resource('https://api.deezer.com/', {});
    final args = ModalRoute.of(context)!.settings.arguments as Playlist;

    return Scaffold(
      appBar:
          AppBar(backgroundColor: ColorPalette.darkSecondary, actions: const [
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
        color: ColorPalette.darkItermediare,
        child: Column(
          children: [
            Header(
              title: args.title,
              urlImage: args.pictureMedium,
              titleButton: 'Reproduzir',
            ),
            FutureBuilder(
              future: PlaylistRepositorie(client.dio).tracks(args.id),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Track>> snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.5,
                    margin: const EdgeInsets.only(top: 20),
                    child: ListView(
                      children: [
                        ...snapshot.data!.map<Widget>((object) {
                          return EpisodeWidget(
                            urlImage: object.coverMedium,
                            duration: object.duration,
                            title: object.title,
                          );
                        }).toList()
                      ],
                    ),
                  );
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}

class EpisodeWidget extends StatelessWidget {
  final String urlImage;
  final int duration;
  final String title;
  const EpisodeWidget({
    Key? key,
    required this.urlImage,
    required this.duration,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              urlImage,
              fit: BoxFit.fill,
              width: 40,
              height: 40,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 20),
            child: Text(
              title,
              // textDirection: TextDirection.rtl,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          const Icon(
            Icons.play_circle,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
