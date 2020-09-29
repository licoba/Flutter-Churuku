import 'package:flutter/material.dart';
import 'package:flutter_churuku/models/profile.dart';
import 'package:flutter_churuku/models/user.dart';
import 'package:flutter_churuku/others/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_churuku/utils/sp_util.dart';

const _themes = <MaterialColor>[
  Colors.blue,
  Colors.cyan,
  Colors.teal,
  Colors.green,
  Colors.red,
];

class Global {
  static Profile profile = Profile();


  static Future init() async {
    profile =
    SpUtil.getObj(kProfile, (v) => Profile.fromJson(v)) == null
        ? Profile()
        : SpUtil.getObj(kProfile, (v) => Profile.fromJson(v));
  }


  // 可选的主题列表
  static List<MaterialColor> get themes => _themes;

  // 是否为release版
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  // 持久化Profile信息(包含全局的User对象、主题颜色)
  static saveProfile() {
    SpUtil.putObject(kProfile, profile);
  }
}
