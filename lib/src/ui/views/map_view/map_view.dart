import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khafif_food_ordering_application/src/core/app/app_config/colors.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/address_model.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_appbar.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/sliding_up_pannel.dart';
import 'package:khafif_food_ordering_application/src/ui/views/addresses_view/address_bottomsheet.dart/address_bottomsheet.dart';
import 'package:khafif_food_ordering_application/src/ui/views/map_view/map_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/shops_controller.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

// ignore: must_be_immutable
class MapPage extends StatefulWidget {
  LatLng? sourceLocation = const LatLng(37.43296265331129, -122.08832357078792);
  LatLng? destination = const LatLng(34.43296265331129, -100.06600357078792);
  final String? appBarTitle;
  final bool? newAddress;
  final AddressModel? addressModel;
  Map<String, dynamic>? editAddress = {"edit": false, "index": null};
  final Widget Function(ScrollController)? panelBuilder;
  final double? openPanelHeight, closePanelHeight;
  final Widget? bottomsheet;
  final PanelController? panelController;
  MapPage(
      {super.key,
      this.sourceLocation,
      this.destination,
      this.bottomsheet,
      this.appBarTitle,
      this.newAddress = false,
      this.editAddress,
      this.addressModel,
      this.panelBuilder,
      this.openPanelHeight,
      this.closePanelHeight,
      this.panelController});

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  @override
  void initState() {
    super.initState();
    var sourceLocation = widget.sourceLocation;
    var destination = widget.destination ?? storage.userCurrentLocation;
    mapController = Get.put(MapController(
        sourceLocation: sourceLocation, destination: destination));
  }

  ShopsController shopsController = Get.put(ShopsController());

  late MapController mapController;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      builder: (MapController mapController) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: CustomAppbar(appbarTitle: widget.appBarTitle ?? tr('order_lb')),
        body: CustomSlidingUpPannel(
          openPanelHeight: widget.openPanelHeight,
          closePanelHeight: widget.closePanelHeight,
          panelBuilder: widget.panelBuilder,
          panel: widget.editAddress?['edit'] ?? false
              ? AddressBottomSheet(
                  address: userAddresses[widget.editAddress!['index']],
                  onSubmitted: (name) => mapController.onEditAddressSubmitted(
                      name, widget.editAddress!['index']),
                )
              : widget.newAddress!
                  ? AddressBottomSheet(
                      address: AddressModel(
                        latitude: mapController.selectedLocation.latitude,
                        longitude: mapController.selectedLocation.longitude,
                      ),
                      onSubmitted: (name) => mapController.addNewAddress(name))
                  : widget.bottomsheet != null
                      ? Container(
                          height: screenHeight(3),
                          width: screenWidth(1),
                          decoration: BoxDecoration(
                            color: AppColors.mainBlackColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: screenWidth(20),
                              vertical: screenWidth(30)),
                          child: widget.bottomsheet,
                        )
                      : Container(),
          backgroundBody: GoogleMap(
            polylines: {
              Polyline(
                  color: AppColors.mainBlackColor,
                  width: 5,
                  polylineId: const PolylineId("route"),
                  points: mapController.polylineCoordinates),
            },
            mapType: MapType.normal,
            initialCameraPosition: mapController.initalCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              mapController.controller.complete(controller);

              setState(() {});
            },
            markers: mapController.markers,
            onTap: (latlong) {
              mapController.selectedLocation = latlong;
              mapController.getStreetName();

              // mapController.changeStoreLoaction();
              mapController.addtoMarkers(
                  'Destination', LatLng(latlong.latitude, latlong.longitude));

              !widget.newAddress!
                  ? mapController.deliveryToAddressOptions(
                      canDeliver: mapController.checkDeliveryAbility(
                      source:
                          const LatLng(37.43296265331129, -121.00002357078792),
                      target: latlong,
                    ))
                  : null;
              // setState(() {});
            },
          ),
          panelController: widget.panelController,
        ),
        drawerEnableOpenDragGesture: false,
        // bottomSheet:
      ),
    );
  }
}
