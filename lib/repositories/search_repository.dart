import '../models/track.dart';
import 'package:dio/dio.dart';

class SearchRepository {
  late final Dio _client;

  SearchRepository(this._client);

  Future<List<Track>> search(String query) async {
    final Response response =
        await _client.get('/search', queryParameters: {'q': query});

    if (response.data['error'] != null) {
      return [Track.jsonError(response.data['error'])];
    }

    return response.data['data']
        .map<Track>((map) => Track.fromJson(map))
        .toList();
  }
}
