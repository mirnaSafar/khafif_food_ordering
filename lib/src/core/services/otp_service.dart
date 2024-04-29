import 'dart:async';
import 'dart:math';

class OtpService {
  late Timer _resendTimer;
  final int _resendTimeoutSeconds = 60; // Adjust as needed

  String generateOTP(int length) {
    var rand = Random();
    String result = '';
    for (var i = 0; i < length; i++) {
      result += rand.nextInt(9).toString();
    }
    return result;
  }

  void startResendTimer(Function callback) {
    _resendTimer = Timer(Duration(seconds: _resendTimeoutSeconds), () {
      callback(); // This is where you would resend the OTP
    });
  }

  void cancelResendTimer() {
    _resendTimer.cancel();
  }
}
