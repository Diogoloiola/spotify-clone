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
        coverSmall = json['link'],
        coverMedium = json['link'],
        coverXl = json['link'],
        tracklist = json['tracklist'];

  Album.jsonError(Map<String, dynamic> json)
      : type = json['type'],
        message = json['message'],
        code = json['code'];

  static List<Album> jsonToList(data) {
    return data.map<Album>((map) => Album.fromJson(map)).toList();
  }
}
