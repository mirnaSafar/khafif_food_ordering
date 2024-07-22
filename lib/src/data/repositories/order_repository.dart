import 'package:dartz/dartz.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/network/endpoints/order_endpoints.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_config.dart';
import 'package:khafif_food_ordering_application/src/core/network/network_utils.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/customer_cart_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/order_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/apis/shortest_path_model.dart';
import 'package:khafif_food_ordering_application/src/data/models/common_response.dart';

class OrdersRepository {
  Future<Either<String, List<OrderModel>>> getAll() async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: OrderEndPoints.getMyOrders,
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.GET),
      ).then((response) {
        CommonResponse<List<dynamic>> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          List<OrderModel> resultList = [];
          for (var element in commonResponse.data!) {
            resultList.add(
              OrderModel.fromJson(element),
            );
          }
          return Right(resultList);
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, CustomerCartModel>> getOrder({required int id}) async {
    try {
      return NetworkUtil.sendRequest(
        type: RequestType.GET,
        url: '${OrderEndPoints.getMyOrders}/$id',
        headers:
            NetworkConfig.getHeaders(needAuth: true, type: RequestType.GET),
      ).then((response) {
        CommonResponse<dynamic> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(
            CustomerCartModel.fromJson(commonResponse.data!),
          );
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, CustomerCartModel>> closeOrder({
    required int paymentMethod,
    required int shippingMethod,
    required String amount,
    String? transactionId,
  }) async {
    try {
      return NetworkUtil.sendRequest(
          type: RequestType.POST,
          url: OrderEndPoints.closeOrder,
          headers:
              NetworkConfig.getHeaders(needAuth: true, type: RequestType.POST),
          body: {
            "transactionId": transactionId ?? "3HDD3888DDNN333",
            "amount": amount,
            "paymentMethod": paymentMethod,
            "shippingMethod": shippingMethod.toString()
          }).then((response) {
        CommonResponse<dynamic> commonResponse =
            CommonResponse.fromJson(response);

        if (commonResponse.getStatus) {
          return Right(
            CustomerCartModel.fromJson(commonResponse.data!),
          );
        } else {
          return Left(commonResponse.message ?? '');
        }
      });
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<String, bool>> orderDelivery({
    required double latitude,
    required double longitude,
  }) async {
    try {
      return NetworkUtil.sendRequest(
          type: RequestType.POST,
          url: OrderEndPoints.orderDelivery,
          headers:
              NetworkConfig.getHeaders(needAuth: true, type: RequestType.POST),
          body: {
            "longitude": longitude.toString(),
            "latitude": latitude.toString()
          }).then((response) {
        CommonResponse<Map<String, dynamic>> commonResponse =
            CommonResponse.fromJson(response);
        ShortestPathModel result;
        if (commonResponse.getStatus) {
          result = ShortestPathModel.fromJson(commonResponse.data!);
          return Right(commonResponse.getStatus);
        } else {
          return Left(commonResponse.message ?? '');
        }
        // return Right(commonResponse.getStatus);
      });
    } catch (e) {
      return Left(e.toString());
    }
  }
}
