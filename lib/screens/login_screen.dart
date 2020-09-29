import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_churuku/common/Network/Api.dart';
import 'package:flutter_churuku/common/Network/Code.dart';
import 'package:flutter_churuku/common/Network/HttpManager.dart';
import 'package:flutter_churuku/common/Network/ResultData.dart';
import 'package:flutter_churuku/common/localization/default_localizations.dart';
import 'package:flutter_churuku/common/utils/common_utils.dart';
import 'package:flutter_churuku/models/user.dart';
import 'package:flutter_churuku/others/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_churuku/utils/sp_util.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberPassWord = false;

  //用户名输入框控制器，此控制器可以监听用户名输入框操作  https://blog.csdn.net/ljh910329/article/details/95471566
  TextEditingController _userNameController =
      new TextEditingController(text: '');
  TextEditingController _passWordController =
      new TextEditingController(text: '');
  FocusNode _usernameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  @override
  void initState() {
    _userNameController.addListener(() {
      // print('手机号更新：' + _userNameController.text);
    });

    _passWordController.addListener(() {
      // print('密码更新：' + _passWordController.text);
    });
    User user = SpUtil.getObj("userInfo", (v) => User.fromJson(v));
    print('读取到用户：' + user.toString());
    if (user != null) {
      _userNameController.text = user.username;
    }
    _rememberPassWord = SpUtil.getBool("rememberPassWord", defValue: false);
    print('读取到记住密码：' + _rememberPassWord.toString());
    if (_rememberPassWord)
      _passWordController.text = user.password;
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the focus node when the Form is disposed.
    _usernameFocusNode.dispose();
    _passwordFocusNode.dispose();
    _userNameController.dispose();
    _passWordController.dispose();
    super.dispose();
  }

  Widget _buildPhoneTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '账号',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            // focusNode: _usernameFocusNode,
            controller: _userNameController,
            keyboardType: TextInputType.text,
            //数字输入框
            inputFormatters: [
              LengthLimitingTextInputFormatter(11),
              // FilteringTextInputFormatter.digitsOnly, // 新版的API
            ],
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 12.0),
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: '请输入用户名',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '密码',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            // focusNode: _passwordFocusNode,
            obscureText: true,
            controller: _passWordController,
            inputFormatters: [
              LengthLimitingTextInputFormatter(25),
            ],
            style: TextStyle(
              color: Colors.white,
            ),
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(top: 12.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.white,
              ),
              hintText: '请输入密码',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildForgotPasswordBtn(context) {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () {
          print('Forgot Password Button Pressed');
          final snackBar = SnackBar(
            content: Text(' 😊 请前往 玩Android 找回密码'),
            action: SnackBarAction(
              label: '复制号码',
              onPressed: () {
                // Some code to undo the change.
                Clipboard.setData(ClipboardData(text: '17322309201'));
              },
            ),
          );
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(snackBar);
        },
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          '忘记密码?',
          style: kLabelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberPassWord,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  print('_rememberPassWord: '+value.toString());
                  _rememberPassWord = value;
                });
              },
            ),
          ),
          Text(
            '记住密码',
            style: kLabelStyle,
          ),
        ],
      ),
    );
  }

  //登录方法
  _doLogin() async {
    CommonUtils.showLoadingDialog(context, '正在登录，请稍后...');
    ResultData userResultData = await Api.login({
      'username': _userNameController.text.trim(),
      'password': _passWordController.text.trim(),
    });
    Navigator.pop(context);
    User user = User.fromJson(userResultData.data);
    print('==> user:' + user.toString());
    if (userResultData.isSuccess) {
      if (_rememberPassWord) user.password = _passWordController.text;
      SpUtil.putObject("userInfo", user);
      SpUtil.putBool("rememberPassWord", _rememberPassWord);
      Fluttertoast.cancel();
      Fluttertoast.showToast(
          msg: '登录成功',
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green[400],
          fontSize: 16.0);
    }
  }

  // 参照 https://book.flutterchina.club/chapter7/dailog.html
  showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false, //点击遮罩不关闭对话框
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 26.0),
                child: Text("正在登录，请稍后..."),
              )
            ],
          ),
        );
      },
    );
  }

  Widget _buildLoginBtn(context) {
    return Column(children: [
      SizedBox(height: 80),
      Container(
        height: 45.0,
        // padding: EdgeInsets.symmetric(vertical: 25.0),
        width: double.infinity,
        child: RaisedButton(
          elevation: 5.0,
          onPressed: () {
            print('Login Button Pressed');
            FocusScope.of(context).unfocus(); // 收起焦点
            if (_userNameController.text.isEmpty) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text('请输入手机号'),
                ));
              return;
            }
            if (_passWordController.text.isEmpty) {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(SnackBar(
                  content: Text('请输入密码'),
                ));
              return;
            }
            // 进行网络请求  显示Loading框
            // showLoadingDialog();
            _doLogin();
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.white,
          child: Text(
            '登   录',
            style: TextStyle(
              color: Color(0xFF527DAA),
              letterSpacing: 1.5,
              fontSize: 18.5,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      )
    ]);
  }

  Widget _buildSignInWithText() {
    return Column(
      children: <Widget>[
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: kLabelStyle,
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
        ),
      ),
    );
  }

  Widget _buildSocialBtnRow() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildSocialBtn(
            () => print('Login with Facebook'),
            AssetImage(
              'assets/images/facebook.jpg',
            ),
          ),
          _buildSocialBtn(
            () => print('Login with Google'),
            AssetImage(
              'assets/images/google.jpg',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupBtn(context) {
    return Container(
        height: 60,
        margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: GestureDetector(
          onTap: () {
            print('Sign Up Button Pressed');
            Scaffold.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(
                content: Text(' 😊 请前往 玩Android 进行注册'),
              ));
            return;
          },
          child: RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: '没有账号 ? ',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: '立即注册 >',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: Text(GSYLocalizations.i18n(context).app_name)), // 必须要用GSYLocalizations.of先初始化
        body: Builder(builder: (BuildContext context) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(), // 收起焦点
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF73AEF5),
                      Color(0xFF61A4F1),
                      Color(0xFF478DE0),
                      Color(0xFF398AE5),
                    ],
                    stops: [0.1, 0.4, 0.7, 0.9],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 120.0,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: 30.0),
                      _buildPhoneTF(),
                      SizedBox(
                        height: 30.0,
                      ),
                      _buildPasswordTF(),
                      _buildForgotPasswordBtn(context),
                      _buildRememberMeCheckbox(),
                      _buildLoginBtn(context),
                      // _buildSignInWithText(),
                      // _buildSocialBtnRow(),
                      _buildSignupBtn(context),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }));
  }
}
