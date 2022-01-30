import 'package:flutter/widgets.dart';
import 'package:spotify_clone/components/album.dart';
import 'package:spotify_clone/components/playlist.dart';
import 'package:spotify_clone/components/podcast.dart';
import 'package:spotify_clone/models/album.dart';
import 'package:spotify_clone/models/playlist.dart';
import 'package:spotify_clone/models/podcast.dart';
import 'package:spotify_clone/models/track.dart';

List<Widget> getWidgets(dynamic objects) {
  return objects.map<Widget>((object) {
    return returnCorrectObject(object);
  }).toList();
}

Widget returnCorrectObject(Object object) {
  if (object.toString() == 'podcast') {
    object = object as Podcast;
    return PodcastWidget(
        height: 100,
        width: 150,
        type: 1,
        urlImage: object.picture,
        id: object.id);
  } else if (object.toString() == 'album') {
    object = object as Album;
    return AlbumWidget(
        height: 100,
        width: 150,
        type: 1,
        urlImage: object.coverMedium,
        id: object.id);
  } else if (object.toString() == 'playlist') {
    object = object as Playlist;
    return PlayListWidget(
        height: 100,
        width: 150,
        type: 1,
        urlImage: object.pictureMedium,
        id: object.id);
  } else if (object.toString() == 'track') {
    object = object as Track;
    return PlayListWidget(
        height: 100,
        width: 150,
        type: 1,
        urlImage: object.coverMedium,
        id: object.id);
  }
  return Container();
}
