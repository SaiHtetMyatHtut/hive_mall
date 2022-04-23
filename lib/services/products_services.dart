import 'package:get/get.dart';
import 'package:hive_mall/controllers/auth_controller.dart';
import 'package:hive_mall/models/product_model.dart';
import 'package:http/http.dart' as http;

class ProductsServices {
  static String baseUri = "https://assessment-api.hivestage.com";
  static Future<ProductModel> getProducts(page, size) async {
    AuthController _controller = Get.find();
    http.Response response = await http.get(
        Uri.parse(baseUri +
            "/api/products?page=" +
            page.toString() +
            "&size=" +
            size.toString()),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_controller.authKey}',
        });
    String jsonString = response.body;
    return productModelFromJson(jsonString);
  }
}
