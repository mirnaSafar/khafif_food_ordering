import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/app_config.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/fonts.dart';
import 'package:khafif_food_ordering_application/src/core/app/my_app.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/extensions/navigator_extension.dart';
import 'package:khafif_food_ordering_application/src/core/services/location_service.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/address_model.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/user_addresses_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/browsing_alert_dialog.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_widgets/delivery_checker_dialog.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/shops_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/shops_list.dart';
import 'package:location/location.dart';
import 'package:label_marker/label_marker.dart';

class MapController extends GetxController {
  LatLng? sourceLocation;
  LatLng? destination = const LatLng(37.43296265331129, -100.06600357078792);
  MapController({
    this.sourceLocation,
    this.destination,
  });
  ShopsController shopsController = Get.put(ShopsController());
  RxSet<Marker> markers = <Marker>{}.obs;
  late CameraPosition initalCameraPosition;

  BitmapDescriptor? customIcon;

  late LatLng selectedLocation;
  RxString selectedLocationAddress = ''.obs;
  final Completer<GoogleMapController> controller =
      Completer<GoogleMapController>();

  RxList<LatLng> polylineCoordinates = <LatLng>[].obs;
  late Rx<LocationData> currentLocation;
  @override
  onInit() {
    destination ??= storage.userCurrentLocation;
    initalCameraPosition =
        CameraPosition(target: sourceLocation ?? destination!, zoom: 14.5);
    // getPolyPoints();

    // loadcustomIcon();

    selectedLocation = destination ??
        storage.userCurrentLocation ??
        const LatLng(37.43296265331129, -100.06600357078792);

    // changeStoreLoaction();
    // getStreetName();
    // getCurrentLocation();
    // for (var shop in shopsController.shopsList) {
    //   addtoMarkers(shop.name!, LatLng(shop.latitude!, shop.longitude!),
    //       locationDesc: shop.name);
    // }
    sourceLocation != null ? addtoMarkers('Source', sourceLocation!) : null;

    addtoMarkers('Destination', destination!);

    super.onInit();
  }

  void addNewAddress(String name) {
    UserAddressesRepository()
        .addAddress(
      address: AddressModel(
        name: name,
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude,
        street: streetName.value,
        zip: countryCode.value,
        city: city.value,
      ),
    )
        .then((value) {
      value.fold(
        (l) => CustomToast.showMessage(
            message: l, messageType: MessageType.WARNING),
        (r) {
          userAddresses.add(
            AddressModel(
              id: r.id,
              name: name,
              latitude: selectedLocation.latitude,
              longitude: selectedLocation.longitude,
              street: streetName.value,
              zip: countryCode.value,
              city: city.value,
            ),
          );
          storage.addUserAddresses(userAddresses);
          update();
          // CustomToast.showMessage(
          //     message: 'address added', messageType: MessageType.SUCCESS);
        },
      );
    });
  }

  editAddressInfo(AddressModel address, int index) {
    userAddresses.removeAt(index);
    userAddresses.insert(index, address);
    storage.addUserAddresses(userAddresses);
  }

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult? result;
    try {
      result = await polylinePoints.getRouteBetweenCoordinates(
        AppConfig.google_api_key,
        PointLatLng(sourceLocation!.latitude, sourceLocation!.longitude),
        PointLatLng(destination!.latitude, destination!.longitude),
      );
      if (result.points.isNotEmpty) {
        for (PointLatLng point in result.points) {
          polylineCoordinates.add(
            LatLng(point.latitude, point.longitude),
          );
          Get.appUpdate();
        }
      }
    } catch (e) {
      print(e);
    }
  }

  addtoMarkers(String markerId, LatLng position, {String? locationDesc}) {
    !markers.contains(Marker(markerId: MarkerId(markerId)))
        ? locationDesc != null
            ? markers
                .addLabelMarker(LabelMarker(
                icon: BitmapDescriptor.defaultMarker,
                label: locationDesc,
                markerId: MarkerId(markerId),
                position: position,
                textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    // height: screenWidth(100),
                    fontSize: 60),
                backgroundColor: AppColors.canceledRedColor,
              ))
                .then(
                (value) {
                  update();
                },
              )
            : markers.add(Marker(
                icon: BitmapDescriptor.defaultMarker,
                draggable: true,
                infoWindow: InfoWindow(title: locationDesc ?? ''),
                markerId: MarkerId(markerId),
                position: position))
        : null;
    update();
  }

  Future<void> loadcustomIcon() async {
    customIcon = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(screenHeight(30), screenHeight(30))),
        'assets/images/map-marker.png',
        mipmaps: false);
    Get.appUpdate();
  }

  getCurrentLocation() async {
    await locationService.getUserCurrentLocation().then((location) {
      initalCameraPosition = CameraPosition(
        target: LatLng(location!.latitude!, location.longitude!),
        zoom: 7.4746,
      );
      storage.setCurrentUserLocation(
        LatLng(location.latitude!, location.longitude!),
      );
      destination = LatLng(location.latitude!, location.longitude!);
      addtoMarkers(
        'Destination',
        LatLng(location.latitude!, location.longitude!),
      );
      currentLocation.value = location;
      changeCameraPosition();
    });
  }

  void changeStoreLoaction() {
    LocationService()
        .getAddressInfo(LocationData.fromMap({
          'latitude': selectedLocation.latitude,
          'longitude': selectedLocation.longitude,
        }))
        .then(
          (value) => selectedLocationAddress.value =
              '${value?.administrativeArea ?? ''}-${value?.street ?? ''}',
        );

    update();
  }

  Future<void> changeCameraPosition({LatLng? newLocation}) async {
    Location location = Location();
    GoogleMapController googleMapController = await controller.future;

    location.onLocationChanged.listen((newLoc) {
      sourceLocation = LatLng(newLoc.latitude!, newLoc.longitude!);

      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 14.5,
            target: newLocation ?? sourceLocation!,
          ),
        ),
      );
      update();
    });
  }

  deliveryToAddressOptions({required bool canDeliver}) async {
    if (canDeliver) {
      showDeliveryCheckerDialog(onPressed: () {
        if (!(storage.isLoggedIn)) {
          showBrowsingDialogAlert(Get.context!);
        } else {
          Get.offAll(const ProductsView());
        }
      });
    } else {
      showDeliveryCheckerDialog(
          btnText: tr('display_shops_lb'),
          subtitle: tr('no_ability_to_deliver_lb'),
          onPressed: () {
            globalContext.pop();
            Get.back();

            Get.off(const ShopsListView());
          });
    }
  }

  bool checkDeliveryAbility({required LatLng source, required LatLng target}) {
    double differ = source.longitude - target.longitude;

    return differ > -3.0;
  }

  RxString streetName = ''.obs;
  RxString countryCode = ''.obs;
  RxString city = ''.obs;
  void getStreetName() async {
    await locationService
        .getAddressInfo(
            showLoader: true,
            LocationData.fromMap({
              'latitude': selectedLocation.latitude,
              'longitude': selectedLocation.longitude
            }))
        .then((value) {
      streetName.value = value?.street ?? 'No Street name';
      countryCode.value = value?.postalCode ?? 'No postal code';
      city.value = value?.country ?? 'No city';
    });

    update();
  }

  onEditAddressSubmitted(String name, int index) => editAddressInfo(
      AddressModel(
        name: name,
        latitude: selectedLocation.latitude,
        longitude: selectedLocation.longitude,
        street: streetName.value,
        zip: countryCode.value,
        city: city.value,
      ),
      index);
}
