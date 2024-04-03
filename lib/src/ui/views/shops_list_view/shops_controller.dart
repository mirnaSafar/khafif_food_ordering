import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/branch_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/customer_cart_model.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/branch_reository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';
import 'package:khafif_food_ordering_application/src/core/services/date_time_picker_service.dart';
import 'package:khafif_food_ordering_application/src/ui/views/map_view/map_controller.dart';
import 'package:khafif_food_ordering_application/src/ui/views/map_view/map_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/products_view/products_view.dart';
import 'package:khafif_food_ordering_application/src/ui/views/shops_list_view/widgets/shops_list_bottomshhet.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ShopsController extends BaseController {
  @override
  void onInit() {
    // getAll();
    getOpenNowBranches();
    super.onInit();
  }

  RxInt selectedBranchesDisplayOption = 0.obs;
  RxBool get isShopsLoading => operationType.contains(OperationType.SHOP).obs;
  RxList<BranchModel> shopsList = <BranchModel>[].obs;
  Rx<BranchModel> currentShop = BranchModel().obs;
  Rx<CustomerCartModel> currentCart =
      (storage.getCart() ?? CustomerCartModel()).obs;
  PanelController panelController = PanelController();

  Future getAll() {
    if (isOnline) {
      return runLoadingFutuerFunction(
          type: OperationType.SHOP,
          function: Future(() => BranchRepository().getAllBranches().then(
                (value) {
                  value.fold((l) {
                    CustomToast.showMessage(
                      messageType: MessageType.REJECTED,
                      message: l,
                    );
                    shopsList.clear();

                    // isCategoriesShimmerLoader.value = false;
                  }, (r) {
                    shopsList.clear();
                    shopsList.addAll(r);
                  });
                },
              )));
    }
    return Future(() => null);
  }

  Future getOpenNowBranches() {
    return getOpenBranches(
        dateTime: DateTime.now().toString().split('.')[0], branchId: 3);
  }

  addAllBranchesMarkerToMap() {
    MapController mapController = Get.put(MapController(
      sourceLocation: LatLng(
        shopsList[0].latitude!,
        shopsList[0].longitude!,
      ),
    ));

    for (var shop in shopsList) {
      mapController.addtoMarkers(
          shop.name!, LatLng(shop.latitude!, shop.longitude!),
          locationDesc: shop.name);
    }

    Get.to(MapPage(
      panelController: panelController,
      sourceLocation: LatLng(
        shopsList[0].latitude!,
        shopsList[0].longitude!,
      ),
      openPanelHeight: screenHeight(2),
      closePanelHeight: screenHeight(3),
      bottomsheet:
          // shopsList[current],
          ShopsListBottomSheet(shopsList),
      appBarTitle: tr('shops_lb'),
    ));
    mapController.update();
  }

  Future getOpenBranches({required String dateTime, required int branchId}) {
    if (isOnline) {
      return runLoadingFutuerFunction(
          type: OperationType.SHOP,
          function: Future(() => BranchRepository()
                  .getOpenBranches(branchId: branchId, dateTime: dateTime)
                  .then(
                (value) {
                  value.fold((l) {
                    CustomToast.showMessage(
                      messageType: MessageType.REJECTED,
                      message: l,
                    );
                    shopsList.clear();

                    // isCategoriesShimmerLoader.value = false;
                  }, (r) {
                    shopsList.clear();
                    shopsList.addAll(r);
                  });
                },
              )));
    }
    return Future(() => null);
  }

  Future getShop({required int branchID}) {
    if (isOnline) {
      return runLoadingFutuerFunction(
          type: OperationType.SHOP,
          function: Future(
              () => BranchRepository().getBranch(branchID: branchID).then(
                    (value) {
                      value.fold((l) {
                        CustomToast.showMessage(
                          messageType: MessageType.REJECTED,
                          message: l,
                        );
                        // isCategoriesShimmerLoader.value = false;
                      }, (r) {
                        currentShop.value = r;
                      });
                    },
                  )));
    }
    return Future(() => null);
  }

  setShop({required int branchID}) {
    if (isOnline) {
      return runFullLoadingFutuerFunction(
          type: OperationType.SHOP,
          function: Future(
              () => BranchRepository().setBranch(branchId: branchID).then(
                    (value) {
                      value.fold((l) {
                        CustomToast.showMessage(
                          messageType: MessageType.REJECTED,
                          message: l,
                        );
                        // isCategoriesShimmerLoader.value = false;
                      }, (r) {
                        currentCart.value = r;
                        storage.setCart(r);
                        CustomToast.showMessage(
                          messageType: MessageType.SUCCESS,
                          message: 'Successfully Selected!',
                        );
                        Future.delayed(
                          const Duration(seconds: 1),
                          () => Get.offAll(const ProductsView()),
                        );
                      });
                    },
                  )));
    }
  }
}
