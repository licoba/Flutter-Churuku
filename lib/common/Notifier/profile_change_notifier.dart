import 'package:flutter/foundation.dart';
import 'package:flutter_churuku/common/global/global_object.dart';
import 'package:flutter_churuku/models/profile.dart';
import 'package:flutter_churuku/models/user.dart';

class ProfileChangeNotifier extends ChangeNotifier {
  Profile get _profile => Global.profile;

  @override
  void notifyListeners() {
    Global.saveProfile(); //保存Profile变更
    super.notifyListeners(); //通知依赖的Widget更新
  }
}


class UserModel extends ProfileChangeNotifier {
  User get user => _profile.user;

  // APP是否登录(如果有用户信息，则证明登录过)
  bool get isLogin => user != null;

  //用户信息发生变化，更新用户信息并通知依赖它的子孙Widgets更新
  set user(User user) {
      _profile.user = user;
      notifyListeners();
  }
}
