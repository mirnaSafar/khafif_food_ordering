import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_assets.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/padding_extension.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_button.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/user_input.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/validation_functions.dart';
import 'package:khafif_food_ordering_application/src/ui/views/otp_view/otp_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
//   late TextEditingController _controllerPeople, _controllerMessage;
//   String? _message, body;
//   String _canSendSMSMessage = 'Check is not run.';
//   List<String> people = [];
//   bool sendDirect = false;

//   @override
//   void initState() {
//     super.initState();
//     initPlatformState();
//   }

//   Future<void> initPlatformState() async {
//     _controllerPeople = TextEditingController();
//     _controllerMessage = TextEditingController();
//   }

//   Future<void> _sendSMS(List<String> recipients) async {
//     try {
//       String result = await sendSMS(
//         message: _controllerMessage.text,
//         recipients: recipients,
//         sendDirect: sendDirect,
//       );
//       setState(() => _message = result);
//     } catch (error) {
//       setState(() => _message = error.toString());
//     }
//   }

//   Future<bool> _canSendSMS() async {
//     bool result = await canSendSMS();
//     setState(() => _canSendSMSMessage =
//         result ? 'This unit can send SMS' : 'This unit cannot send SMS');
//     return result;
//   }

//   Widget _phoneTile(String name) {
//     return Padding(
//       padding: const EdgeInsets.all(3),
//       child: Container(
//           decoration: BoxDecoration(
//               border: Border(
//             bottom: BorderSide(color: Colors.grey.shade300),
//             top: BorderSide(color: Colors.grey.shade300),
//             left: BorderSide(color: Colors.grey.shade300),
//             right: BorderSide(color: Colors.grey.shade300),
//           )),
//           child: Padding(
//             padding: const EdgeInsets.all(4),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 IconButton(
//                   icon: const Icon(Icons.close),
//                   onPressed: () => setState(() => people.remove(name)),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(0),
//                   child: Text(
//                     name,
//                     textScaleFactor: 1,
//                     style: const TextStyle(fontSize: 12),
//                   ),
//                 )
//               ],
//             ),
//           )),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('SMS/MMS Example'),
//         ),
//         body: ListView(
//           children: <Widget>[
//             if (people.isEmpty)
//               const SizedBox(height: 0)
//             else
//               SizedBox(
//                 height: 90,
//                 child: Padding(
//                   padding: const EdgeInsets.all(3),
//                   child: ListView(
//                     scrollDirection: Axis.horizontal,
//                     children: List<Widget>.generate(people.length, (int index) {
//                       return _phoneTile(people[index]);
//                     }),
//                   ),
//                 ),
//               ),
//             ListTile(
//               leading: const Icon(Icons.people),
//               title: TextField(
//                 controller: _controllerPeople,
//                 decoration:
//                     const InputDecoration(labelText: 'Add Phone Number'),
//                 keyboardType: TextInputType.number,
//                 onChanged: (String value) => setState(() {}),
//               ),
//               trailing: IconButton(
//                 icon: const Icon(Icons.add),
//                 onPressed: _controllerPeople.text.isEmpty
//                     ? null
//                     : () => setState(() {
//                           people.add(_controllerPeople.text.toString());
//                           _controllerPeople.clear();
//                         }),
//               ),
//             ),
//             const Divider(),
//             ListTile(
//               leading: const Icon(Icons.message),
//               title: TextField(
//                 decoration: const InputDecoration(labelText: 'Add Message'),
//                 controller: _controllerMessage,
//                 onChanged: (String value) => setState(() {}),
//               ),
//             ),
//             const Divider(),
//             ListTile(
//               title: const Text('Can send SMS'),
//               subtitle: Text(_canSendSMSMessage),
//               trailing: IconButton(
//                 padding: const EdgeInsets.symmetric(vertical: 16),
//                 icon: const Icon(Icons.check),
//                 onPressed: () {
//                   _canSendSMS();
//                 },
//               ),
//             ),
//             SwitchListTile(
//                 title: const Text('Send Direct'),
//                 subtitle: const Text(
//                     'Should we skip the additional dialog? (Android only)'),
//                 value: sendDirect,
//                 onChanged: (bool newValue) {
//                   setState(() {
//                     sendDirect = newValue;
//                   });
//                 }),
//             Padding(
//               padding: const EdgeInsets.all(8),
//               child: ElevatedButton(
//                 style: ButtonStyle(
//                   backgroundColor: MaterialStateProperty.resolveWith(
//                       (states) => Theme.of(context).colorScheme.secondary),
//                   padding: MaterialStateProperty.resolveWith(
//                       (states) => const EdgeInsets.symmetric(vertical: 16)),
//                 ),
//                 onPressed: () {
//                   _send();
//                 },
//                 child: Text(
//                   'SEND',
//                   style: Theme.of(context).textTheme.displayMedium,
//                 ),
//               ),
//             ),
//             Visibility(
//               visible: _message != null,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Expanded(
//                     child: Padding(
//                       padding: const EdgeInsets.all(12),
//                       child: Text(
//                         _message ?? 'No Data',
//                         maxLines: null,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   void _send() {
//     if (people.isEmpty) {
//       setState(() => _message = 'At Least 1 Person or Message Required');
//     } else {
//       _sendSMS(people);
//     }
//   }

  OtpController otpController = Get.put(OtpController());
  @override
  Widget build(BuildContext context) {
    var firststepRecievcode = [
      CustomText(
        textAlign: TextAlign.start,
        text: tr('enter_number_lb'),
        textType: TextStyleType.BODY,
      ),
      screenHeight(8).ph,
      UserInput(
          text: tr('phone_field_lb'),
          prefixIcon: Transform.scale(
              scale: 0.5, child: SvgPicture.asset(AppAssets.icPhone))),
      screenHeight(8).ph,
      CustomButton(
        onPressed: () {
          otpController.goToStep2();
        },
        text: tr('send_me_code_lb'),
      ),
    ];

    // var secondStepEnterRecievedCode = [
    //   CustomText(
    //     textAlign: TextAlign.start,
    //     text: tr('enter_code_lb'),
    //     textType: TextStyleType.BODY,
    //   ),
    //   screenHeight(8).ph,
    //   CustomPinCodeTextFields(
    //       onCompleted: (String value) {
    //         otpController.verifyPhone();
    //       },
    //       number: '+963936166750'),
    // ];

    var thirdstepEnterNewPass = [
      CustomText(
        textAlign: TextAlign.start,
        text: tr('enter_new_pass_lb'),
        textType: TextStyleType.BODY,
      ),
      screenHeight(8).ph,
      UserInput(
        controller: otpController.passController,
        text: tr('pass_field_lb'),
        obscureText: true,
      ),
      screenHeight(40).ph,
      UserInput(
        controller: otpController.confirmPassController,
        validator: (pass) {
          return confirmPassword(pass, otpController.passController.text);
        },
        text: tr('confirm_pass_field_lb'),
        obscureText: true,
      ),
      screenHeight(8).ph,
      CustomButton(
        onPressed: () {
          Get.off(const ProductsView());
        },
        text: tr('done_btn_lb'),
      ),
    ];
    List<List<Widget>> otpSteps = [
      firststepRecievcode,
      // secondStepEnterRecievedCode,
      thirdstepEnterNewPass
    ];
    return SafeArea(
        child: Scaffold(
      appBar: const CustomAppbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth(25), vertical: screenWidth(4)),
          child: Obx(() {
            return Column(
                // mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: tr('reset_pass_lb'),
                    fontWeight: FontWeight.w800,
                    textType: TextStyleType.HEADER,
                  ),
                  ...otpSteps[otpController.current.value]
                ]);
          }),
        ),
      ),
    ));
  }
}
