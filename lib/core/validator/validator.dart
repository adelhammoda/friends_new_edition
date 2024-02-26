import 'package:friends/core/manager/string_manager.dart';

class Validator {
  ///make sure that the val passing to this function is not
  ///null or empty string.
  static String? emptyField(String? val) {
    if (val == null || val.isEmpty) {
      return StringManager.requiredField;
    } else {
      return null;
    }
  }

  ///make sure that password contain at least on character and
  ///one number and it's length must be more than 7.
  static String? passwordValidator(String? val) {
    if (val == null || val.isEmpty) {
      return StringManager.requiredField;
    } else if (val.length <= 7) {
      return StringManager.shortPassword;
    } else {
      return null;
    }
  }

  ///compare tow password and confirm if there is any matching
  static String? confirmPassword(String? val, String? oldPassword) {
    if (val == null || val.isEmpty) {
      return StringManager.requiredField;
    } else if (oldPassword == null || oldPassword.isEmpty) {
      return StringManager.passwordIsRequired;
    } else if (val.compareTo(oldPassword) != 0) {
      return StringManager.passwordsDoseNotMatch;
    } else {
      return null;
    }
  }

  ///check all types of email and if the format is true .
  ///it accept:
  ///[ gmail , hotmail , yahoo , outlook , protonMain , icloud , AOL ]
  static String? emailValidation(String? email) {
    String? val = email;
    val?.toLowerCase();
    if (val == null || val.isEmpty) {
      return StringManager.requiredField;
    } else if (!(val.endsWith("@gmail.com") ||
        val.endsWith("@hotmail.com") ||
        val.endsWith("@outlook.com") ||
        val.endsWith("@protonmail.com") ||
        val.endsWith("@aol.com") ||
        val.endsWith("@icloud.com") ||
        val.endsWith("@yahoo.com"))) {
      return StringManager.badEmailFormat;
    } else {
      return null;
    }
  }
  ///make sure that string do not contain numbers
 static  String? containNumber(String? val){
    if(val == null ||val.isEmpty) {
      return null;
    } else {
      num? number = num.tryParse(val);
      if (number == null) {
        return StringManager.onlyNumbers;
      } else {
        return null;
      }
    }
 }
}
