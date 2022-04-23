import 'package:get/get.dart';

class AuthController extends GetxController {
  RxString authKey = "".obs;
  void setAuthKey(String key) {
    authKey.value = key;
  }
}
