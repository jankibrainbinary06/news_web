import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_web_app/common/text_styles.dart';
import 'package:news_web_app/screens/category_screen/category_screen.dart';
import 'package:news_web_app/screens/dashboard_screen/dashboard_controller.dart';
import 'package:news_web_app/screens/login_screen/login_screen.dart';
import 'package:news_web_app/screens/news_screen/news_screen.dart';
import 'package:news_web_app/utils/assets_res.dart';
import 'package:news_web_app/utils/color_res.dart';
import 'package:news_web_app/utils/string_res.dart';
import 'package:responsive_builder/responsive_builder.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = Get.put(DashboardController());
    double width = 0;
    double height = 0;
    double textHeight = 0;
    double border = 0;
    bool isMobile = false;

    return GetBuilder<DashboardController>(
      id: 'dash',
      builder: (controller) {
        return Scaffold(
          key: dashboardController.scaffoldKey,
          drawer: Drawer(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              color: ColorRes.appColor.withOpacity(0.2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      dashboardController.isNews = false;
                      dashboardController.isLogout = false;
                      dashboardController.isCategory = true;
                      dashboardController.isNewsDetail = false;
                      dashboardController.update(['dash']);
                    },
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            AssetRes.category,
                            height: 20,
                            width: 20,
                            color: dashboardController.isCategory
                                ? ColorRes.appColor
                                : Colors.black.withOpacity(0.8),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            Strings.category,
                            style: TextStyle(
                                fontSize: 15,
                                color: dashboardController.isCategory
                                    ? ColorRes.appColor
                                    : Colors.black.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Divider(
                      height: 0.5,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      dashboardController.isCategory = false;
                      dashboardController.isLogout = false;
                      dashboardController.isNews = true;
                      dashboardController.update(['dash']);
                    },
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Image.asset(
                            AssetRes.news,
                            height: 20,
                            width: 20,
                            color: dashboardController.isNews
                                ? ColorRes.appColor
                                : Colors.black.withOpacity(0.8),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "News",
                            style: TextStyle(
                                fontSize: 15,
                                color: dashboardController.isNews
                                    ? ColorRes.appColor
                                    : Colors.black.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Divider(
                      height: 0.5,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                            child: Dialog(
                              backgroundColor: Colors.transparent,
                              child: Container(
                                height: height * 0.5,
                                width: width * 2,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: ColorRes.appColor,
                                    width: 1,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                ),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Center(
                                          child: Text(
                                            "Logout",
                                            style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: 'poppins-bold',
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.53,
                                        ),
                                        GestureDetector(
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.black,
                                            size: 20,
                                          ),
                                          onTap: () {
                                            Get.back();
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.01,
                                    ),
                                    Container(
                                      color: ColorRes.appColor,
                                      width: width * 0.45,
                                      height: 1,
                                    ),
                                    SizedBox(
                                      height: height * 0.04,
                                    ),
                                    Image.asset(
                                      AssetRes.logout,
                                      height: height * 0.09,
                                      width: width * 0.6,
                                      color: ColorRes.appColor,
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                    Text(
                                      'Are you sure you want\nto Log Out?',
                                      style: TextStyle(
                                        height: 1.5,
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.w700,
                                        fontSize: textHeight * 0.04,
                                        fontFamily: "sfPro",
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: height * 0.03,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            dashboardController.islogout =
                                                false;

                                            Get.back();

                                            dashboardController
                                                .update(['dash']);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: dashboardController
                                                              .islogout ==
                                                          true
                                                      ? Colors.black
                                                      : Colors.transparent),
                                              color: dashboardController
                                                          .islogout ==
                                                      true
                                                  ? Colors.white
                                                  : ColorRes.appColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                3,
                                              ),
                                            ),
                                            width: width * 0.7,
                                            height: height * 0.07,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "No",
                                              style: TextStyle(
                                                  fontSize: height * 0.028,
                                                  fontWeight: FontWeight.w600,
                                                  color: dashboardController
                                                              .islogout ==
                                                          true
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: width * 0.05),
                                        GestureDetector(
                                          onTap: () {
                                            dashboardController.islogout = true;

                                            Get.back();
                                            Get.to(const LoginScreen());
                                            dashboardController
                                                .update(['dash']);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: dashboardController
                                                              .islogout ==
                                                          false
                                                      ? Colors.black
                                                      : Colors.transparent),
                                              color: dashboardController
                                                          .islogout ==
                                                      false
                                                  ? Colors.white
                                                  : ColorRes.appColor,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                3,
                                              ),
                                            ),
                                            width: width * 0.7,
                                            height: height * 0.07,
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Yes",
                                              style: TextStyle(
                                                  fontSize: height * 0.028,
                                                  fontWeight: FontWeight.w600,
                                                  color: dashboardController
                                                              .islogout ==
                                                          false
                                                      ? Colors.black
                                                      : Colors.white),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: height * 0.02,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                      dashboardController.isNewsDetail = false;
                      dashboardController.update(['dash']);
                    },
                    child: SizedBox(
                      height: 70,
                      child: Row(
                        children: [
                          Image.asset(
                            AssetRes.logout,
                            height: 20,
                            width: 20,
                            color: Colors.black.withOpacity(0.8),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Log out",
                            style: TextStyle(
                                fontSize: 15,
                                color: Colors.black.withOpacity(0.8)),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: ResponsiveBuilder(
            builder: (context, sizingInformation) {
              if (sizingInformation.isDesktop) {
                isMobile = false;
                width = 250;
                height = 600;
                textHeight = 640;
                border = 1;
              } else if (sizingInformation.isTablet) {
                isMobile = false;
                width = 200;
                height = 690;
                textHeight = 600;
                border = 1;
              } else if (sizingInformation.isMobile) {
                isMobile = true;
                width = 150;
                height = 600;
                textHeight = 550;
                border = 1;
              }
              return Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.black,
                  image: DecorationImage(
                      image: AssetImage(AssetRes.dashboardbg),
                      fit: BoxFit.fill),
                ),
                child: WillPopScope(
                  onWillPop: () async {
                    if (dashboardController.isTapCategory == true) {
                      dashboardController.isTapCategory = false;
                      dashboardController.update(['category']);
                      return false;
                    } else {
                      return true;
                    }
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: Get.height * 0.035),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: Get.height * 0.09,
                            ),
                            Visibility(
                              visible: Get.width > 818,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.25,
                                  ),
                                  dashboardController.isTapCategory
                                      ? InkWell(
                                          onTap: () {
                                            dashboardController.isTapCategory =
                                                false;
                                            dashboardController
                                                .update(['dash']);
                                            dashboardController
                                                .update(['category']);
                                          },
                                          child: Icon(
                                            Icons.arrow_back_sharp,
                                            size: 30,
                                            color: Colors.black.withOpacity(
                                              0.8,
                                            ),
                                          ),
                                        )
                                      : const SizedBox(
                                          height: 30,
                                        ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            Visibility(
                              visible: Get.width > 818,
                              child: Container(
                                margin: EdgeInsets.only(left: width * 0.25),
                                padding: EdgeInsets.symmetric(
                                    horizontal: Get.width * 0.02),
                                height: Get.height * 0.47,
                                width: Get.width * 0.19,
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: [
                                      ColorRes.menuBarWhite,
                                      ColorRes.menuBar
                                    ],
                                  ),
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: ColorRes.borderColor, width: 2),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: Get.height * 0.05),
                                    GestureDetector(
                                      onTap: () {
                                        dashboardController.isNews = false;
                                        dashboardController.isLogout = false;
                                        dashboardController.isCategory = true;
                                        dashboardController.isNewsDetail =
                                            false;
                                        dashboardController.update(['dash']);
                                      },
                                      child: Container(
                                        height: Get.height * 0.09,
                                        width: Get.width * 0.16,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorRes.appColor,
                                              width: 1),
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.015,
                                            ),
                                            Image.asset(
                                              AssetRes.category,
                                              height: 20,
                                              width: 20,
                                              color:
                                                  dashboardController.isCategory
                                                      ? ColorRes.appColor
                                                      : Colors.black
                                                          .withOpacity(0.8),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              Strings.category,
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: dashboardController
                                                          .isCategory
                                                      ? ColorRes.appColor
                                                      : Colors.black
                                                          .withOpacity(0.8)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.05),
                                    GestureDetector(
                                      onTap: () {
                                        dashboardController.isCategory = false;
                                        dashboardController.isLogout = false;
                                        dashboardController.isNews = true;

                                        dashboardController.update(['dash']);
                                      },
                                      child: Container(
                                        height: Get.height * 0.09,
                                        width: Get.width * 0.16,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorRes.appColor,
                                              width: 1),
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.015,
                                            ),
                                            Image.asset(
                                              AssetRes.news,
                                              height: 20,
                                              width: 20,
                                              color: dashboardController.isNews
                                                  ? ColorRes.appColor
                                                  : Colors.black
                                                      .withOpacity(0.8),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              'News',
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  color: dashboardController
                                                          .isNews
                                                      ? ColorRes.appColor
                                                      : Colors.black
                                                          .withOpacity(0.8)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.045),
                                    GestureDetector(
                                      onTap: () {
                                        dashboardController.update(['dash']);

                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 5, sigmaY: 5),
                                              child: Dialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Container(
                                                  height: height * 0.6,
                                                  width: width * 1.8,
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: height * 0.01,
                                                    horizontal: width * 0.01,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    border: Border.all(
                                                      color:
                                                          ColorRes.borderColor,
                                                      width: 2,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                      5,
                                                    ),
                                                  ),
                                                  child: SingleChildScrollView(
                                                    child: Column(
                                                      children: [
                                                        const SizedBox(
                                                          height: 5,
                                                        ),
                                                        Row(
                                                          children: [
                                                            SizedBox(
                                                              width:
                                                                  width * 0.68,
                                                            ),
                                                            Text(
                                                              "Logout",
                                                              style: poppinsBold
                                                                  .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                                fontSize: 25,
                                                              ),
                                                            ),
                                                            Spacer(),
                                                            GestureDetector(
                                                              child: const Icon(
                                                                Icons.close,
                                                                color: Colors
                                                                    .black,
                                                                size: 20,
                                                              ),
                                                              onTap: () {
                                                                Get.back();
                                                              },
                                                            ),
                                                            SizedBox(
                                                              width:
                                                                  width * 0.05,
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.01,
                                                        ),
                                                        Container(
                                                          color:
                                                              ColorRes.appColor,
                                                          width: width * 0.35,
                                                          height: 1,
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.04,
                                                        ),
                                                        Image.asset(
                                                          AssetRes.logout,
                                                          height: height * 0.12,
                                                          width: width * 0.6,
                                                          color:
                                                              ColorRes.appColor,
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.02,
                                                        ),
                                                        Text(
                                                          'Are you sure want to\nLog Out',
                                                          style: TextStyle(
                                                            height: 1.5,
                                                            color: Colors.black
                                                                .withOpacity(
                                                                    0.8),
                                                            fontWeight:
                                                                FontWeight.w700,
                                                            fontSize:
                                                                textHeight *
                                                                    0.035,
                                                            fontFamily: "sfPro",
                                                          ),
                                                          textAlign:
                                                              TextAlign.center,
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.04,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            Get.back();
                                                            Get.to(
                                                                const LoginScreen());
                                                            dashboardController
                                                                .update(
                                                                    ['dash']);
                                                          },
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: ColorRes
                                                                  .appColor,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                3,
                                                              ),
                                                            ),
                                                            width: width * 0.8,
                                                            height:
                                                                height * 0.09,
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "LogOut",
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      height *
                                                                          0.04,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  color: Colors
                                                                      .white),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.02,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                        dashboardController.isNewsDetail =
                                            false;
                                      },
                                      child: Container(
                                        height: Get.height * 0.09,
                                        width: Get.width * 0.16,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                              color: ColorRes.appColor,
                                              width: 1),
                                          borderRadius: BorderRadius.circular(
                                            5,
                                          ),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: Get.width * 0.015,
                                            ),
                                            Image.asset(
                                              AssetRes.logout,
                                              height: 20,
                                              width: 20,
                                              color:
                                                  dashboardController.isLogout
                                                      ? ColorRes.appColor
                                                      : Colors.black
                                                          .withOpacity(0.8),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "Log out",
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: dashboardController
                                                          .isLogout
                                                      ? ColorRes.appColor
                                                      : Colors.black
                                                          .withOpacity(0.8)),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: Get.height * 0.04),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      dashboardController.isCategory
                          ? const CategoryScreen()
                          : const NewsScreen()
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
