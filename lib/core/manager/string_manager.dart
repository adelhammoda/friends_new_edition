class StringManager {
  static const navigatorErrorMessage =
      "Some error happened while trying to navigate to another page";
  static const networkErrorMessage =
      "You don't have connection to the internet.Please make sure to connect your device";
  static const authErrorMessage = "You have some unknown error while connecting to server.if you faced this error so many time please tell us.";
  static const cashErrorMessage = "We faced some problem in cashing user.";
  static const fetchCashedUserErrorMessage = "We faced some problem in fetching user.";
  static const decodedCashedDataMessage = "We can't decode the data.we faced some error please try again";
}


class ConstantManager {
  ///app constant
  static const appTitle ="Friends";
  ///cashed email and password key.
  static const cashedEmailAndPasswordKey = "user_data";
  ///login loading state keys.
  static const loadingStatusForLogin = "Login";
  static const loadingStatusForLoginWithGoogle  = "Google";
  static const loadingStatusForLoginWithFacebook  = "Facebook";
  static const loadingStatusForLoginWithApple  = "Apple";
  ///

}


class AssetsManager{
  static const String _mainPath = 'assets/images';
  static const String facebook = '$_mainPath/facebook.svg';
  static const String instagram = '$_mainPath/instagram.svg';
  static const String email = '$_mainPath/email.svg';
  static const String background = '$_mainPath/background.png';
}
