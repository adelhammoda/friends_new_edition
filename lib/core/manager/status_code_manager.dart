

class StatusCode {
  //local , on device
  static const int unknown =1;
  static const int permissions = 2;
  static const int camera = 3;
  static const int cash = 5;
  static const int localStorage = 6;
  //auth , server
  static const int firebase =10;
  static const int autoLogin = 11;
  static const int userNotFound = 12;
  static const int authentication = 13;
  //navigation , network , format
  static const int navigation = 21;
  static const int network = 20;
  static const int createUser = 25;
  static const int badFormat = 26;
  static const int noData = 27;
  static const int deviceInfo = 30;
  static const int userIsNotStudent = 31;

}