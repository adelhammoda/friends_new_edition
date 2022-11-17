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
  static const noUserInLocalStorage =
  "There is no user found in local storage. please login again or register.If this failure still appearing report us";
    static const youAreNotLoggedIn =
  "You are not logged in.You can browse the app.but some feature will still missing";
    static const fetchSubscriptionException =
  "We faced some problem in fetching packages.";
    static const thisUserIsNotStudent =
  "This user is not registered  as student.Some feature will be disabled for him .";
    static const dontHavePermissions =
  "We don't have the right permission.Please make sure you give us the right permissions";
    static const permissionToCameraIdDeniedErrorMessage =
  "We can't access to your camera because of permissions.";
    static const cannotOpenCameraErrorMessage =
  "Can't open camera due to some errors";
    static const cannotCloseCameraErrorMessage =
  "Can't close camera due to some errors";

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
  static const success = "Success";
  static const or = "or";
  static const from = "from";
  static const to = "to";
  static const scannedBy = "ScannedBy";
  static const pleaseScanHere = "Please scan here";
  static const generate = "Generate";
  static const itWillDisappearIn2Minutes = "It will disappear in 2 minutes";
  static const placeYourDeviceOnQrCode = "Press on the button then scan the QR code using your camera";
  static const openCamera = "open camera";
  static const ownedPackages = "Owned Packages";

  static const String subscribed = "Subscribed";
  static const String unsubscribed = "Unsubscribed";
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
  static const String offerOwnerType = "Offer_Owner";
  static const String subscriptionCenterType = "Subscription_center";
  static const String adminType = "admin";

  /// firebase constant
  static const String usersRef = "users";
  static const String offersRef = "offers";
  static const String subscriptionRef = "subscriptions_packages";
  static const String subscribeRef = "subscriptions";
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
  ///subscription
  static const String subscriptionName = "s_name";
  static const String subscriptionID = "s_id";
  static const String subscriptionImageUrl = "s_imageUrl";
  static const String subscriptionBorderColor = "s_bordColor";
  static const String subscriptionEndDate = "s_endDate";
  static const String subscriptionStartDate = "s_StartDate";
  static const String subscriptionBackGroundColor = "s_backGroundColor";
  static const String subscriptionCurrency = "s_Currency";
  static const String subscriptionPrice = "s_price";
  static const String subscriptionDescription = "s_description";
  ///subscribe
  static const String subscribeId = "subscribe_id";
  static const String subscribeUserId = "subscribe_user_id";
  static const String subscribeSubscriptionTypeID = "subscription_type_id";
  static const String subscribeDate = "subscribe_date";
  static const String subscribeCenterId = "subscribe_center_id";
  ///users
  static const String userId = "user_id";
  ///hive
  static const String hivePath = "./hive";
  static const String hiveDatabaseName = "offers_database";
  static const String hiveBoxNameForOffer = "offers_box";
  static const String hiveBoxNameForSubscription = "subscription_box";
  static const String hiveCollectionName = "friends_collection";
  static const Set<String> hiveBoxesName = {hiveBoxNameForOffer};
  ///stackHolder
  static const String stackHolderEmail= "test@gmail.com";
  static const String stackHolderName = "User";
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
  static const String bellAnimation = "assets/lottie/bell.json";
  static const String noNetworkAnimation = "assets/lottie/no_network.json";
  static const String scanQrAnimation = "assets/lottie/scan_code.json";
}
