import 'track.dart';

class Playlist {
  int id = 0;
  String description = '';
  String title = '';
  String picture = '';
  String pictureSmall = '';
  String pictureMedium = '';
  String pictureBig = '';
  String pictureXl = '';
  String type = '';
  int nbTracks = 0;
  String message = '';
  String tracklist = '';
  int code = 0;
  late List<Track> tracks;

  Playlist(
      this.id,
      this.description,
      this.picture,
      this.pictureSmall,
      this.pictureMedium,
      this.pictureBig,
      this.pictureXl,
      this.type,
      this.code,
      this.message,
      this.nbTracks,
      this.title,
      this.tracks,
      this.tracklist);

  Playlist.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        description = json['description'] ?? '',
        picture = json['picture'],
        pictureSmall = json['picture_small'],
        pictureMedium = json['picture_medium'],
        pictureBig = json['picture_big'],
        pictureXl = json['picture_xl'],
        type = json['type'],
        title = json['title'],
        nbTracks = json['nb_tracks'],
        tracklist = json['tracklist'],
        tracks = json['tracks'] == null
            ? []
            : json['tracks']['data']
                .map<Track>((map) => Track.fromJson(map))
                .toList();

  Playlist.jsonError(Map<String, dynamic> json)
      : type = json['type'],
        message = json['message'],
        code = json['code'];

  static List<Playlist> jsonToList(data) {
    return data.map<Playlist>((map) => Playlist.fromJson(map)).toList();
  }
}
