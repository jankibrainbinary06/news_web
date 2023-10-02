import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_web_app/Services/Shared_pref_services/pref_service.dart';
import 'package:news_web_app/screens/dashboard_screen/dashboard_screen.dart';
import 'package:news_web_app/utils/string_res.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String emailError = "";
  String passError = "";

  bool validation() {
    emailValidation();
    passValidation();
    update(["admin"]);
    if (emailError == '' && passError == '') {
      return true;
    } else {
      return false;
    }
  }

  passValidation() {
    if (passwordController.text.trim() == "") {
      passError = Strings.passEror;
      update(["admin"]);
    } else {
      passError = "";
      update(["admin"]);
    }
  }

  emailValidation() {
    if (emailController.text.trim() == "") {
      emailError = Strings.emailError;
      update(['admin']);
    } else {
      if (RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(emailController.text)) {
        emailError = '';
        update(['admin']);
      } else {
        emailError = Strings.emailError;
        update(['admin']);
      }
    }
  }

  var email;
  var password;

  onTapLogin(BuildContext context) async {
    if (validation()) {
      print(email);
      if (email == emailController.text &&
          password == passwordController.text) {
        PrefService.setValue('isLogged', true);
        Get.to(const DashBoardScreen());

        emailController.clear();
        passwordController.clear();
      } else {
        if (email != emailController.text) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("invalid email")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("invalid password")));
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter correct credentials!!")));
    }
    update(["admin"]);
  }
}
