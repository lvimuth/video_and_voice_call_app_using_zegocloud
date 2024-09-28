import 'package:flutter/material.dart';
import 'package:video_and_voice_call_app_using_zegocloud/pages/home_page.dart';
import 'package:video_and_voice_call_app_using_zegocloud/pages/login_page.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';

class PageRouteName {
  static const String login = "/login";
  static const String home = "/home_page";
}

Map<String, WidgetBuilder> routes = {
  PageRouteName.login: (context) => const LoginPage(),
  PageRouteName.home: (context) =>
      const ZegoUIKitPrebuiltCallMiniPopScope(child: HomePage()),
};

class UserInfo {
  String id = "";
  String name = "";

  UserInfo({
    required this.id,
    required this.name,
  });

  bool get isEmpty => id.isEmpty;
  UserInfo.empty();
}

UserInfo currentUser = UserInfo.empty();

const String cacheUserIDKey = 'cache_user_id_key';

const TextStyle textStyle = TextStyle(
  color: Colors.black,
  fontSize: 13.0,
  decoration: TextDecoration.none,
);
