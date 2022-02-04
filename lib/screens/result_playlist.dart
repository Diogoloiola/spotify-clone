import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotify_clone/components/header.dart';
import 'package:spotify_clone/controllers/player_controller.dart';
import 'package:spotify_clone/helpers/choose_height.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/repositories/playlist_repositorire.dart';
import 'package:spotify_clone/repositories/resource.dart';
import 'package:spotify_clone/theme/colors.dart';

class ResultPlayList extends StatelessWidget {
  final String title;
  final String pictureMedium;
  final int id;
  const ResultPlayList(
      {Key? key,
      required this.title,
      required this.pictureMedium,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Resource client = Resource('https://api.deezer.com/', {});
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    int i = 0;
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
              title: title,
              urlImage: pictureMedium,
              titleButton: 'Reproduzir',
            ),
            FutureBuilder(
              future: PlaylistRepositorie(client.dio).tracks(id),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Track>> snapshot) {
                if (snapshot.hasData) {
                  EasyLoading.dismiss();
                  return Container(
                    width: width,
                    height: chooseHeight(PlayerController.instance.isplaying,
                        [height * 0.38, height * 0.44]),
                    margin: const EdgeInsets.only(top: 20),
                    child: ListView(
                      children: [
                        ...snapshot.data!.map<Widget>((object) {
                          PlayerController.instance.tracks.add(object.preview);
                          return EpisodeWidget(
                              urlImage: object.coverMedium,
                              duration: object.duration,
                              title: object.title,
                              index: i++);
                        }).toList()
                      ],
                    ),
                  );
                }
                EasyLoading.show();
                return const SizedBox();
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
  final int index;

  const EpisodeWidget(
      {Key? key,
      required this.urlImage,
      required this.duration,
      required this.title,
      required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
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
                margin: const EdgeInsets.only(left: 20),
                child: Text(
                  title,
                  // textDirection: TextDirection.rtl,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          TextButton(
              onPressed: () async {
                await PlayerController.instance.play(index);
              },
              child: const Icon(
                Icons.play_circle,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
