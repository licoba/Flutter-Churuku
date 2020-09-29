/// admin : false
/// chapterTops : [1,2,3]
/// coinCount : 0
/// collectIds : [15421,15461,15343]
/// email : ""
/// icon : ""
/// id : 22853
/// nickname : "licoba"
/// password : ""
/// publicName : "licoba"
/// token : ""
/// type : 0
/// username : "licoba"

class User {
  bool _admin;
  List<int> _chapterTops;
  int _coinCount;
  List<int> _collectIds;
  String _email;
  String _icon;
  int _id;
  String _nickname;
  String _password;
  String _publicName;
  String _token;
  int _type;
  String _username;

  bool get admin => _admin;

  List<int> get chapterTops => _chapterTops;

  int get coinCount => _coinCount;

  List<int> get collectIds => _collectIds;

  String get email => _email;

  String get icon => _icon;

  int get id => _id;

  String get nickname => _nickname;

  String get password => _password;

  String get publicName => _publicName;

  String get token => _token;

  int get type => _type;

  String get username => _username;

  User(
      {bool admin,
      List<int> chapterTops,
      int coinCount,
      List<int> collectIds,
      String email,
      String icon,
      int id,
      String nickname,
      String password,
      String publicName,
      String token,
      int type,
      String username}) {
    _admin = admin;
    _chapterTops = chapterTops;
    _coinCount = coinCount;
    _collectIds = collectIds;
    _email = email;
    _icon = icon;
    _id = id;
    _nickname = nickname;
    _password = password;
    _publicName = publicName;
    _token = token;
    _type = type;
    _username = username;
  }


  set admin(bool value) {
    _admin = value;
  }

  User.fromJson(dynamic json) {
    _admin = json["admin"];
    _chapterTops =
        json["chapterTops"] != null ? json["chapterTops"].cast<int>() : [];
    _coinCount = json["coinCount"];
    _collectIds =
        json["collectIds"] != null ? json["collectIds"].cast<int>() : [];
    _email = json["email"];
    _icon = json["icon"];
    _id = json["id"];
    _nickname = json["nickname"];
    _password = json["password"];
    _publicName = json["publicName"];
    _token = json["token"];
    _type = json["type"];
    _username = json["username"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["admin"] = _admin;
    map["chapterTops"] = _chapterTops;
    map["coinCount"] = _coinCount;
    map["collectIds"] = _collectIds;
    map["email"] = _email;
    map["icon"] = _icon;
    map["id"] = _id;
    map["nickname"] = _nickname;
    map["password"] = _password;
    map["publicName"] = _publicName;
    map["token"] = _token;
    map["type"] = _type;
    map["username"] = _username;
    return map;
  }

  @override
  String toString() {
    return 'User{_admin: $_admin, _chapterTops: $_chapterTops, _coinCount: $_coinCount, _collectIds: $_collectIds, _email: $_email, _icon: $_icon, _id: $_id, _nickname: $_nickname, _password: $_password, _publicName: $_publicName, _token: $_token, _type: $_type, _username: $_username}';
  }

  set chapterTops(List<int> value) {
    _chapterTops = value;
  }

  set coinCount(int value) {
    _coinCount = value;
  }

  set collectIds(List<int> value) {
    _collectIds = value;
  }

  set email(String value) {
    _email = value;
  }

  set icon(String value) {
    _icon = value;
  }

  set id(int value) {
    _id = value;
  }

  set nickname(String value) {
    _nickname = value;
  }

  set password(String value) {
    _password = value;
  }

  set publicName(String value) {
    _publicName = value;
  }

  set token(String value) {
    _token = value;
  }

  set type(int value) {
    _type = value;
  }

  set username(String value) {
    _username = value;
  }
}
