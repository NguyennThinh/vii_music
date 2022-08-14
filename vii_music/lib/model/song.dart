import 'package:vii_music/model/author.dart';
import 'package:vii_music/model/singer.dart';

class Song {
  String? sId;
  String? name;
  Author? author;
  Singer? singer;
  int? createAt;
  String? timeSong;
  String? thumbnail;
  int? listen;
  int? download;
  String? urlSong;

  Song(
      {this.sId,
      this.name,
      this.author,
      this.singer,
      this.createAt,
      this.timeSong,
      this.thumbnail,
      this.listen,
      this.download,
      this.urlSong});

  Song.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    singer = json['singer'] != null ? Singer.fromJson(json['singer']) : null;
    createAt = json['createAt'];
    timeSong = json['timeSong'];
    thumbnail = json['thumbnail'];
    listen = json['listen'];
    download = json['download'];
    urlSong = json['urlSong'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    if (author != null) {
      data['author'] = author!.toJson();
    }
    if (singer != null) {
      data['singer'] = singer!.toJson();
    }
    data['createAt'] = createAt;
    data['timeSong'] = timeSong;
    data['thumbnail'] = thumbnail;
    data['listen'] = listen;
    data['download'] = download;
    data['urlSong'] = urlSong;
    return data;
  }
}
