import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
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
    if (!(value.toString().startsWith('05'))) {
      return tr('number_must_start_with_5_lb');
    }
    if (!validNumber(value)) {
      return tr('invalid_number_lb');
    }

    return null;
  } else {
    return tr('enter_number_lb');
  }
}

emailValidator(String? value) {
  if (value!.isNotEmpty) {
    if (!isEmail(value)) {
      return tr('invalid_email_lb');
    }
    return null;
  } else {
    return tr('enter_email_lb');
  }
}

nameValidator(String? value) {
  if (value!.isEmpty) {
    // if (!isName(value)) {

    // }
    // return null;
    // return 'invalid name';
    return tr('enter_name_lb');
  } else {}
}
