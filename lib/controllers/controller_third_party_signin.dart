import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:loggy/loggy.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class ThirdPartySignInController extends GetxController {
  final storage = GetStorage();

  Future<UserCredential?> signInWithGoogle() async {
    logDebug('signInWithGoogle');
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      return await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      logError(e);
      return null;
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    // Trigger the sign-in flow
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();

      if (loginResult.accessToken?.token == null) {
        return null;
      }
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } catch (e) {
      logError(e);
      return null;
    }
  }

  void signInWithKakao() async {
    // KakaoContext.clientId = "78c7bc72a57e2e408fe139eed21ed523";
    late OAuthToken kakaoAuth;
    var hasKakaoTalk = await isKakaoTalkInstalled();
    if (hasKakaoTalk) {
      kakaoAuth = await UserApi.instance.loginWithKakaoTalk();
    } else {
      kakaoAuth = await UserApi.instance.loginWithKakaoAccount();
    }
    var response = await http.post(
        Uri.parse("http://192.168.0.7:2394/api/auth/callbacks/kakao/token"),
        body: {"accessToken": kakaoAuth.accessToken});

    var auth = await FirebaseAuth.instance.signInWithCustomToken(response.body);

    logInfo(auth);
  }

  void signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    } catch (e) {
      logError(e);
      return null;
    }
  }
}
