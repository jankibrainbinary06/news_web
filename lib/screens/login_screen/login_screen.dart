// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_web_app/common/common_textfield.dart';
import 'package:news_web_app/screens/login_screen/login_controller.dart';
import 'package:news_web_app/screens/news_screen/widgets/edit_news_popup.dart';
import 'package:responsive_builder/responsive_builder.dart';

import '../../common/text_styles.dart';
import '../../utils/assets_res.dart';
import '../../utils/color_res.dart';
import '../../utils/string_res.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    LoginController loginController = Get.put(LoginController());
    CollectionReference Users = FirebaseFirestore.instance.collection('admin');
    double width = 0;
    return FutureBuilder<QuerySnapshot>(
      future: Users.get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return ResponsiveBuilder(
            builder: (context, sizingInformation) {
              if (sizingInformation.isDesktop) {
                width = 700;
              } else if (sizingInformation.isTablet) {
                width = 450;
              } else if (sizingInformation.isMobile) {
                width = 300;
              }
              return Scaffold(
                body: GetBuilder<LoginController>(
                  id: 'admin',
                  builder: (controller) {
                    var documents = snapshot.data!.docs;
                    List<Map<String, dynamic>> items = [];
                    for (var document in documents) {
                      var data = document.data() as Map<String, dynamic>;

                      controller.email = data['email'];
                      controller.password = data['password'];
                    }
                    return Container(
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                        color: Colors.black,
                        image: DecorationImage(
                          image: AssetImage("assets/images/Login_bg_image.jpg"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  Strings.hello,
                                  style: poppinsBold.copyWith(
                                      color: Colors.black, fontSize: 40),
                                ),
                                Text(
                                  Strings.again,
                                  style: poppinsBold.copyWith(
                                      color: ColorRes.appColor, fontSize: 40),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 1,
                            ),
                            Text(
                              Strings.welcomeBack,
                              style: mediumSf.copyWith(
                                  color: Colors.black.withOpacity(
                                    0.7,
                                  ),
                                  fontSize: 30),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(
                                      5,
                                    ),
                                  ),
                                  border: Border.all(
                                      color: ColorRes.appColor, width: 1),
                                  color: Colors.white),
                              padding: EdgeInsets.symmetric(
                                  vertical: sizingInformation.isDesktop
                                      ? Get.height * 0.07
                                      : Get.height * 0.07,
                                  horizontal: width * 0.07),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: width * 0.75,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black.withOpacity(0.8),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextField(
                                      keyboardType: TextInputType.emailAddress,
                                      style: TextStyle(
                                        fontFamily: "sfPro",
                                        color: Colors.black.withOpacity(0.9),
                                      ),
                                      controller: controller.emailController,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsetsDirectional.only(
                                                top: 20),
                                        hintText: "Enter email ID",
                                        hintStyle: const TextStyle(
                                          fontFamily: "sfPro",
                                          color: Color(0xffB3B3B3),
                                        ),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Image.asset(
                                            AssetRes.email,
                                            color: Colors.black,
                                            height: 30,
                                            width: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  controller.emailError == ''
                                      ? const SizedBox()
                                      : SizedBox(height: Get.height * 0.01),
                                  (controller.emailError == '')
                                      ? const SizedBox()
                                      : Text(
                                          controller.emailError,
                                          style: errorTextStyle,
                                        ),
                                  const SizedBox(
                                    height: 25,
                                  ),
                                  Container(
                                    width: width * 0.75,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black.withOpacity(0.8),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: TextField(
                                      obscureText: dashboardController.obSecure,
                                      style: TextStyle(
                                        fontFamily: "sfPro",
                                        color: Colors.black.withOpacity(0.9),
                                      ),
                                      controller: controller.passwordController,
                                      decoration: InputDecoration(
                                        suffixIcon: dashboardController.obSecure
                                            ? InkWell(
                                                onTap: () {
                                                  dashboardController.obSecure =
                                                      false;
                                                  controller.update(['admin']);
                                                },
                                                child: Icon(
                                                    Icons.visibility_outlined),
                                              )
                                            : InkWell(
                                                onTap: () {
                                                  dashboardController.obSecure =
                                                      true;
                                                  controller.update(['admin']);
                                                },
                                                child: Icon(Icons
                                                    .visibility_off_outlined)),
                                        border: InputBorder.none,
                                        contentPadding:
                                            const EdgeInsetsDirectional.only(
                                                top: 20),
                                        hintText: "Enter password",
                                        hintStyle: (const TextStyle(
                                          fontFamily: "sfPro",
                                          color: Color(0xffB3B3B3),
                                        )),
                                        prefixIcon: Padding(
                                          padding: const EdgeInsets.all(15),
                                          child: Image.asset(
                                            AssetRes.lock,
                                            color: Colors.black,
                                            height: 30,
                                            width: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  controller.passError == ''
                                      ? const SizedBox()
                                      : SizedBox(height: Get.height * 0.01),
                                  (controller.passError == '')
                                      ? const SizedBox()
                                      : Text(
                                          controller.passError,
                                          style: errorTextStyle,
                                        ),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.onTapLogin(context);
                                    },
                                    child: Container(
                                      height: 55,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        color: ColorRes.appColor,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        "Sign In",
                                        style: TextStyle(
                                            fontSize: 23,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "sfPro"),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
