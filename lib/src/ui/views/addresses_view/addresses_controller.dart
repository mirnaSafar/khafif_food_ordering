import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/services/base_controller.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/address_model.dart';
import 'package:khafif_food_ordering_application/src/data/repositories/user_addresses_repository.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/custom_widgets/custom_toast.dart';

class AddressCntroller extends BaseController {
  // RxList<AddressModel> userAddresses = storage.getUserAddresses().obs;

  @override
  onInit() {
    getAllAddresses();
    super.onInit();
  }

  RxBool isDismissed = false.obs;

  RxBool get isAddressesLoading =>
      operationType.contains(OperationType.ADDRESS).obs;
  RxList<AddressModel> addresses = <AddressModel>[].obs;

  // editAddressInfo(AddressModel address, int index) {
  //   userAddresses.removeAt(index);
  //   userAddresses.insert(index, address);
  // }

  Future getAllAddresses() {
    if (isOnline) {
      return runLoadingFutuerFunction(
          type: OperationType.ADDRESS,
          function: Future(() => UserAddressesRepository().getAddress().then(
                (value) {
                  value.fold((l) {
                    CustomToast.showMessage(
                      messageType: MessageType.REJECTED,
                      message: l,
                    );
                    isDismissed.value = false;
                    // isCategoriesShimmerLoader.value = false;
                  }, (r) {
                    addresses.clear();
                    addresses.addAll(r);
                    isDismissed.value = true;
                    userAddresses.clear();
                    storage.addUserAddresses(r);
                    userAddresses.value = storage.getUserAddresses();
                    update();
                  });
                },
              )));
    }
    return Future(() => null);
  }

  deleteAddress({required int addressID, required int index}) {
    return runFullLoadingFutuerFunction(
      function:
          UserAddressesRepository().deleteAddress(addressID: addressID).then(
        (value) {
          value.fold(
            (l) => CustomToast.showMessage(
                message: l, messageType: MessageType.REJECTED),
            (r) {
              userAddresses.removeAt(index);

              CustomToast.showMessage(
                  message: 'deleted', messageType: MessageType.SUCCESS);
            },
          );
        },
      ),
    );
  }
}
