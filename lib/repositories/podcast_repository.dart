import '../models/podcast.dart';
import '../models/episode.dart';
import 'package:dio/dio.dart';

class PodcastRepository {
  late final Dio _client;

  PodcastRepository(this._client);

  Future<List<Podcast>> all() async {
    final Response response = await _client.get('/podcast');
    final List<Podcast> podcasts = response.data['data']
        .map<Podcast>((map) => Podcast.fromJson(map))
        .toList();

    return podcasts;
  }

  Future<List<Episode>> find(int id) async {
    final Response response = await _client.get("/podcast/$id/episodes");
    final List<Episode> episodes = response.data['data']
        .map<Episode>((map) => Episode.fromJson(map))
        .toList();

    return episodes;
  }
}
