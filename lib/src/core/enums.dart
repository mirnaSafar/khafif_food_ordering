enum AppState { TERMINATED, BACKGROUND, FOREGROUND }

enum ConnectivityStatus {
  ONLINE,
  OFFLINE;
}

enum DataType {
  INT,
  BOUBLE,
  STRING,
  STRINGLIST,
  BOOLEAN,
}

enum MessageType {
  REJECTED,
  SUCCESS,
  INFO,
  WARNING,
}

enum NotificationType {
  SUBSCRIPTION,
  CHANGECOLOR,
}

enum OperationType {
  CATEGORY,
  PRODUCT,
  SEARCHPRODUCT,
  FAVORITE,
  PRODUCTNEXTPAGE,
  BANNER,
  CART,
  MODIFYUSERINFORMATION,
  SHOP,
  SETSHOP,
  ADDRESS,
  order,
  NONE,
}

enum RequestStatus {
  LOADING,
  SUCCESS,
  ERROR,
  DEFAULT,
}

enum RequestType {
  GET,
  POST,
  PUT,
  DELETE,
}

enum UrlType {
  WEB,
  EMAIL,
  PHONE,
  SMS,
}

enum FileTypeEnum {
  GALLERY,
  CAMERA,
  FILE;
}
