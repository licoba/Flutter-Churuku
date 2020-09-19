import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_churuku/common/localization/default_localizations.dart';
import 'package:flutter_churuku/common/style/gsy_style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'navigator_utils.dart';


/**
 * 通用逻辑
 * Created by guoshuyu
 * Date: 2018-07-16
 */
class CommonUtils {
  static final double MILLIS_LIMIT = 1000.0;

  static final double SECONDS_LIMIT = 60 * MILLIS_LIMIT;

  static final double MINUTES_LIMIT = 60 * SECONDS_LIMIT;

  static final double HOURS_LIMIT = 24 * MINUTES_LIMIT;

  static final double DAYS_LIMIT = 30 * HOURS_LIMIT;

  static Locale curLocale;

  static String getDateStr(DateTime date) {
    if (date == null || date.toString() == null) {
      return "";
    } else if (date.toString().length < 10) {
      return date.toString();
    }
    return date.toString().substring(0, 10);
  }



  ///日期格式转换
  static String getNewsTimeStr(DateTime date) {
    int subTimes =
        DateTime.now().millisecondsSinceEpoch - date.millisecondsSinceEpoch;

    if (subTimes < MILLIS_LIMIT) {
      return (curLocale != null)
          ? (curLocale.languageCode != "zh") ? "right now" : "刚刚"
          : "刚刚";
    } else if (subTimes < SECONDS_LIMIT) {
      return (subTimes / MILLIS_LIMIT).round().toString() +
          ((curLocale != null)
              ? (curLocale.languageCode != "zh") ? " seconds ago" : " 秒前"
              : " 秒前");
    } else if (subTimes < MINUTES_LIMIT) {
      return (subTimes / SECONDS_LIMIT).round().toString() +
          ((curLocale != null)
              ? (curLocale.languageCode != "zh") ? " min ago" : " 分钟前"
              : " 分钟前");
    } else if (subTimes < HOURS_LIMIT) {
      return (subTimes / MINUTES_LIMIT).round().toString() +
          ((curLocale != null)
              ? (curLocale.languageCode != "zh") ? " hours ago" : " 小时前"
              : " 小时前");
    } else if (subTimes < DAYS_LIMIT) {
      return (subTimes / HOURS_LIMIT).round().toString() +
          ((curLocale != null)
              ? (curLocale.languageCode != "zh") ? " days ago" : " 天前"
              : " 天前");
    } else {
      return getDateStr(date);
    }
  }


  static String removeTextTag(String description) {
    if (description != null) {
      String reg = "<g-emoji.*?>.+?</g-emoji>";
      RegExp tag = new RegExp(reg);
      Iterable<Match> tags = tag.allMatches(description);
      for (Match m in tags) {
        String match = m
            .group(0)
            .replaceAll(new RegExp("<g-emoji.*?>"), "")
            .replaceAll(new RegExp("</g-emoji>"), "");
        description = description.replaceAll(new RegExp(m.group(0)), match);
      }
    }
    return description;
  }


  static splitFileNameByPath(String path) {
    return path.substring(path.lastIndexOf("/"));
  }

  static getFullName(String repository_url) {
    if (repository_url != null &&
        repository_url.substring(repository_url.length - 1) == "/") {
      repository_url = repository_url.substring(0, repository_url.length - 1);
    }
    String fullName = '';
    if (repository_url != null) {
      List<String> splicurl = repository_url.split("/");
      if (splicurl.length > 2) {
        fullName =
            splicurl[splicurl.length - 2] + "/" + splicurl[splicurl.length - 1];
      }
    }
    return fullName;
  }



  static Future<Null> showLoadingDialog(BuildContext context,String message) {
    return NavigatorUtils.showGSYDialog(
        context: context,
        builder: (BuildContext context) {
          return new Material(
              color: Colors.transparent,
              child: WillPopScope(
                onWillPop: () => new Future.value(false),
                child: Center(
                  child: new Container(
                    width: 200.0,
                    height: 200.0,
                    padding: new EdgeInsets.all(4.0),
                    decoration: new BoxDecoration(
                      color: Colors.transparent,
                      //用一个BoxDecoration装饰器提供背景图片
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    ),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Container(
                            child: SpinKitRing(color: GSYColors.white,size: 40,lineWidth: 3.5,)),
                        new Container(height: 10.0),
                        new Container(
                            child: new Text(
                                message,
                                style: GSYConstant.middleTextWhite)),
                      ],
                    ),
                  ),
                ),
              ));
        });
  }



}
