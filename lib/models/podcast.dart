class Podcast {
  final int id;
  final String name;
  final String picture;
  final String pictureSmall;
  final String pictureMedium;
  final String pictureBig;
  final String pictureXl;
  final String type;

  Podcast(this.id, this.name, this.picture, this.pictureSmall,
      this.pictureMedium, this.pictureBig, this.pictureXl, this.type);

  Podcast.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        picture = json['picture'],
        pictureSmall = json['picture_small'],
        pictureMedium = json['picture_medium'],
        pictureBig = json['picture_big'],
        pictureXl = json['picture_xl'],
        type = json['type'];
}
