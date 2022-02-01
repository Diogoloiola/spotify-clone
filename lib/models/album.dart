class Album {
  int id = 0;
  String title = '';
  String link = '';
  String cover = '';
  String coverSmall = '';
  String coverMedium = '';
  String coverBig = '';
  String coverXl = '';
  String tracklist = '';
  String message = '';
  String type = '';
  int code = 0;

  Album(
      this.cover,
      this.coverBig,
      this.coverMedium,
      this.coverSmall,
      this.coverXl,
      this.id,
      this.link,
      this.title,
      this.tracklist,
      this.code,
      this.message,
      this.type);

  Album.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        link = json['link'],
        cover = json['cover'],
        coverSmall = json['cover_small'],
        coverMedium = json['cover_medium'],
        coverXl = json['cover_xl'],
        tracklist = json['tracklist'];

  Album.jsonError(Map<String, dynamic> json)
      : type = json['type'],
        message = json['message'],
        code = json['code'];

  Album.arguments(this.title, this.coverMedium, this.id);

  static List<Album> jsonToList(data) {
    return data.map<Album>((map) => Album.fromJson(map)).toList();
  }

  @override
  String toString() {
    return 'album';
  }
}
