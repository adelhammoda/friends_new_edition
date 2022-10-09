class StringManager {
  ///errors
  static const navigatorErrorMessage =
      "Some error happened while trying to navigate to another page";
  static const networkErrorMessage =
      "You don't have connection to the internet.Please make sure to connect your device";
  static const authErrorMessage =
      "You have some unknown error while connecting to server.if you faced this error so many time please tell us.";
  static const cashErrorMessage = "We faced some problem in cashing user.";
  static const fetchCashedUserErrorMessage =
      "We faced some problem in fetching user.";
  static const decodedCashedDataMessage =
      "We can't decode the data.we faced some error please try again";
  static const createUserErrorMessage =
      '''Can't create user for some reason please try again later
      .if this error continue happening, please contact us and give us your feedback''';
  static const registerUnknownErrorMessage =
      "Unknown error happened while trying to register";
  static const unknownErrorMessage =
      "Unknown error happened.Sorry for that";
  static const deviceInfoErrorMessage =
      "Can't getting some info form your device.We need this info to continue our process";
  static const createErrorDataMissing =
      "Some data is missing.Please try with another way";
  static const unsupportedPlatformError =
      "Unsupported platform.It seems your platform have some issue.So we can't get important data";
  static const signupWithFacebookErrorMessage =
  "Error while trying to sign in with Facebook";
  static const cantFindUserInCashErrorMessage =
  "Can not find user in cash to delete it.This maybe led to some problems";
  static const noUserRegistered =
  "There is no user registered on this device to complete this process";
  static const noDataErrorMessage =
  "There is no no data";
  static const localStoringErrorMessage =
  "There is some error in local storing.";
  static const autoLoginErrorMessage =
  "There is some error in auto login.";
  static const userNotFoundErrorMessage =
  "We can't find user in database.";
  static const badFormatErrorMessage =
  "Bad format in received data.";
  static const userIsNotAuthenticated =
  "This user is not authenticated.";
  static const missingDataErrorMessage =
  "Some data is missing.";
  static const autoLoginUnknownErrorMessage =
  "There some error in auto login please login manually.";
  static const addingToCashFailedErrorMessage =
  "We can't add any data to cash.";
  static const cantFetchUserErrorMessage =
  "We can't fetch the owner of this offer.";

  //validation message
  static const requiredField = "This Field must be filled with data";
  static const shortPassword = "This Password is too short.It must be more than 7 character";
  static const passwordIsRequired = "You must have password and confirm it in this field";
  static const passwordsDoseNotMatch = "Your password and this password dons not match";
  static const badEmailFormat = "Your email is formatted badly.Make sure you write it in the correct way";
  static const onlyNumbers = "This field do not accept letter or symbol.only numbers is allowed";
  ///
  static const emailHint = "Email";
  static const passwordHint = "Password";
  static const confirmPassword = "Confirm password";
  static const login = "Login";
  static const createAccount = "Create account";
  static const forgetPassword = "Forget password";
  static const loginWithGoogle = "Login with Google";
  static const loginWithFacebook = "Login with Facebook";
  static const loginWithApple = "Login with Apple";
  static const loginWithEmail = "Login with Email";
  static const register = "Register";
  static const create = "Create";
  static const userName = "User Name";
  static const signupWithGoogle = "Signup with Google";
  static const signupWithFacebook = "Signup with Facebook";
  static const signupWithApple = "Signup with Apple";
  static const signupWithEmail = "Signup with Email";
  static const phoneNumber  = "Phone number";
  static const optional  = "(Optional)";
  static const alreadyHaveAccount = "Already have an account?";
  static const search = "Search";
  static const home = "Home";
  static const favorite = "Favorite";
  static const setting = "Setting";
  static const mode = "Mode";
  static const deleteAccount = "Delete account";
  static const logout = "Logout";
  static const description = "Description";

  static const or = "or";
}

class ConstantManager {
  ///app constant
  static const appTitle = "Friends";

  ///cashed keys.
  static const cashedEmailAndPasswordKey = "user_data";
  static const cashedUser = "user";

  ///login loading state keys.
  static const loadingStatusForAuth = "Login";
  static const loadingStatusForAuthenticationWithGoogle = "Google";
  static const loadingStatusForAuthenticationWithFacebook = "Facebook";
  static const loadingStatusForAuthenticationWithApple = "Apple";

  ///
  /// public message
  static const String error = "Error";
  static const String success = "Success";

  ///
  /// users type
  static const String studentType = "Student";

  // firebase constant
  static const String usersRef = "users";
  static const String offersRef = "offers";
  ///public
  static const String syrianNumber = "+963";
  ///map keys
 static const String passwordKeyForMap = "Password";
  ///map keys
  ///offers
  static const String offerId = "offer_id";
  static const String offerName="offer_name";
  static const String offerStartDate="start_date";
  static const String offerEndDate="end_date";
  static const String offerDescription="description";
  static const String offerInfo="info";
  static const String offerOwnerId="owner_id";
  static const String offerTotalCapacity="total_capacity";
  static const String offerValue="value";
  static const String offerImages="images";
  static const String offerDiscount="discount";
  ///users
  static const String userId = "user_id";
  ///hive
  static const String hivePath = "./hive";
  static const String hiveDatabaseName = "offers_database";
  static const String hiveBoxNameForOffer = "offers_box";
  static const String hiveCollectionName = "friends_collection";
  static const Set<String> hiveBoxesName = {hiveBoxNameForOffer};
}

class AssetsManager {
  //svg
  static const String _mainPath = 'assets/images';
  static const String facebook = '$_mainPath/facebook.svg';
  static const String instagram = '$_mainPath/instagram.svg';
  static const String email = '$_mainPath/email.svg';
  static const String emailLogo = "$_mainPath/email_logo.svg";
  static const String googleLogo = "$_mainPath/google_logo.svg";
  static const String facebookLogo = "$_mainPath/facebook_logo.svg";
  static const String appleLogo = "$_mainPath/apple_logo.svg";
  static const String user = "$_mainPath/user.svg";

  ///png
  static const String background = '$_mainPath/background.png';
  static const String bigLogo = "$_mainPath/big_logo.png";
  static const String mediumLogo = "$_mainPath/medium_logo.png";
  static const String smallLogo = "$_mainPath/small_logo.png";
  static const String onBoardingBackground = "$_mainPath/on_boarding_image.png";
  static const String userImagePlaceHolder = "$_mainPath/user.png";
  static const String userPlaceHolderIcon = "$_mainPath/user_placeholder_icon.png";

  ///fonts
  static const String roboto = "roboto";
  static const String firaCode = "firaCode";

  ///lottie
  static const String loader = "assets/lottie/loader.json";
  static const String successAnimation = "assets/lottie/success.json";
  static const String wrongAnimation = "assets/lottie/error.json";
  static const String offerPlaceHolder = "assets/lottie/offer_placeholder.json";
  static const String shiningAnimation = "assets/lottie/shining.json";
}
