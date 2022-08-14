import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vii_music/model/songlisten.dart';

import '../contants.dart';

class ListenSongApi {
  static List<ListenSong> requestFromJson(dynamic s) =>
      List<ListenSong>.from((s).map((e) => ListenSong.fromJson(e)));

  static Future<bool> saveSongListen(
      String idSong, String idUser, String time, String timeEnd) async {
    var res = await http.post(Uri.parse("$serverUrl/user/listen/save"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "song": idSong,
          "user": idUser,
          "time": time,
          "timeEnd": timeEnd
        }));

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to get songs.');
    }
  }

  static Future<List<ListenSong>> getSongListen(String idUser) async {
    var res = await http.get(Uri.parse("$serverUrl/user/listen/$idUser"));

    if (res.statusCode == 200) {
      var songs = jsonDecode(res.body);
      return requestFromJson(songs);
    } else {
      throw Exception('Failed to get songs.');
    }
  }
}
