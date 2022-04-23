import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_mall/controllers/products_controller.dart';
import 'package:hive_mall/models/product_model.dart';
import 'package:hive_mall/views/Login.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final ProductsController _productsController = Get.find();

  int totalAmount = 0;
  @override
  void initState() {
    super.initState();
    _productsController.cartProducts.forEach((key, value) {
      var amount = key.amount * value;
      totalAmount += amount.round();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Cart",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Colors.white,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Deliver to",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 20),
              const AddressCard(),
              const SizedBox(height: 20),
              const Text(
                "Your Order",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 5),
              const Text.rich(
                TextSpan(
                    text: "OrderID - #",
                    children: [
                      TextSpan(text: "1234"),
                    ],
                    style: TextStyle(fontSize: 14)),
              ),
              const SizedBox(height: 5),
              const Text.rich(
                TextSpan(
                  text: "Order Date - ",
                  children: [
                    TextSpan(text: "15 Feb 2022"),
                  ],
                  style: TextStyle(fontSize: 14),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: _productsController.cartProducts.entries
                            .map((e) => ItemView(e.key, e.value))
                            .toList(),
                      ),
                      const SizedBox(height: 20),
                      const Divider(
                        color: Colors.grey,
                        thickness: 2,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Total + Tax (5%)",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          Text.rich(
                            TextSpan(
                              text:
                                  (totalAmount + totalAmount * 0.05).toString(),
                              children: const [
                                TextSpan(text: " MMK"),
                              ],
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: SizedBox(
                  height: 80,
                  child: Align(
                    alignment: Alignment.center,
                    child: HiveButton("Check Out", onPressed: () {
                      ProductsController _productsController = Get.find();
                      _productsController.cartCounter.clear();
                      _productsController.cartProducts.clear();
                      Navigator.popAndPushNamed(context, "/order_created");
                    }),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  const AddressCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        height: 85,
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: const [
                  Text(
                    "Home",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text("No-17, Mayynigone, Yangon"),
                ],
              ),
            ),
            const SizedBox(
              width: 50,
              child: Text(
                "Edit",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ItemView extends StatelessWidget {
  final Content itemInCartList;
  final int itemCountInCartList;
  const ItemView(this.itemInCartList, this.itemCountInCartList, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      width: double.infinity,
      height: 80,
      child: Row(
        children: [
          SizedBox(
            width: 64,
            height: 64,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Image(
                image: NetworkImage(itemInCartList.image),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text.rich(
                    TextSpan(
                      text: "Product Code : ",
                      children: [
                        TextSpan(text: itemInCartList.id.toString()),
                      ],
                      style: const TextStyle(
                        fontSize: 10,
                      ),
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      text: itemCountInCartList.toString(),
                      children: [
                        const TextSpan(text: " x "),
                        TextSpan(text: itemInCartList.name)
                      ],
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            width: 72,
            height: 64,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  (itemInCartList.amount * itemCountInCartList).toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
