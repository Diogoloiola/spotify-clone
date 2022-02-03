import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:spotify_clone/components/header.dart';
import 'package:spotify_clone/models/episode.dart';
import 'package:spotify_clone/models/podcast.dart';
import 'package:spotify_clone/repositories/podcast_repositorie.dart';
import 'package:spotify_clone/repositories/resource.dart';
import 'package:spotify_clone/theme/colors.dart';

class ResultPodcast extends StatelessWidget {
  final String title;
  final String pictureMedium;
  final int id;

  const ResultPodcast(
      {Key? key,
      required this.title,
      required this.pictureMedium,
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
              urlImage: pictureMedium,
              titleButton: 'Escute',
            ),
            FutureBuilder(
              future: PodcastRepositorie(client.dio).find(id),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Episode>> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data != null) {
                    EasyLoading.dismiss();
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.5,
                      // padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(top: 20),
                      child: ListView(
                        children: [
                          ...snapshot.data!.map<Widget>((object) {
                            return EpisodeWidget(
                                urlImage: object.picture,
                                duration: object.duration,
                                title: object.title,
                                releaseDate: object.releaseDate);
                          }).toList()
                        ],
                      ),
                    );
                  }
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
  final String releaseDate;
  const EpisodeWidget(
      {Key? key,
      required this.urlImage,
      required this.duration,
      required this.title,
      required this.releaseDate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
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
                      margin: const EdgeInsets.only(left: 10),
                      child: Text(
                        title.length > 45 ? title.substring(0, 20) : title,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
                const Icon(
                  Icons.share,
                  color: Colors.white,
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat("dd-MM-yyyy")
                        .format(DateTime.parse(releaseDate)),
                    style: const TextStyle(color: Colors.white),
                  ),
                  Text(
                    "${(duration / 60).toStringAsFixed(0).toString()} minutos",
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
