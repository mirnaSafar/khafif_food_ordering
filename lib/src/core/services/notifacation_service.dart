// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/navigator_extension.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/size_extensions.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/fcm_token_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_text.dart';
import 'package:khafif_food_ordering_application/src/ui/views/notifications_view/notifications_view.dart';

class NotificationService {
  StreamController<RemoteMessage> notifcationStream =
      StreamController<RemoteMessage>.broadcast();
  RxList<RemoteMessage> notifcationsList = storage.getNotificationList().obs;

  NotificationService() {
    onInit();
  }

  void onInit() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    if (GetPlatform.isIOS) {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (settings.authorizationStatus == AuthorizationStatus.authorized) {
        await registerdFCMToken();
      } else {
        return;
      }
    } else {
      await registerdFCMToken();
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // RemoteMessage model =
      //     RemoteMessage.fromJson(message.notification as Map<String, dynamic>);

      handelNotification(model: message, appState: AppState.FOREGROUND);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      // RemoteMessage model = RemoteMessage.fromJson(
      //     message.notification as Map<String, dynamic>);
      handelNotification(model: message, appState: AppState.BACKGROUND);
    });
  }

  Future<void> deleteFcmToken() async {
    await FirebaseMessaging.instance.deleteToken();
  }

  Future<void> registerdFCMToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    print(fcmToken);
    //! -- Call api that register fcm token ---
    FcmTokenRepository().saveFcmToken(fcmToken: fcmToken!);
    FirebaseMessaging.instance.onTokenRefresh.listen((fcmToken) {
      //! -- Call api that register fcm token ---
      FcmTokenRepository().saveFcmToken(fcmToken: fcmToken);

      // TODO: If necessary send token to application server.

      // Note: This callback is fired at each app startup and whenever a new
      // token is generated.
    }).onError((err) {
      // Error getting token.
    });
  }

  void handelNotification(
      {required RemoteMessage model, required AppState appState}) {
    notifcationStream.add(model);
    productsVieewController.notificationsCount.value++;
    notifcationsList.add(model);
    storage.setNotificationList(notifications: notifcationsList);

    switch (appState) {
      case AppState.TERMINATED:
      case AppState.BACKGROUND:
        Get.to(NotificationsView());

      case AppState.FOREGROUND:
        showDialog(
            context: Get.context!,
            builder: (BuildContext context) {
              return DefaultTextStyle(
                style: TextStyle(),
                child: SizedBox(
                  width: context.screenWidth(1),
                  height: context.screenWidth(2),
                  child: AlertDialog(
                    alignment: Alignment.topCenter,
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            context.pop();
                            Get.to(NotificationsView());
                          },
                          child: Text('ok'))
                    ],
                    title: CustomText(
                      text: model.notification!.title ?? '',
                      textType: TextStyleType.BODY,
                    ),
                    content: Text(model.notification!.body ?? ''),
                  ),
                ),
              );
            });
        Future.delayed(Duration(seconds: 5), () {
          Get.back();
        });
    }

    // if (model.notifctionType == NotificationType.SUBSCRIPTION.name) {
    //   storage.setSubStatus(model.subStatus == "true");
    // }
  }
}
