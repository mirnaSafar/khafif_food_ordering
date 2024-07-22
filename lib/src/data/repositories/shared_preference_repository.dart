import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/language_service.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/address_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/cart_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/customer_cart_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/product_template_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geocoding/geocoding.dart' as geo;

class SharedPreferenceRepository {
  SharedPreferences globalSharedPreference = Get.find();

  //! --keys----
  String PREF_FIRST_LAUNCH = 'first launch';
  String PREF_ORDER_DELIVERY_SELECTED = 'order delivery option selected';
  String PREF_FIRST_LAUNCH_DELIVERY_SERVICE = 'first launch DELIVERY_SERVICE';
  String PREF_OTP_VERIFIED = 'otp verified';
  String PREF_LOGGED_IN = 'logged';
  String PREF_NEW_ORDER = 'NEW ORDER';
  String PREF_TOKEN = 'token';
  String PREF_USER_LOCATION = 'user location info';
  String PREF_USER_CURRENT_LOCATION = 'user CURRENT location info';
  String PREF_USER = 'USER INFO';
  String APP_THEME = 'theme';
  String APP_LANGUAGE = 'language';
  String PREF_CART_LIST = 'cart list';
  String PREF_CUSTOMER_CART = 'CURRENT cart';
  String PREF_SUB_STATUS = 'sub_status';
  String PREF_NOTIFICATIONS_STATUS = 'notifications status';
  String PREF_ADDRESS_INFO = 'user address info';
  String PREF_FAVORITES = 'Favorites products';
  String PREF_Deliery_Service_Address = 'DelieryServiceAddress';
  String PREF_NOTIFICATION_KEY = 'notifications';

  setDelieryServiceAddressOrBranch({required String address}) {
    setPreference(
      dataType: DataType.STRING,
      key: PREF_Deliery_Service_Address,
      value: address,
    );
  }

  String getDelieryServiceAddressOrBranch() {
    if (globalSharedPreference.containsKey(PREF_Deliery_Service_Address)) {
      return getPreference(key: PREF_Deliery_Service_Address);
    } else {
      return '';
    }
  }

  setNotificationList({required List<RemoteMessage> notifications}) {
    setPreference(
      dataType: DataType.STRING,
      key: PREF_NOTIFICATION_KEY,
      value: jsonEncode(notifications),
    );
  }

  List<RemoteMessage> getNotificationList() {
    if (globalSharedPreference.containsKey(PREF_NOTIFICATION_KEY)) {
      List<dynamic> list =
          jsonDecode(getPreference(key: PREF_NOTIFICATION_KEY));
      List<RemoteMessage> notifications = [];
      for (var element in list) {
        notifications.add(RemoteMessage.fromMap(element));
      }
      return notifications;
      // return getPreference(key: PREF_NOTIFICATION_KEY);
    } else {
      return [];
    }
  }

  void addUserAddresses(List<AddressModel> address) {
    setPreference(
      dataType: DataType.STRING,
      key: PREF_ADDRESS_INFO,
      value: json.encode(address),
    );
  }

  List<AddressModel> getUserAddresses() {
    if (globalSharedPreference.containsKey(PREF_ADDRESS_INFO)) {
      List<dynamic> list = json.decode(getPreference(key: PREF_ADDRESS_INFO));

      List<AddressModel> addresses = [];
      for (var element in list) {
        addresses.add(AddressModel.fromJson(element));
      }
      return addresses;
    } else {
      return [];
    }
  }

  void recieveNotifications(bool value) {
    setPreference(
      dataType: DataType.BOOLEAN,
      key: PREF_NOTIFICATIONS_STATUS,
      value: value,
    );
  }

  bool isReceiveNotifications() {
    if (Get.find<SharedPreferences>().containsKey(PREF_NOTIFICATIONS_STATUS)) {
      return getPreference(key: PREF_NOTIFICATIONS_STATUS);
    } else {
      return false;
    }
  }

  void setSubStatus(bool value) {
    setPreference(
      dataType: DataType.BOOLEAN,
      key: PREF_SUB_STATUS,
      value: value,
    );
  }

  bool getSubStatus() {
    if (Get.find<SharedPreferences>().containsKey(PREF_SUB_STATUS)) {
      return getPreference(key: PREF_SUB_STATUS);
    } else {
      return true;
    }
  }

  void setCartList(List<CartModel> cart) {
    setPreference(
        key: PREF_CART_LIST,
        dataType: DataType.STRING,
        value: CartModel.encode(cart));
  }

