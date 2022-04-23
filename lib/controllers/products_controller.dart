import 'package:get/get.dart';
import 'package:hive_mall/models/product_model.dart';
import 'package:hive_mall/services/products_services.dart';

class ProductsController extends GetxController {
  RxList<Content> products = <Content>[].obs;

  void fetchProducts(page, size) async {
    ProductModel model = await ProductsServices.getProducts(page, size);
    products.clear();
    products.addAll(model.content);
  }

  // Temp Counter
  RxMap<Content, int> cartCounter = <Content, int>{}.obs;

  void addCounter(Content content) {
    if (!cartCounter.containsKey(content)) {
      cartCounter[content] = 1;
    } else {
      int counter = cartCounter[content] as int;
      cartCounter[content] = counter + 1;
    }
  }

  void subCounter(Content content) {
    if (cartCounter.containsKey(content)) {
      int counter = cartCounter[content] as int;
      cartCounter[content] = counter - 1;
    }
  }

  // Product In Cart
  RxMap<Content, int> cartProducts = <Content, int>{}.obs;

  void addCardProducts(Content content) {
    if (!cartProducts.containsKey(content)) {
      cartProducts[content] = 1;
      cartCounter[content] = 1;
    } else {
      int counter = cartProducts[content] as int;
      cartProducts[content] = counter + 1;
      cartCounter[content] = counter + 1;
    }
  }
}
