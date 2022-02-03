import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:spotify_clone/components/header.dart';
import 'package:spotify_clone/models/album.dart';
import 'package:spotify_clone/models/track.dart';
import 'package:spotify_clone/repositories/album_repositorire.dart';
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
              urlImage: coverMedium,
              titleButton: 'Reproduzir',
            ),
            FutureBuilder(
              future: AlbumRepositorie(client.dio).tracks(id),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Track>> snapshot) {
                if (snapshot.hasData) {
                  EasyLoading.dismiss();
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.44,
                    margin: const EdgeInsets.only(top: 20),
                    child: ListView(
                      children: [
                        ...snapshot.data!.map<Widget>((object) {
                          return EpisodeWidget(
                            urlImage: coverMedium,
                            duration: object.duration,
                            title: object.title,
                          );
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
          const Icon(
            Icons.play_circle,
            color: Colors.white,
          )
        ],
      ),
    );
  }
}
