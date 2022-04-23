import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_mall/controllers/products_controller.dart';
import 'package:hive_mall/views/cart.dart';
import 'package:hive_mall/views/Login.dart';
import 'package:hive_mall/views/item_detail.dart';
import 'package:hive_mall/views/order_created.dart';
import 'package:hive_mall/views/products.dart';

void main() {
  runApp(const HiveMallApp());
}

class HiveMallApp extends StatelessWidget {
  const HiveMallApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductsController productsController = Get.put(ProductsController());
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: GetMaterialApp(
        initialRoute: "/",
        routes: {
          '/': (context) => Login(),
          '/products': (context) => const Products(),
          '/item_detail': (context) => const ItemDetail(),
          '/cart': (context) => const Cart(),
          '/order_created': (context) => const OrderCreated(),
        },
        theme: ThemeData(
          primaryColor: const Color(0xFF6962E7),
          textTheme: GoogleFonts.poppinsTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
      ),
    );
  }
}
