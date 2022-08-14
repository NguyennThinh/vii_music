import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vii_music/contants.dart';

import 'package:vii_music/model/user.dart';

import '../model/song.dart';

class UserApi {
  static List<Song> requestFromJson(dynamic s) =>
      List<Song>.from((s).map((e) => Song.fromJson(e)));

  static Future<bool> signUp(Users user) async {
    final response = await http.post(Uri.parse('$serverUrl/user/sign-up'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "email": user.email,
          "password": user.password,
          "createAt": user.createAt,
          "updateAt": user.updateAt,
          "isAdmin": user.isAdmin,
          "name": user.name
        }));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<String> login(String email, String password) async {
    final response = await http.post(Uri.parse('$serverUrl/user/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{"email": email, "password": password}));

    if (response.statusCode == 200 || response.statusCode == 400) {
      return response.body;
    } else {
      throw Exception('Failed to login.');
    }
  }

  static Future<bool> loginToken(String token) async {
    final response = await http.post(Uri.parse('$serverUrl/user/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{"token": token}));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> likeSong(String idSong, String idUser) async {
    final response = await http.post(Uri.parse('$serverUrl/song/like'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{"id_song": idSong, "id_user": idUser}));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> dislikeSong(String idSong, String idUser) async {
    final response = await http.post(Uri.parse('$serverUrl/song/dislike'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{"id_song": idSong, "id_user": idUser}));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> songisLike(String idSong, String idUser) async {
    final response = await http.post(Uri.parse('$serverUrl/user/like'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
            <String, dynamic>{"id_song": idSong, "id_user": idUser}));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<List<Song>> getSongbyUser() async {
    var res = await http.get(Uri.parse("$serverUrl/song/listen"));

    if (res.statusCode == 200) {
      var songs = jsonDecode(res.body);
      return requestFromJson(songs);
    } else {
      throw Exception('Failed to get songs.');
    }
  }
}
