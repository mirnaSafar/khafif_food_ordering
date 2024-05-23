import 'package:bot_toast/bot_toast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:khafif_food_ordering_application/src/core/app/app_config/app_config.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';

import 'package:location/location.dart';
import 'package:geocoding/geocoding.dart' as geo;

class LocationService {
  Location location = Location();

  Future<LocationData?> getUserCurrentLocation({bool hideLoader = true}) async {
    LocationData locationData;

    if (!await isLocationEnabeld()) {
      return null;
    }

    if (!await isPermissionGranted()) {
      return null;
    }

    if (!hideLoader) customLoader();

    locationData = await location.getLocation();
    storage.setCurrentUserLocation(
      LatLng(locationData.latitude!, locationData.longitude!),
    );
    if (hideLoader) BotToast.closeAllLoading();

    return locationData;
  }

  Future<geo.Placemark?> getAddressInfo(LocationData locationData,
      {bool showLoader = true}) async {
    if (showLoader) customLoader();
    try {
      List<geo.Placemark> placemarks = await geo.placemarkFromCoordinates(
          locationData.latitude ?? 0.0, locationData.longitude ?? 0.0);
      BotToast.closeAllLoading();

      if (placemarks.isNotEmpty) {
        // CustomToast.showMessage(message: placemarks[0].country.toString());

        return placemarks[0];
      } else {
        return null;
      }
    } catch (e) {
      BotToast.closeAllLoading();
      // CustomToast.showMessage(message: 'network error');
      // print(e);
    }
    return null;
  }

  Future<geo.Placemark?> getCurrentAddressInfo() async {
    LocationData loc = await getUserCurrentLocation(hideLoader: true) ??
        LocationData.fromMap({});
    storage.setCurrentUserLocation(
      LatLng(loc.latitude!, loc.longitude!),
    );
    await getAddressInfo(loc, showLoader: false)
        .then((value) => storage.setUserLocation(
              value!,
              LatLng(loc.latitude!, loc.longitude!),
            ));

    return storage.getUserLocation()![0];
  }

  Future<bool> isLocationEnabeld() async {
    bool serviceEnabled;
    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        if (AppConfig.isLocationRequired) {
          CustomToast.showMessage(message: 'enable the location');
        }
        return false;
      }
    }

    return serviceEnabled;
  }

  Future<bool> isPermissionGranted() async {
    PermissionStatus permissionGranted;

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        if (AppConfig.isLocationRequired) {
          CustomToast.showMessage(message: 'location is required');
        }

        return false;
      }
    }

    return permissionGranted == PermissionStatus.granted;
  }

  double calculateDistanceInKm(LatLng latLng1, LatLng latLng2) {
    return Geolocator.distanceBetween(
          latLng1.latitude,
          latLng1.longitude,
          latLng2.latitude,
          latLng2.longitude,
        ) /
        1000;
  }

  double? calculateDistanceFromCurrentLocationInKm(LatLng latLng1) {
    // if (storage.userCurrentLocation != null) {
    //   return Geolocator.distanceBetween(
    //         // 24.6612280, 46.7299990,
    //         storage.userCurrentLocation!.latitude,
    //         storage.userCurrentLocation!.longitude,
    //         latLng1.latitude,
    //         latLng1.longitude,
    //       ) /
    //       1000;
    // } else {
    getUserCurrentLocation().then((value) => calculateDistanceInKm(
        LatLng(value!.latitude!, value.longitude!), latLng1));
    return null;
    // }
    // return null;
  }
}
