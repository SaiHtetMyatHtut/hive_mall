import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_mall/controllers/auth_controller.dart';
import 'package:hive_mall/services/auth_services.dart';
import 'package:http/http.dart' as http;

class Login extends StatelessWidget {
  Login({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void loginAuthentication(context) async {
    http.Response result = await AuthServices.loginService(
        _emailController.text, _passwordController.text);
    if (result.statusCode != 200) {
      // var msg = json.decode(result.body);
      // var data = msg["message"];
      Get.snackbar(
        "!!! Error !!!",
        "Something Empty or Incorrect Data",
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      var msg = json.decode(result.body);
      var data = msg["token"];
      AuthController _controller = Get.put(AuthController());
      _controller.setAuthKey(data);
      Get.snackbar(
        "Done",
        "Successfully Logged In",
        snackPosition: SnackPosition.BOTTOM,
      );
      Navigator.popAndPushNamed(context, "/products");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                Text("Welcome!",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 25)),
                const SizedBox(height: 60),
                HiveTextField("Email", "pranton.work@gmail.com",
                    controller: _emailController, isPassword: false),
                const SizedBox(height: 50),
                HiveTextField("Password", "********",
                    controller: _passwordController, isPassword: true)
              ],
            ),
            const SizedBox(height: 80),
            HiveButton("Login", onPressed: () => loginAuthentication(context)),
          ],
        ),
      ),
    );
  }
}

class HiveButton extends StatelessWidget {
  final String label;
  final double width;
  final VoidCallback onPressed;
  const HiveButton(this.label,
      {Key? key, required this.onPressed(), this.width = double.infinity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(5),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(5),
        child: SizedBox(
          width: width,
          height: 41,
          child: Center(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class HiveTextField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final bool isPassword;
  const HiveTextField(this.label, this.hint,
      {Key? key, required this.controller, this.isPassword = false})
      : super(key: key);

  @override
  State<HiveTextField> createState() => _HiveTextFieldState();
}

class _HiveTextFieldState extends State<HiveTextField> {
  bool isVisiable = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      decoration: InputDecoration(
        hintText: widget.hint,
        label: Text(widget.label),
        labelStyle: const TextStyle(fontSize: 20),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    isVisiable = !isVisiable;
                  });
                },
                child: Icon(
                  isVisiable ? Icons.visibility : Icons.visibility_off,
                ),
              )
            : null,
      ),
      obscureText: widget.isPassword
          ? isVisiable
              ? false
              : true
          : false,
      enableSuggestions: false,
      autocorrect: false,
    );
  }
}
