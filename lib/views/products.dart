import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_mall/controllers/products_controller.dart';
import 'package:hive_mall/models/product_model.dart';

class Products extends StatefulWidget {
  const Products({Key? key}) : super(key: key);

  @override
  State<Products> createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  late ProductsController productsController;
  @override
  void initState() {
    super.initState();
    productsController = Get.find();
    productsController.fetchProducts(1, 6);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Material(
                    child: InkWell(
                      onTap: () {},
                      child: const Icon(
                        Icons.menu,
                        size: 38,
                      ),
                    ),
                  ),
                  const AddToCart(isEmpty: false),
                ],
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: (MediaQuery.of(context).size.width / 4) * 3,
                child: greetingText(context, "Sai Htet Myat Htut"),
              ),
              const SizedBox(height: 30),
              SearchBar(
                hint: "Search for fruit salad combos",
                icon: Icons.search,
                controller: TextEditingController(),
              ),
              const SizedBox(height: 30),
              const Text(
                "Recommended Combo",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Obx(
                  () => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 320,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: productsController.products.length,
                    itemBuilder: (BuildContext context, index) {
                      return ItemCard(
                        content: productsController.products[index],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget greetingText(context, name) {
    return Text.rich(
      TextSpan(
        text: "Hello ",
        children: [
          TextSpan(
            text: name,
            style: TextStyle(
                color: Theme.of(context).primaryColor.withOpacity(0.8)),
          ),
          const TextSpan(
            text: " , What fruit salad combo do you want today?",
          ),
        ],
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class ItemCard extends StatefulWidget {
  final Content content;
  const ItemCard({
    Key? key,
    required this.content,
  }) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> {
  bool curState = false;

  void addItemToCard() {
    ProductsController _productsController = Get.find();
    _productsController.addCardProducts(widget.content);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Material(
        elevation: 2,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, "/item_detail",
                arguments: widget.content);
          },
          child: Container(
            width: 165,
            height: 180,
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      flex: 6,
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Image(
                          image: NetworkImage(widget.content.image),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.content.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 10),
                            Expanded(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.content.amount.toInt().toString(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Material(
                                    borderRadius: BorderRadius.circular(50),
                                    child: InkWell(
                                      onTap: () {
                                        addItemToCard();
                                      },
                                      borderRadius: BorderRadius.circular(50),
                                      child: Container(
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Theme.of(context)
                                              .primaryColor
                                              .withOpacity(0.6),
                                          borderRadius:
                                              BorderRadius.circular(50),
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: Theme.of(context).primaryColor,
                                          size: 28,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => setState(() {
                        curState = !curState;
                      }),
                      child: SizedBox(
                        width: 50,
                        height: 50,
                        child: Center(
                          child: Icon(
                            curState ? Icons.favorite : Icons.favorite_border,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchBar extends StatelessWidget {
  final String hint;
  final IconData icon;
  final TextEditingController controller;
  const SearchBar(
      {Key? key,
      required this.hint,
      required this.icon,
      required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F9),
        borderRadius: BorderRadius.circular(5),
      ),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Theme.of(context).primaryColor,
          ),
          hintText: hint,
          hintStyle: const TextStyle(fontSize: 16),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 12),
        ),
        style: TextStyle(
          fontSize: 16,
          color: Theme.of(context).primaryColor,
        ),
        cursorColor: Theme.of(context).primaryColor,
      ),
    );
  }
}

class AddToCart extends StatelessWidget {
  final bool isEmpty;
  const AddToCart({Key? key, this.isEmpty = true}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor.withOpacity(0.5),
      child: InkWell(
        onTap: (() {
          Navigator.pushNamed(context, '/cart');
        }),
        child: SizedBox(
          width: 50,
          height: 50,
          child: Center(
            child: Stack(
              children: [
                const Icon(
                  Icons.shopping_cart_outlined,
                  color: Colors.white,
                  size: 35,
                ),
                Positioned(
                  right: 0,
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: isEmpty ? Colors.transparent : Colors.red,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
