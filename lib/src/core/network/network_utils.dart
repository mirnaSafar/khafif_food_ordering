import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:khafif_food_ordering_application/src/core/enums.dart';
import 'package:khafif_food_ordering_application/src/core/translation/app_translation.dart';
import 'package:khafif_food_ordering_application/src/core/utility/general_utils.dart';
import 'package:path/path.dart' as path;

class NetworkUtil {
  static String baseUrl = 'erp.khafif.com.sa';
  // '147.182.194.53:8069';
  // '192.168.1.199:8069';
  static var client = http.Client();
  static RxBool online = isOnline.obs;

  static Future<dynamic> sendRequest({
    required RequestType type,
    required String url,
    Map<String, String>? headers,
    Map<String, dynamic>? body,
    Map<String, dynamic>? params,
  }) async {
    try {
      if (!isOnline) {
        showSnackbarText(tr("key_bot_toast_offline"));
        // CustomToast.showMessage(
        //     message: tr("key_bot_toast_offline"),
        // messageType: MessageType.WARNING)
        BotToast.closeAllLoading();
        return;
      }
      //!--- Required for request ----
      //*--- Make full api url ------

      var uri = Uri.https(baseUrl, url, params);

      //To save api response
      late http.Response response;
      Map<String, dynamic> jsonResponse = {};
      switch (type) {
        case RequestType.GET:
          response = await client.get(uri, headers: headers);
          break;
        case RequestType.POST:
          response =
              await client.post(uri, body: jsonEncode(body), headers: headers);
          break;
        case RequestType.PUT:
          response =
              await client.put(uri, body: jsonEncode(body), headers: headers);
          break;
        case RequestType.DELETE:
          response = await client.delete(uri,
              body: jsonEncode(body), headers: headers);
          break;
      }
      dynamic result;
      try {
        result = jsonDecode(const Utf8Codec().decode(response.bodyBytes));
      } catch (e) {}
      jsonResponse.putIfAbsent(
          'response',
          () =>
              result ??
              {'title': const Utf8Codec().decode(response.bodyBytes)});
      jsonResponse.putIfAbsent('statusCode', () => response.statusCode);
      return jsonResponse;
    } catch (e) {
      print(e);
    }
  }

  static Future<dynamic> sendMultipartRequest({
    required RequestType requestType,
    required String url,
    Map<String, String>? headers = const {},
    Map<String, String>? fields = const {},
    Map<String, String>? files = const {},
    Map<String, dynamic>? params,
  }) async {
    try {
      // if (!isOnline) {
      //   CustomToast.showMessage(
      //       message: tr("key_bot_toast_offline"),
      //       messageType: MessageType.WARNING);
      //   BotToast.closeAllLoading();
      //   return;
      // }
      var request = http.MultipartRequest(
        requestType.name,
        Uri.https(baseUrl, url, params),
      );

      var filesKeyList = files!.keys.toList();
      var filesNameList = files.values.toList();

      for (int i = 0; i < filesKeyList.length; i++) {
        if (filesNameList[i].isNotEmpty) {
          var multipartFile = http.MultipartFile.fromPath(
            filesKeyList[i],
            filesNameList[i],
            filename: path.basename(filesNameList[i]),
            contentType: getContentType(filesNameList[i]),
          );
          request.files.add(await multipartFile);
        }
      }

      request.headers.addAll(headers!);
      request.fields.addAll(fields!);

      http.StreamedResponse response = await request.send();
      Map<String, dynamic> responseJson = {};
      dynamic value;
      List<int> responseBytes = await response.stream.toBytes();
      String responseString = utf8.decode(responseBytes);

      try {
        value = await response.stream.bytesToString();
      } catch (e) {}

      responseJson.putIfAbsent('statusCode', () => response.statusCode);
      responseJson.putIfAbsent(
          'response',
          () => value is String
              ? {'title': value}
              // () => value == "" && response.statusCode == 200
              //     ? {'title': 'Register Successful!'}
              : jsonDecode(responseString));

      return responseJson;
    } catch (error) {
      print(error.toString());
    }
  }

