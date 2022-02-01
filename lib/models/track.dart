class Track {
  int id = 0;
  String title = '';
  String titleShort = '';
  String link = '';
  String preview = '';
  int duration = 0;
  String cover = '';
  String coverSmall = '';
  String coverMedium = '';
  String coverBig = '';
  String tracklistAlbum = '';
  String message = '';
  String type = '';
  int code = 0;

  Track(
      this.title,
      this.link,
      this.preview,
      this.duration,
      this.cover,
      this.coverBig,
      this.coverMedium,
      this.coverSmall,
      this.tracklistAlbum,
      this.message,
      this.code,
      this.type,
      this.id,
      this.titleShort);

  Track.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        link = json['link'],
        id = json['id'],
        preview = json['preview'],
        duration = json['duration'],
        cover = json['album']['cover'],
        coverSmall = json['album']['cover_small'],
        coverMedium = json['album']['cover_medium'],
        coverBig = json['album']['cover_big'],
        tracklistAlbum = json['album']['tracklist'],
        titleShort = json['title_short'];

  Track.jsonError(Map<String, dynamic> json)
      : code = json['code'],
        message = json['message'],
        type = json['type'];

  static List<Track> jsonToList(data) {
    return data.map<Track>((map) => Track.fromJson(map)).toList();
  }

  @override
  String toString() {
    return 'track';
  }
}
