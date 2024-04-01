import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';

class NetworkConfig {
  static String BASE_API = '/ecommerce_api/';

  static String getFullApiRoute(String apiRoute) {
    return BASE_API + apiRoute;
  }

  static Map<String, String> getHeaders(
      {bool? needAuth = true,
      required RequestType type,
      Map<String, String>? extraHeaders}) {
    return {
      if (needAuth!)
        "Authorization":
            "Bearer ${storage.getTokenInfo() ?? 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwYXJ0bmVyX2lkIjo1OSwiZW1haWwiOiJhYWFhQGFhYWEiLCJwaG9uZSI6IjA1MDIwMDg2MzQiLCJ0b2tlbl90aW1lX2V4cCI6IjIwMjQtMDItMTAgMTk6NTU6MzAuODE5NDQ2In0.MjKiGH3TghYxGjf-0cq8nHD84SUfAfuXUnL_aMNQgH4'}",
      if (type != RequestType.GET) "Content-Type": "application/json",
      ...extraHeaders ?? {}
    };
  }

  Map<String, String> extraHeaders = {'language': 'ar'};

  // static Map<String, String> getHeaders(
  //     {bool? needAuth = true,
  //     RequestType? type = RequestType.POST,
  //     Map<String, String>? extraHeaders = const {}}) {
  //   return {
  //     if (needAuth!)
  //       "Authorization":
  //           "Bearer ${storage.getTokenInfo()?.accessToken ?? ''}",
  //     if (type == RequestType.POST) "Content-Type": "application/json",
  //     ...extraHeaders!
  //   };
  // }
}
