import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_and_voice_call_app_using_zegocloud/constant/common.dart';
import 'package:video_and_voice_call_app_using_zegocloud/constant/constants.dart';
import 'package:video_and_voice_call_app_using_zegocloud/constant/secrets.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';

Future<void> login({required String userId, required String userName}) async {
  final pref = await SharedPreferences.getInstance();
  pref.setString(cacheUserIDKey, userId);

  currentUser.id = userId;
  currentUser.name = "user_$userId";
}

Future<void> logout() async {
  final pref = await SharedPreferences.getInstance();
  pref.remove(cacheUserIDKey);
}

void onUserLogin() {
  ZegoUIKitPrebuiltCallInvitationService().init(
    appID: AppSecrets.apiKey,
    appSign: AppSecrets.apiSecret,
    userID: currentUser.id,
    userName: currentUser.name,
    plugins: [ZegoUIKitSignalingPlugin()],
    requireConfig: (ZegoCallInvitationData data) {
      final config = (data.invitees.length > 1)
          ? ZegoCallInvitationType.videoCall == data.type
              ? ZegoUIKitPrebuiltCallConfig.groupVideoCall()
              : ZegoUIKitPrebuiltCallConfig.groupVoiceCall()
          : ZegoCallInvitationType.videoCall == data.type
              ? ZegoUIKitPrebuiltCallConfig.oneOnOneVideoCall()
              : ZegoUIKitPrebuiltCallConfig.oneOnOneVoiceCall();

      config.avatarBuilder = customAvatarBuilder;
      config.topMenuBar.isVisible = true;
      config.topMenuBar.buttons
          .insert(0, ZegoCallMenuBarButtonName.minimizingButton);
      config.topMenuBar.buttons
          .insert(1, ZegoCallMenuBarButtonName.soundEffectButton);

      return config;
    },
  );
}

/// on user logout
void onUserLogout() {
  /// 5/5. de-initialization ZegoUIKitPrebuiltCallInvitationService when account is logged out
  ZegoUIKitPrebuiltCallInvitationService().uninit();
}