  List<CartModel> getCartList() {
    if (globalSharedPreference.containsKey(PREF_CART_LIST)) {
      return CartModel.decode(getPreference(key: PREF_CART_LIST));
    } else {
      return [];
    }
  }

  void setCart(CustomerCartModel cart) {
    setPreference(
        key: PREF_CUSTOMER_CART,
        dataType: DataType.STRING,
        value: jsonEncode(cart.toJson()));
  }

  CustomerCartModel? getCart() {
    if (globalSharedPreference.containsKey(PREF_CUSTOMER_CART)) {
      return CustomerCartModel.fromJson(
          jsonDecode(getPreference(key: PREF_CUSTOMER_CART)));
    } else {
      return null;
    }
  }

  void setFavoritesList(List<ProductTemplateModel> products) {
    setPreference(
        key: PREF_FAVORITES,
        dataType: DataType.STRING,
        value: json.encode(products));
  }

  List<ProductTemplateModel> getFavoritesList() {
    if (globalSharedPreference.containsKey(PREF_FAVORITES)) {
      final List<dynamic> favoritesDynamic =
          json.decode(getPreference(key: PREF_FAVORITES));
      if (favoritesDynamic.isNotEmpty) {
        return favoritesDynamic
            .map((e) => ProductTemplateModel.fromJson(e))
            .toList();
        //  favoritesDynamic as List<ProductTemplateModel>;
      } else {
        return <ProductTemplateModel>[];
      }
    } else {
      return <ProductTemplateModel>[];
    }
  }

  void setFirstLoggedIn(bool value) {
    setPreference(
      dataType: DataType.BOOLEAN,
      key: PREF_LOGGED_IN,
      value: value,
    );
  }

  bool getFirstLoggedIn() {
    if (globalSharedPreference.containsKey(PREF_LOGGED_IN)) {
      return getPreference(key: PREF_LOGGED_IN);
    } else {
      return true;
    }
  }

  void setNewOrder(bool value) {
    setPreference(
      dataType: DataType.BOOLEAN,
      key: PREF_NEW_ORDER,
      value: value,
    );
  }

  bool getIsNewOrder() {
    if (globalSharedPreference.containsKey(PREF_NEW_ORDER)) {
      return getPreference(key: PREF_NEW_ORDER);
    } else {
      return false;
    }
  }

  void setTokenIno(String value) {
    setPreference(
      dataType: DataType.STRING,
      key: PREF_TOKEN,
      value: value,
      //  jsonEncode(value.toJson()),
    );
  }

  String? getTokenInfo() {
    if (globalSharedPreference.containsKey(PREF_TOKEN)) {
      return getPreference(key: PREF_TOKEN);
      // return UserModel.fromJson(
      //   jsonDecode(),
      // ).token;
    } else {
      return null;
    }
  }

  void setUserLocation(geo.Placemark location, LatLng currentLocation) {
    setPreference(
      dataType: DataType.STRINGLIST,
      key: PREF_USER_LOCATION,
      value: [
        jsonEncode(location.toJson()),
        jsonEncode(currentLocation.toJson()),
      ],
    );
  }

  List? getUserLocation() {
    if (globalSharedPreference.containsKey(PREF_USER_LOCATION)) {
      return [
        geo.Placemark.fromMap(
          jsonDecode(getPreference(key: PREF_USER_LOCATION)[0]),
        ),
        LatLng.fromJson(jsonDecode(getPreference(key: PREF_USER_LOCATION)[1])),
      ];
    } else {
      return null;
    }
  }

  void setCurrentUserLocation(LatLng currentLocation) {
    setPreference(
      dataType: DataType.STRING,
      key: PREF_USER_CURRENT_LOCATION,
      value: jsonEncode(currentLocation.toJson()),
    );
  }

  LatLng? getCurrentUserLocation() {
    if (globalSharedPreference.containsKey(PREF_USER_CURRENT_LOCATION)) {
      return LatLng.fromJson(
          jsonDecode(getPreference(key: PREF_USER_CURRENT_LOCATION)));
    } else {
      return null;
    }
  }

  String get userStreetName =>
      getUserLocation() != null ? getUserLocation()![0].street! : '';
  LatLng? get userCurrentLocation => getCurrentUserLocation();

  void setUserInfo(UserModel user) {
    setPreference(
      dataType: DataType.STRING,
      key: PREF_USER,
      value: jsonEncode(user),
    );
  }

