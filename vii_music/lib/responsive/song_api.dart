import 'dart:convert';

import 'package:vii_music/contants.dart';
import 'package:vii_music/model/song.dart';

import 'package:http/http.dart' as http;

class SongApi {
  static List<Song> requestFromJson(dynamic s) =>
      List<Song>.from((s).map((e) => Song.fromJson(e)));

  static Future<List<Song>> getSongTrend() async {
    var res = await http.get(Uri.parse("$serverUrl/song/listen"));

    if (res.statusCode == 200) {
      var songs = jsonDecode(res.body);
      return requestFromJson(songs);
    } else {
      throw Exception('Failed to get songs.');
    }
  }

  static Future<List<Song>> getSong() async {
    var res = await http.get(Uri.parse("$serverUrl/song"));

    if (res.statusCode == 200) {
      var songs = jsonDecode(res.body);
      return requestFromJson(songs);
    } else {
      throw Exception('Failed to get songs.');
    }
  }

  static Future<List<Song>> getNewSong() async {
    var res = await http.get(Uri.parse("$serverUrl/song/new-song"));

    if (res.statusCode == 200) {
      var songs = jsonDecode(res.body);

      return requestFromJson(songs);
    } else {
      throw Exception('Failed to get songs.');
    }
  }
}
