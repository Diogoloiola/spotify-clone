import '../models/track.dart';
import 'package:dio/dio.dart';

class AlbumRepositorie {
  late final Dio _client;

  AlbumRepositorie(this._client);

  Future<List<Track>> tracks(int id) async {
    final Response response = await _client.get("/album/$id/tracks");

    if (response.data['error'] != null) {
      return [Track.jsonError(response.data['error'])];
    }
    final List<Track> episodes =
        response.data['data'].map<Track>((map) => Track.fromJson(map)).toList();

    return episodes;
  }
}
