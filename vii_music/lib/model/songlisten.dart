import 'package:vii_music/model/song.dart';

class ListenSong {
  String? sId;
  String? user;
  Song? song;
  String? time;
  String? timeEnd;

  ListenSong({this.sId, this.user, this.song, this.time, this.timeEnd});

  ListenSong.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    user = json['user'];
    song = json['song'] != null ? Song.fromJson(json['song']) : null;
    time = json['time'];
    timeEnd = json['timeEnd'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['user'] = user;
    if (song != null) {
      data['song'] = song!.toJson();
    }
    data['time'] = time;
    data['timeEnd'] = timeEnd;
    return data;
  }
}
