import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';

class ConnectivityService {
  StreamController<ConnectivityStatus> connectivityStatusController =
      StreamController<ConnectivityStatus>.broadcast();

  ConnectivityService() {
    final Connectivity connectivity = Connectivity();

    connectivity.onConnectivityChanged.listen((event) {
      connectivityStatusController.add(getStatus(event));
    });
  }

  ConnectivityStatus getStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.none:
        return ConnectivityStatus.OFFLINE;
      default:
        return ConnectivityStatus.ONLINE;
    }
  }
}
