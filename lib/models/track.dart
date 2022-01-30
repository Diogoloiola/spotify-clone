class Track {
  String title = '';
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
      this.type);

  Track.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        link = json['link'],
        preview = json['preview'],
        duration = json['duration'],
        cover = json['album']['cover'],
        coverSmall = json['album']['cover_small'],
        coverMedium = json['album']['cover_medium'],
        coverBig = json['album']['cover_big'],
        tracklistAlbum = json['album']['tracklist'];

  Track.jsonError(Map<String, dynamic> json)
      : code = json['code'],
        message = json['message'],
        type = json['type'];
}
