import 'package:flutter_churuku/common/Notifier/profile_change_notifier.dart';
import 'package:flutter_churuku/models/user.dart';

/// user : "$user"
/// token : ""
/// theme : 5678
/// cache : "$cacheConfig"
/// lastLogin : ""
/// locale : ""

class Profile{
  User _user;
  String _token;
  int _theme;
  String _cache;
  String _lastLogin;
  String _locale;

  User get user => _user;
  String get token => _token;
  int get theme => _theme;
  String get cache => _cache;
  String get lastLogin => _lastLogin;
  String get locale => _locale;

  Profile({
      User user,
      String token, 
      int theme, 
      String cache, 
      String lastLogin, 
      String locale}){
    _user = user;
    _token = token;
    _theme = theme;
    _cache = cache;
    _lastLogin = lastLogin;
    _locale = locale;
}

  Profile.fromJson(dynamic json) {
    _user = json["user"] != null ? User.fromJson(json["user"]) : null;
    _token = json["token"];
    _theme = json["theme"];
    _cache = json["cache"];
    _lastLogin = json["lastLogin"];
    _locale = json["locale"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["user"] = _user;
    map["token"] = _token;
    map["theme"] = _theme;
    map["cache"] = _cache;
    map["lastLogin"] = _lastLogin;
    map["locale"] = _locale;
    return map;
  }

  set locale(String value) {
    _locale = value;
  }

  set lastLogin(String value) {
    _lastLogin = value;
  }

  set cache(String value) {
    _cache = value;
  }

  set theme(int value) {
    _theme = value;
  }

  set token(String value) {
    _token = value;
  }

  set user(User value) {
    _user = value;
  }
}