  static Future<dynamic> fetchDataWithGetRequestAndBody({
    required Map<String, dynamic> body,
    required String url,
    Map<String, dynamic>? params,
    Map<String, String>? headers,
  }) async {
    try {
      var uri = Uri.https(baseUrl, url, params);

      http.Request request = http.Request('GET', uri);
      request.body = jsonEncode(body);

      // Send the request using http.Client
      http.Client client = http.Client();
      http.StreamedResponse response = await client.send(request);

      Map<String, dynamic> responseJson = {};
      dynamic value;
      List<int> responseBytes = await response.stream.toBytes();
      String responseString = utf8.decode(responseBytes);

      try {
        value = await response.stream.bytesToString();
      } catch (e) {}

      responseJson.putIfAbsent('statusCode', () => response.statusCode);
      responseJson.putIfAbsent(
          'response',
          () =>
              value is String ? {'title': value} : jsonDecode(responseString));

      return responseJson;
    } catch (error) {
      print(error.toString());
    }
    client.close();
  }

//////////////////////////////////////////////////////////////////

  // static MediaType getContentType(String fileName) {
  //   // var fileExtension = fileName.split('.').last;
  //   var fileExtension = path.extension(fileName);
  //   var fileType;
  //   MediaType x;

  //   if (fileExtension == "png" || fileExtension == "jpeg") {
  //     return MediaType.parse("image/jpg");
  //   } else if (fileExtension == 'pdf') {
  //     return MediaType.parse("application/pdf");
  //   } else {
  //     return MediaType.parse("image/jpg");
  //   }
  // }

  static Map<String, MediaType> fileTypeToMediaType = {
    'jpeg': MediaType.parse('image/jpeg'),
    'png': MediaType.parse('image/png'),
    'pdf': MediaType.parse('application/pdf'),
    'doc': MediaType.parse('application/msword'),
    'docx': MediaType.parse('application/msword'),
    'xls': MediaType.parse('application/vnd.ms-excel'),
    'xlsx': MediaType.parse('application/vnd.ms-excel'),
    'unknown': MediaType.parse('application/octet-stream'),
  };

  static MediaType getContentType(String fileName) {
    var fileExtension = fileName.split('.').last;

    switch (fileExtension) {
      case 'jpg':
      case 'jpeg':
        return fileTypeToMediaType['jpeg']!;
      case 'png':
        return fileTypeToMediaType['png']!;
      case 'pdf':
        return fileTypeToMediaType['jpeg']!;
      case 'doc':
      case 'docx':
        return fileTypeToMediaType['doc']!;
      case 'xls':
      case 'xlsx':
        return fileTypeToMediaType['xls']!;
      default:
        return fileTypeToMediaType['unknown']!;
    }
  }

  // static MediaType getContentTypeTwo(String fileName) {
  //   var fileExtension = fileName.split('.').last;
  //   FileTypeTest? fileTypeTest;
  //   switch (fileTypeTest) {
  //     case FileTypeTest.JPEG:
  //       break;
  //     case FileTypeTest.JPG:
  //       break;
  //     case FileTypeTest.PNG:
  //       break;
  //     case FileTypeTest.PDF:
  //       break;
  //     case FileTypeTest.DOC:
  //       break;
  //     case FileTypeTest.DOCX:
  //       break;
  //     case FileTypeTest.XLS:
  //       break;
  //     case FileTypeTest.XLSX:
  //       break;
  //     case FileTypeTest.UNKNOWN:
  //       break;
  //   }
  // }
  // static MediaType getContentType(String fileName) {
  //   var fileExtension = fileName.split('.').last;
  //   if (fileExtension == "png" || fileExtension == "jpeg") {
  //     return MediaType.parse("image/jpg");
  //   } else if (fileExtension == 'pdf') {
  //     return MediaType.parse("application/pdf");
  //   } else {
  //     return MediaType.parse("image/jpg");
  //   }
  // }
}


// enum FileTypeTest {
//   JPEG("image/jpg"),
//   JPG("image/jpg"),
//   PNG("image/png"),
//   PDF("application/pdf"),
//   DOC("application/msword"),
//   DOCX("application/msword"),
//   XLS("application/vnd.ms-excel"),
//   XLSX("application/vnd.ms-excel"),
//   UNKNOWN("application/octet-stream");

//   const FileTypeTest(this.value);
//   final MediaType MediaType.parse("image/jpg");
// }