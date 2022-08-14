class Users {
  String? id;
  String? name;
  String? email;
  String? password;
  String? avatar;
  String? createAt;
  String? updateAt;
  bool? isAdmin;

  Users(
      {this.id,
      this.name,
      this.email,
      this.password,
      this.avatar,
      this.createAt,
      this.updateAt,
      this.isAdmin});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    avatar = json['avatar'];
    createAt = json['createAt'];
    updateAt = json['updateAt'];
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['avatar'] = avatar;
    data['createAt'] = createAt;
    data['updateAt'] = updateAt;
    data['isAdmin'] = isAdmin;
    return data;
  }
}
