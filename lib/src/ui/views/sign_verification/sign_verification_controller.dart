import 'package:get/get.dart';

class OtpController extends GetxController {
  RxBool enterNumberStep = true.obs;
  RxBool enterCodeStep = false.obs;
  RxBool enterNewPasswordStep = false.obs;

  goToStep1() {
    enterNumberStep.value = true;
    enterCodeStep.value = false;
    enterNewPasswordStep.value = false;
  }

  goToStep2() {
    enterNumberStep.value = false;
    enterCodeStep.value = true;
    enterNewPasswordStep.value = false;
  }
}
