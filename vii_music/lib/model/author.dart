class Author {
  String? sId;
  String? name;
  List<String>? songs;

  Author({this.sId, this.name, this.songs});

  Author.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    songs = json['songs'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['songs'] = songs;
    return data;
  }
}
