class Podcast {
  int id = 0;
  String title = '';
  String description = '';
  String picture = '';
  String picture_small = '';
  String picture_medium = '';
  String picture_big = '';
  String picture_xl = '';
  String type = '';
  String message = '';
  int code = 0;

  Podcast(
      this.id,
      this.title,
      this.picture,
      this.picture_small,
      this.picture_medium,
      this.picture_big,
      this.picture_xl,
      this.type,
      this.code,
      this.message);

  Podcast.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        picture = json['picture'],
        description = json['description'],
        picture_small = json['picture_small'],
        picture_medium = json['picture_medium'],
        picture_big = json['picture_big'],
        picture_xl = json['picture_xl'],
        type = json['type'];

  Podcast.jsonError(Map<String, dynamic> json)
      : type = json['type'],
        message = json['message'],
        code = json['code'];

  static List<Podcast> jsonToList(data) {
    return data.map<Podcast>((map) => Podcast.fromJson(map)).toList();
  }
}
