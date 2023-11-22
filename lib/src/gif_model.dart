import 'dart:convert';
import 'dart:io';
import 'dart:async';

class GifSearchResult {
  final String searchTerm;
  String? gifUrl;
  String? title;
  int rating = 5;

  GifSearchResult(this.searchTerm);

  // Método estático para buscar varios GIFs
  static Future<List<GifSearchResult>> searchGifs(String searchTerm, {int limit = 10}) async {
    List<GifSearchResult> results = [];
    HttpClient http = HttpClient();

    try {
      var uri = Uri.https('api.giphy.com', '/v1/gifs/search', {
        'api_key': 'KFBoB2MPhHEagtE3eue9ERUVjZRWWrmh', 
        'q': searchTerm,
        'limit': limit.toString()
      });
      var request = await http.getUrl(uri);
      var response = await request.close();
      var responseBody = await response.transform(utf8.decoder).join();

      Map<String, dynamic> data = json.decode(responseBody);

      if (data.isNotEmpty) {
        var gifsData = data['data'] as List;
        for (var gifData in gifsData) {
          results.add(GifSearchResult(searchTerm)
            ..gifUrl = gifData['images']['original']['url']
            ..title = gifData['title']);
        }
      }
    } catch (e) {
      // ignore: avoid_print
      print('Error al buscar GIFs: $e');
    } finally {
      http.close();
    }

    return results;
  }
}
