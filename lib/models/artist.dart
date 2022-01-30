class Artist {
  int id = 0;
  String name = '';
  String link = '';
  String picture = '';
  String pictureSmall = '';
  String pictureMedium = '';
  String pictureBig = '';
  String pictureXl = '';
  String type = '';
  String message = '';
  String trackslist = '';
  int code = 0;

  Artist.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        link = json['link'],
        trackslist = json['tracklist'],
        picture = json['picture'],
        pictureSmall = json['picture_small'],
        pictureMedium = json['picture_medium'],
        pictureBig = json['picture_big'],
        pictureXl = json['picture_xl'],
        type = json['type'];

  Artist.jsonError(Map<String, dynamic> json)
      : type = json['type'],
        message = json['message'],
        code = json['code'];

  static List<Artist> jsonToList(data) {
    return data.map<Artist>((map) => Artist.fromJson(map)).toList();
  }
}
