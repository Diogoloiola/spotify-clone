import 'package:dio/dio.dart';
import '../models/track.dart';
import '../models/album.dart';
import '../models/podcast.dart';
import '../models/playlist.dart';
import '../models/artist.dart';

class ChartRepositorie {
  late final Dio _client;

  ChartRepositorie(this._client);

  Future<List<Track>> tracks() async {
    final Response response = await _client.get('chart/track/');

    if (response.data['error'] != null) {
      return [Track.jsonError(response.data['error'])];
    }
    return Track.jsonToList(response.data['tracks']['data']);
  }

  Future<List<Album>> albums() async {
    final Response response = await _client.get('chart/track/');

    if (response.data['error'] != null) {
      return [Album.jsonError(response.data['error'])];
    }
    return Album.jsonToList(response.data['albums']['data']);
  }

  Future<List<Podcast>> podcast() async {
    final Response response = await _client.get('chart/track/');

    if (response.data['error'] != null) {
      return [Podcast.jsonError(response.data['error'])];
    }
    return Podcast.jsonToList(response.data['podcasts']['data']);
  }

  Future<List<Playlist>> playlist() async {
    final Response response = await _client.get('chart/track/');

    if (response.data['error'] != null) {
      return [Playlist.jsonError(response.data['error'])];
    }
    return Playlist.jsonToList(response.data['playlists']['data']);
  }

  Future<List<Artist>> artists() async {
    final Response response = await _client.get('chart/track/');

    if (response.data['error'] != null) {
      return [Artist.jsonError(response.data['error'])];
    }
    return Artist.jsonToList(response.data['artists']['data']);
  }

  Future<Map<String, List<Object>>> all() async {
    final Response response = await _client.get('chart/track/');

    return {
      'tracks': Track.jsonToList(response.data['tracks']['data']),
      'albums': Album.jsonToList(response.data['albums']['data']),
      'podcasts': Podcast.jsonToList(response.data['podcasts']['data']),
      'playlists': Playlist.jsonToList(response.data['playlists']['data']),
      'artists': Artist.jsonToList(response.data['artists']['data'])
    };
  }
}
