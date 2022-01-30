class Podcast {
  int id = 0;
  String title = '';
  String description = '';
  String picture = '';
  String pictureSmall = '';
  String pictureMedium = '';
  String pictureBig = '';
  String pictureXl = '';
  String type = '';
  String message = '';
  int code = 0;

  Podcast(
      this.id,
      this.title,
      this.picture,
      this.pictureSmall,
      this.pictureMedium,
      this.pictureBig,
      this.pictureXl,
      this.type,
      this.code,
      this.message);

  Podcast.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        picture = json['picture'],
        description = json['description'],
        pictureSmall = json['picture_small'],
        pictureMedium = json['picture_medium'],
        pictureBig = json['picture_big'],
        pictureXl = json['picture_xl'],
        type = json['type'];

  Podcast.jsonError(Map<String, dynamic> json)
      : type = json['type'],
        message = json['message'],
        code = json['code'];

  static List<Podcast> jsonToList(data) {
    return data.map<Podcast>((map) => Podcast.fromJson(map)).toList();
  }
}
