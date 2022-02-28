import '../models/playlist.dart';
import '../models/track.dart';
import 'package:dio/dio.dart';

class PlaylistRepository {
  late final Dio _client;

  PlaylistRepository(this._client);

  Future<Playlist> find(id) async {
    final Response response = await _client.get("/playlist/$id");
    if (response.data['error'] != null) {
      return Playlist.jsonError(response.data['error']);
    } else {
      return Playlist.fromJson(response.data);
    }
  }

  Future<List<Track>> tracks(int id) async {
    final Response response = await _client.get("/playlist/$id/tracks");

    if (response.data['error'] != null) {
      return [Track.jsonError(response.data['error'])];
    }
    final List<Track> episodes =
        response.data['data'].map<Track>((map) => Track.fromJson(map)).toList();

    return episodes;
  }
}
