class Userinfo {
  var userId, email, name;
  Userinfo({required this.userId, required this.email, required this.name});
  Userinfo.fromJson(Map<dynamic, dynamic> map) {
    if (map == null) return;
    userId = map['userId'];
    email = map['email'];
    name = map['name'];
  }
  toJson() {
    return {'userId': userId, 'email': email, 'name': name};
  }
}
