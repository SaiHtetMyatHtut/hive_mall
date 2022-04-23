import 'package:flutter/material.dart';
import 'package:hive_mall/views/Login.dart';

class OrderCreated extends StatelessWidget {
  const OrderCreated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "YOUR ORDER CREATED",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(
              width: 150,
              child: Image(
                image: AssetImage("assets/images/congratulation.png"),
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Thanks for ordering. ",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 5),
            const Text(
              "Rating for your order.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  child: const Center(
                    child: Icon(
                      Icons.star_border,
                      size: 45,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            HiveButton(
              "Submit",
              onPressed: () {
                // Navigator.pushNamed(context, "/products");
                Navigator.popAndPushNamed(context, "/products");
              },
              width: 200,
            )
          ],
        ),
      ),
    );
  }
}
