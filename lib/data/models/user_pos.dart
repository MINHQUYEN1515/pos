class UserPos {
  String? userName;
  String? password;
  DateTime? createdAt;
  DateTime? updatedAt;

  UserPos(
      {this.userName = 'pos',
      this.password = '',
      this.createdAt,
      this.updatedAt});
  UserPos.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['userName'] = this.userName;
    data['password'] = this.password;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    return data;
  }
}
