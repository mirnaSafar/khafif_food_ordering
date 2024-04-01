import 'package:dartz/dartz.dart';
import 'package:get/get.dart';
import 'package:khafif_food_ordering_application/src/core/app/my_app.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/network/endpoints/cart_endpoints.dart';
import 'package:khafif_food_ordering_application/src/core/network/endpoints/products_endpoint.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/customer_cart_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/product_variants_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/common_response.dart';
import 'package:khafif_food_ordering_application/src/ui/shared/dialogs/browsing_alert_dialog.dart';

class CartRepository {
  Future<Either<String, CustomerCartModel>> cart() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: CartEnpoints.getCart,
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.GET),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);
        CustomerCartModel cartModel;
        if (commonResponse.getStatus) {
          cartModel = CustomerCartModel.fromJson(commonResponse.data!);
          return Right(cartModel);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> addToCart(
      {required int productID, required int productQty}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.POST,
        url: CartEnpoints.addToCart,
        body: {
          "order_lines": {
            "product_id": productID,
            "product_uom_qty": productQty
          }
        },
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.POST),
      ).then((response) {
        CommonResponse<dynamic> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return const Right(true);
        } else {
          if (commonResponse.message == 'customer not found') {
            showBrowsingDialogAlert(Get.context!);
          }
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> updateOrder(
      {required int productID, required int productQty}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.PUT,
        url: CartEnpoints.updateOrder,
        body: {
          "order_lines": {
            "product_id": productID,
            "product_uom_qty": productQty
          }
        },
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.PUT),
      ).then((response) {
        CommonResponse<dynamic> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return const Right(true);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> deleteOrder({required int productID}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.DELETE,
        url: CartEnpoints.deleteOrder + productID.toString(),
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.DELETE),
      ).then((response) {
        CommonResponse<dynamic> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return const Right(true);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, ProductVariantsModel>> getProductVariants(
      {required List<int> variantIds}) async {
    try {
      // List<String> stringVariantIds =
      //     variantIds.map((intItem) => intItem.toString()).toList();
      return NetworkUtil.fetchDataWithGetRequestAndBody(
        url: ProductsEndPoints.getProductVariants,
        body: {
          "variant_value_ids": variantIds,
        },
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.GET),
      ).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(ProductVariantsModel.fromJson(commonResponse.data!));
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
