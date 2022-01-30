class Episode {
  final int id;
  final String title;
  final String release_date;
  final int duration;
  final String picture;
  final String type;

  Episode(this.id, this.release_date, this.picture, this.type, this.title,
      this.duration);

  Episode.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        picture = json['picture'],
        release_date = json['release_date'],
        duration = json['duration'],
        type = json['type'];
}
