class UserPos {
  String? userName;
  String? password;
  String? createdAt;
  String? updatedAt;
  late bool isLogin;
  late String language;

  UserPos(
      {this.userName = 'pos',
      this.password = '',
      this.createdAt,
      this.updatedAt,
      this.isLogin = false,
      this.language = 'vi'});
  UserPos.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    password = json['password'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    isLogin = json['isLogin'];
    language = json['language'] ?? 'vi';
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['userName'] = userName;
    data['password'] = password;
    data['createdAt'] = createdAt.toString();
    data['updatedAt'] = updatedAt.toString();
    data['language'] = language;
    data['isLogin'] = isLogin;
    return data;
  }
}
