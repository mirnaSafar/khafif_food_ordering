import 'package:khafif_food_ordering_application/src/core/utility/string_utils.dart';

confirmPassword(value, password) {
  if (value!.isNotEmpty) {
    if (!isPassword(value)) return 'invalid password';
    return password != value ? 'not match' : null;
  } else {
    return 'enter your password';
  }
}

String? passValidator(value) {
  if (value!.isNotEmpty) {
    if (!isPassword(value)) {
      return 'invalid password';
    }
    return null;
  } else {
    return 'enter your password';
  }
}

String? numberValidator(value) {
  if (value!.isNotEmpty) {
    if (!validNumber(value)) {
      return 'invalid number';
    }
    return null;
  } else {
    return 'enter your number';
  }
}

emailValidator(String? value) {
  if (value!.isNotEmpty) {
    if (!isEmail(value)) {
      return 'invalid email';
    }
    return null;
  } else {
    return 'enter your email';
  }
}

nameValidator(String? value) {
  if (value!.isEmpty) {
    // if (!isName(value)) {

    // }
    // return null;
    // return 'invalid name';
    return 'enter your name';
  } else {}
}
