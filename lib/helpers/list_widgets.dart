import 'package:flutter/widgets.dart';
import 'package:spotify_clone/components/card.dart';
import 'package:spotify_clone/models/album.dart';
import 'package:spotify_clone/models/playlist.dart';
import 'package:spotify_clone/models/podcast.dart';

List<Widget> getWidgets(dynamic objects) {
  return objects.map<Widget>((object) {
    return returnCorrectObject(object);
  }).toList();
}

Widget returnCorrectObject(Object object) {
  if (object.toString() == 'podcast') {
    object = object as Podcast;
    return MyCard(
        height: 100,
        width: 150,
        type: 1,
        pathImage: object.picture,
        id: object.id);
  } else if (object.toString() == 'album') {
    object = object as Album;
    return MyCard(
        height: 100,
        width: 150,
        type: 1,
        pathImage: object.coverMedium,
        id: object.id);
  } else if (object.toString() == 'playlist') {
    object = object as Playlist;
    return MyCard(
        height: 100,
        width: 150,
        type: 1,
        pathImage: object.pictureMedium,
        id: object.id);
  }
  return Container();
}
