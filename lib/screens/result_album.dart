import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotify_clone/components/header.dart';
import 'package:spotify_clone/controllers/player_controller.dart';
import 'package:spotify_clone/helpers/choose_height.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/repositories/album_reposiitory.dart';
import 'package:spotify_clone/repositories/resource.dart';
import 'package:spotify_clone/theme/colors.dart';

class RescultAlbum extends StatelessWidget {
  final String title;
  final String coverMedium;
  final int id;

  const RescultAlbum(
      {Key? key,
      required this.title,
      required this.coverMedium,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Resource client = Resource('https://api.deezer.com/', {});
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    int index = 0;
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
        width: width,
        height: height,
        color: ColorPalette.darkIntermediate,
        child: Column(
          children: [
            Header(
              title: title,
              urlImage: coverMedium,
              titleButton: 'Reproduzir',
            ),
            FutureBuilder(
              future: AlbumRepository(client.dio).tracks(id),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Track>> snapshot) {
                if (snapshot.hasData) {
                  EasyLoading.dismiss();
                  index = 0;
                  return Container(
                    width: width,
                    height: chooseHeight(PlayerController.instance.isPlaying,
                        [height * 0.34, height * 0.40]),
                    margin: const EdgeInsets.only(top: 20),
                    child: ListView(
                      children: [
                        ...snapshot.data!.map<Widget>((object) {
                          if (!PlayerController.instance.isPlaying ||
                              PlayerController.instance.tracks.isEmpty) {
                            PlayerController.instance.tracks.add(object);
                          }
                          return EpisodeWidget(
                              urlImage: coverMedium,
                              duration: object.duration,
                              title: object.title,
                              preview: object.preview,
                              index: index++,
                              idPlayList: id);
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
  final String preview;
  final int index;
  final int idPlayList;
  const EpisodeWidget(
      {Key? key,
      required this.urlImage,
      required this.duration,
      required this.title,
      required this.preview,
      required this.index,
      required this.idPlayList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
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
                title.length > 45 ? title.substring(0, 30) : title,
                // textDirection: TextDirection.rtl,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            )
          ]),
          IconButton(
              onPressed: () async {
                if (PlayerController.instance.coverMedium != urlImage) {
                  await PlayerController.instance.stop();
                  Resource client = Resource('https://api.deezer.com/', {});
                  PlayerController.instance.tracks =
                      await AlbumRepository(client.dio).tracks(idPlayList);
                }
                await PlayerController.instance.stop();
                await Future.delayed(const Duration(milliseconds: 7));
                PlayerController.instance.setImage(urlImage);
                await PlayerController.instance.play(index);
              },
              icon: const Icon(
                Icons.play_circle,
                color: Colors.white,
              ))
        ],
      ),
    );
  }
}
