class Singer {
  String? sId;
  String? name;
  int? year;
  String? avatar;
  List<String>? songs;

  Singer({this.sId, this.name, this.year, this.avatar, this.songs});

  Singer.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    year = json['year'];
    avatar = json['avatar'];
    songs = json['songs'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['year'] = year;
    data['avatar'] = avatar;
    data['songs'] = songs;

    return data;
  }
}
