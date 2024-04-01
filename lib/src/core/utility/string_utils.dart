bool isEmail(String value) {
  RegExp regExp = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$");
  return regExp.hasMatch(value);
}

bool isPassword(String value) {
  RegExp regExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
  return regExp.hasMatch(value);
}

bool isName(String value) {
  RegExp regExp = RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
  return regExp.hasMatch(value);
}

bool isLastName(String value) {
  RegExp regExp = RegExp(r"^\s*([A-Za-z]{1,})*$");
  return regExp.hasMatch(value);
}

bool isAddress(String value) {
  RegExp regExp = RegExp(r'^[0-9a-zA-Z\s,-/]+$');
  return regExp.hasMatch(value);
}

bool isMobile(String value) {
  RegExp regExp = RegExp(r'^\+?00963[0-9]{9}$');
  return regExp.hasMatch(value);
}

//! This to validate syrian number phone And this better than before (isMobile)
bool validNumber(String value) {
  // RegExp regex = RegExp(r'^(!?(\+|00)?(966)|0)?9\d{8}$');
  RegExp regex = RegExp(r'^5[0-9]{8}$');

  return regex.hasMatch(value);
}

bool isage18(String value) {
  RegExp regExp = RegExp(r'^(?:1[8-9]|[2-9][0-9])$');
  return regExp.hasMatch(value);
}