  UserModel? getUserInfo() {
    if (globalSharedPreference.containsKey(PREF_USER)) {
      return UserModel.fromJson(jsonDecode(getPreference(key: PREF_USER)));
    } else {
      return null;
    }
  }

  void setOtp(String otp) {
    setPreference(
      dataType: DataType.STRING,
      key: 'otp_info',
      value: otp,
      //  jsonEncode(value.toJson()),
    );
  }

  String? getOtp() {
    if (globalSharedPreference.containsKey('otp_info')) {
      return (getPreference(key: 'otp_info'));
    } else {
      return null;
    }
  }

  // RxBool islogged = false.obs;
  // bool get isLoggedIn => getOtpVerified(otpVerified);
  bool get isLoggedIn {
    return (getTokenInfo() == null || getTokenInfo()!.isEmpty)
        //  &&   !getOtpVerified())
        ? false
        : true;
  }

  // String get sentOtp => getUserInfo() != null ? getUserInfo()!.top! : '';
  String get otp => getOtp() != null ? getOtp()! : '';

  void setOtpVerified(bool otpVerified) {
    setPreference(
      dataType: DataType.BOOLEAN,
      key: PREF_OTP_VERIFIED,
      value: otpVerified,
    );
  }

  bool getOtpVerified() {
    if (globalSharedPreference.containsKey(PREF_OTP_VERIFIED)) {
      return getPreference(key: PREF_OTP_VERIFIED);
    } else {
      return false;
    }
  }

  void setFirstLaunch(bool value) {
    setPreference(
      dataType: DataType.BOOLEAN,
      key: PREF_FIRST_LAUNCH,
      value: value,
    );
  }

  bool getFirstLaunch() {
    if (globalSharedPreference.containsKey(PREF_FIRST_LAUNCH)) {
      return getPreference(key: PREF_FIRST_LAUNCH);
    } else {
      return true;
    }
  }

  void setOrderDeliveryOptionSelected(int value) {
    setPreference(
      dataType: DataType.INT,
      key: PREF_ORDER_DELIVERY_SELECTED,
      value: value,
    );
  }

  int getOrderDeliveryOptionSelected() {
    if (globalSharedPreference.containsKey(PREF_ORDER_DELIVERY_SELECTED)) {
      return getPreference(key: PREF_ORDER_DELIVERY_SELECTED);
    } else {
      return 0;
    }
  }

  void setFirstLaunchShowDeliveryService(bool value) {
    setPreference(
      dataType: DataType.BOOLEAN,
      key: PREF_FIRST_LAUNCH_DELIVERY_SERVICE,
      value: value,
    );
  }

  bool getFirstLaunchShowDeliveryService() {
    if (globalSharedPreference
        .containsKey(PREF_FIRST_LAUNCH_DELIVERY_SERVICE)) {
      return getPreference(key: PREF_FIRST_LAUNCH_DELIVERY_SERVICE);
    } else {
      return true;
    }
  }

  void setAppLanguage(String value) {
    setPreference(
      dataType: DataType.STRING,
      key: APP_LANGUAGE,
      value: value,
    );
  }

  String getAppLanguage() {
    if (globalSharedPreference.containsKey(APP_LANGUAGE)) {
      return getPreference(key: APP_LANGUAGE);
    } else {
      return LanguageService.enCode;
    }
  }

  void setAppTheme({required bool dark}) {
    setPreference(
      dataType: DataType.BOOLEAN,
      key: APP_THEME,
      value: dark,
    );
  }

  bool getAppTheme() {
    if (globalSharedPreference.containsKey(APP_THEME)) {
      return getPreference(key: APP_THEME);
    } else {
      return false;
    }
  }

  setPreference({
    required DataType dataType,
    required String key,
    required dynamic value,
  }) async {
    switch (dataType) {
      case DataType.INT:
        await globalSharedPreference.setInt(key, value);
        break;
      case DataType.BOUBLE:
        await globalSharedPreference.setDouble(key, value);
        break;
      case DataType.STRINGLIST:
        await globalSharedPreference.setStringList(key, value);
        break;
      case DataType.STRING:
        await globalSharedPreference.setString(key, value);
        break;
      case DataType.BOOLEAN:
        await globalSharedPreference.setBool(key, value);
        break;
    }
  }

  dynamic getPreference({required String key}) {
    return globalSharedPreference.get(key);
  }
}
