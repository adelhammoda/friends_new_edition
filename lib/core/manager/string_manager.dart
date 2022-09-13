class StringManager {
  ///errors
  static const navigatorErrorMessage =
      "Some error happened while trying to navigate to another page";
  static const networkErrorMessage =
      "You don't have connection to the internet.Please make sure to connect your device";
  static const authErrorMessage = "You have some unknown error while connecting to server.if you faced this error so many time please tell us.";
  static const cashErrorMessage = "We faced some problem in cashing user.";
  static const fetchCashedUserErrorMessage = "We faced some problem in fetching user.";
  static const decodedCashedDataMessage = "We can't decode the data.we faced some error please try again";
  ///
  static const emailHint = "Email";
  static const passwordHint = "Password";
  static const login = "Login";
  static const createAccount = "Create account";
  static const forgetPassword = "Forget password";
  static const loginWithGoogle = "Login with Google";
  static const loginWithFacebook = "Login with Facebook";
  static const loginWithApple = "Login with Apple";
  static const loginWithEmail = "Login with Email";
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
/// public message
 static const String error = "Error";
 static const String success="Success";

}


class AssetsManager{
  //svg
  static const String _mainPath = 'assets/images';
  static const String facebook = '$_mainPath/facebook.svg';
  static const String instagram = '$_mainPath/instagram.svg';
  static const String email = '$_mainPath/email.svg';
  static const String emailLogo = "$_mainPath/email_logo.svg";
  static const String googleLogo = "$_mainPath/google_logo.svg";
  static const String facebookLogo = "$_mainPath/facebook_logo.svg";
  static const String appleLogo = "$_mainPath/apple_logo.svg";
  ///png
  static const String background = '$_mainPath/background.png';
  static  const String bigLogo = "$_mainPath/big_logo.png";
  static const String mediumLogo= "$_mainPath/medium_logo.png";
  static const String smallLogo = "$_mainPath/small_logo.png";
  ///fonts
  static const String  roboto = "roboto";
  static const String firaCode = "firaCode";
  ///lottie
  static const String loader = "assets/lottie/loader.json";
  static const String successAnimation = "assets/lottie/success.json";
  static const String wrongAnimation = "assets/lottie/error.json";
}
