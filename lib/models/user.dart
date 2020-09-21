/// _id : "5e68e13a8f029909c04747e4"
/// username : "licoba"
/// password : 123456
/// phone : 17322309201
/// __v : 0

class User {
  String _id;
  String _username;
  String _password;
  String _phone;

  String get id => _id;
  String get username => _username;
  String get password => _password;
  String get phone => _phone;

  User({
      String id, 
      String username, 
      String password, 
      String phone,
  }){
    _id = id;
    _username = username;
    _password = password;
    _phone = phone;
}

  User.fromJson(dynamic json) {
    _id = json["_id"];
    _username = json["username"];
    _password = json["password"];
    _phone = json["phone"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["Id"] = _id;
    map["username"] = _username;
    map["password"] = _password;
    map["phone"] = _phone;
    return map;
  }

  @override
  String toString() {
    return 'User{_id: $_id, _username: $_username, _password: $_password, _phone: $_phone}';
  }
}