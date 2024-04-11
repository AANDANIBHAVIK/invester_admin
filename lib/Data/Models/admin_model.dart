class AdminModel {
  String? password;
  String? username;
  String? aid;

  AdminModel({this.password, this.username, this.aid});

  AdminModel.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    username = json['username'];
    aid = json['aid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['username'] = this.username;
    data['aid'] = this.aid;
    return data;
  }
}
