import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_mall/constants.dart';
import 'package:hive_mall/controllers/products_controller.dart';
import 'package:hive_mall/models/product_model.dart';
import 'package:hive_mall/views/Login.dart';

class ItemDetail extends StatelessWidget {
  const ItemDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Content content = ModalRoute.of(context)!.settings.arguments as Content;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  flex: 7,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image(
                      image: NetworkImage(content.image),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        const SizedBox(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              content.name,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            CounterWidget(content),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DefaultTabController(
                  length: 2,
                  child: TabBar(
                    labelColor: Theme.of(context).primaryColor,
                    unselectedLabelColor: Colors.black,
                    indicatorColor: Theme.of(context).primaryColor,
                    labelStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                    tabs: const [
                      Tab(text: "Description"),
                      Tab(text: "Customer Review"),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            content.description,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 25),
                          const Text(
                            "Select Size",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 15),
                          BubbleChoice(itemSize),
                          const SizedBox(height: 25),
                          const Text(
                            "Select Color",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 15),
                          BubbleChoice(itemColor),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  color: Colors.white,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            text: content.amount.toString(),
                            children: const [
                              TextSpan(text: " MMK"),
                            ],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      HiveButton(
                        "Add To Cart",
                        onPressed: () {
                          ProductsController _productsController = Get.find();
                          int counterItem =
                              _productsController.cartCounter[content] == null
                                  ? 0
                                  : _productsController.cartCounter[content]
                                      as int;
                          if (counterItem != 0) {
                            if (_productsController.cartProducts
                                .containsKey(content)) {
                              int productInCounter = counterItem;
                              _productsController.cartProducts[content] =
                                  productInCounter;
                            } else {
                              _productsController.cartProducts[content] =
                                  counterItem;
                            }
                            _productsController.cartCounter[content] =
                                _productsController.cartProducts[content]
                                    as int;
                          }
                          Navigator.pop(context);
                        },
                        width: 200,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              left: 25,
              top: 30,
              child: Material(
                color: Theme.of(context).primaryColor.withOpacity(0.3),
                borderRadius: BorderRadius.circular(38),
                child: InkWell(
                  borderRadius: BorderRadius.circular(38),
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const SizedBox(
                    width: 50,
                    height: 50,
                    child: Center(
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 38,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class CounterWidget extends StatelessWidget {
  final Content content;
  CounterWidget(this.content, {Key? key}) : super(key: key);
  final ProductsController _productsController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.6),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 50,
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(5),
              child: InkWell(
                onTap: () {
                  _productsController.subCounter(content);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Flexible(
                    flex: 2,
                    child: Center(
                      child: Icon(
                        Icons.remove,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Obx(() {
            return Text(
              _productsController.cartCounter[content] == null
                  ? "0"
                  : _productsController.cartCounter[content].toString(),
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            );
          }),
          SizedBox(
            width: 50,
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  _productsController.addCounter(content);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Flexible(
                    flex: 2,
                    child: Center(
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    ),
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

class BubbleChoice extends StatefulWidget {
  final List<String> data;
  const BubbleChoice(this.data, {Key? key}) : super(key: key);

  @override
  State<BubbleChoice> createState() => _BubbleChoiceState();
}

class _BubbleChoiceState extends State<BubbleChoice> {
  int curIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.data
          .asMap()
          .entries
          .map(
            (e) => Material(
              borderRadius: BorderRadius.circular(38),
              child: InkWell(
                onTap: () {
                  setState(() {
                    curIndex = e.key;
                  });
                },
                borderRadius: BorderRadius.circular(38),
                child: Container(
                  width: 45,
                  height: 45,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(38),
                    color: curIndex == e.key
                        ? Theme.of(context).primaryColor.withOpacity(0.7)
                        : Colors.grey,
                  ),
                  child: Center(
                    child: Text(
                      e.value,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}
