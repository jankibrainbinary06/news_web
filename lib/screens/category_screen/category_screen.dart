// ignore_for_file: use_build_context_synchronously, non_constant_identifier_names, unused_local_variable, avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_web_app/Services/Shared_pref_services/pref_service.dart';
import 'package:news_web_app/screens/dashboard_screen/dashboard_controller.dart';
import 'package:news_web_app/utils/color_res.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../common/text_styles.dart';
import '../../utils/assets_res.dart';
import '../../utils/string_res.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = Get.put(DashboardController());

    double width = 0;
    double height = 0;
    double textHeight = 0;
    double border = 0;
    bool isMobile = false;
    bool isTablet = false;

    CollectionReference Users =
        FirebaseFirestore.instance.collection('categories');

    return StreamBuilder(
      stream: Users.orderBy("DateTime").snapshots(),
      builder: (context, snapshot) {
        return Expanded(
          child: ResponsiveBuilder(builder: (context, sizingInformation) {
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
            } else if (sizingInformation.isTablet) {
              isTablet = true;
            }
            return GetBuilder<DashboardController>(
              id: 'category',
              builder: (controller) {
                if (snapshot.hasData) {
                  return Container(
                    margin: EdgeInsets.only(
                      right: sizingInformation.isMobile
                          ? width * 0.1
                          : Get.width < 818
                              ? width * 0.1
                              : Get.width * 0.08,
                      left: sizingInformation.isMobile
                          ? width * 0.1
                          : Get.width * 0.01,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: Get.height * 0.08,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Visibility(
                                visible: Get.width <= 818,
                                child: GestureDetector(
                                  onTap: () {
                                    dashboardController.scaffoldKey.currentState
                                        ?.openDrawer();
                                  },
                                  child: Container(
                                    height:
                                        sizingInformation.isDesktop ? 50 : 40,
                                    width: width * 0.7,
                                    decoration: BoxDecoration(
                                      color: ColorRes.appColor,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: const Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.menu,
                                          color: Colors.white,
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "Menu",
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.white),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              dashboardController.isTapCategory
                                  // sub category add button
                                  ? GestureDetector(
                                      onTap: () {
                                        dashboardController.categoryController
                                            .clear();

                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 2, sigmaY: 2),
                                              child: Dialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Container(
                                                  height: height * 0.6,
                                                  width: width * 2,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 10,
                                                    horizontal: 10,
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
                                                          height: 2,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  EdgeInsets
                                                                      .only(
                                                                top: height *
                                                                    0.01,
                                                                right: width *
                                                                    0.02,
                                                              ),
                                                              child: InkWell(
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.8),
                                                                  size: 25,
                                                                ),
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          // replace with on tap categories
                                                          'Sport Category',
                                                          style: TextStyle(
                                                              height: 1.5,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.8),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              fontSize:
                                                                  textHeight *
                                                                      0.04,
                                                              fontFamily:
                                                                  "sfPro",
                                                              letterSpacing: 2),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.008,
                                                        ),
                                                        Container(
                                                          height: 1,
                                                          width: width * 0.75,
                                                          color:
                                                              ColorRes.appColor,
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.07,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height:
                                                                  height * 0.02,
                                                            ),
                                                            Container(
                                                              height:
                                                                  height * 0.1,
                                                              width:
                                                                  width * 1.6,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: ColorRes
                                                                    .appColor
                                                                    .withOpacity(
                                                                        0.1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  5,
                                                                ),
                                                                border: Border.all(
                                                                    color: ColorRes
                                                                        .appColor,
                                                                    width:
                                                                        border),
                                                              ),
                                                              child: Center(
                                                                child:
                                                                    TextField(
                                                                  controller:
                                                                      dashboardController
                                                                          .categoryController,
                                                                  style:
                                                                      TextStyle(
                                                                    fontFamily:
                                                                        "sfPro",
                                                                    color: Colors
                                                                        .black
                                                                        .withOpacity(
                                                                            0.8),
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                  decoration:
                                                                      InputDecoration(
                                                                    border:
                                                                        InputBorder
                                                                            .none,
                                                                    contentPadding:
                                                                        EdgeInsets
                                                                            .only(
                                                                      left: width *
                                                                          0.08,
                                                                      bottom: height *
                                                                          0.005,
                                                                    ),
                                                                    hintStyle:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          22,
                                                                      fontFamily:
                                                                          "sfPro",
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.6),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                    hintText:
                                                                        'Add category',
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.07,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            // update hear

                                                            dashboardController
                                                                    .newsData =
                                                                dashboardController
                                                                        .categoryData[
                                                                    'subcategory'];

                                                            dashboardController
                                                                .newsData
                                                                .add({
                                                              "Name": dashboardController
                                                                  .categoryController
                                                                  .text,
                                                              "Data": {},
                                                            });
                                                            print(
                                                                "NEWS DATA---> ${dashboardController.newsData}");
                                                            await Users.doc(snapshot
                                                                    .data!
                                                                    .docs[dashboardController
                                                                        .idindex]
                                                                    .id)
                                                                .update({
                                                              'subcategory':
                                                                  dashboardController
                                                                      .newsData,
                                                            });

                                                            dashboardController
                                                                    .subCNews =
                                                                true;

                                                            PrefService.setValue(
                                                                'subcategory',
                                                                dashboardController
                                                                    .categoryController
                                                                    .text);
                                                            print(
                                                                dashboardController
                                                                    .idindex);
                                                            dashboardController
                                                                    .isCategory =
                                                                false;
                                                            dashboardController
                                                                .isNews = true;
                                                            Get.back();
                                                            dashboardController
                                                                    .isNewsCategory =
                                                                false;
                                                            dashboardController
                                                                .update([
                                                              'category'
                                                            ]);

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
                                                                5,
                                                              ),
                                                            ),
                                                            width: width * 0.9,
                                                            height:
                                                                height * 0.1,
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "Next",
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
                                      },
                                      child: Container(
                                        height: sizingInformation.isDesktop
                                            ? 50
                                            : 40,
                                        width: width * 0.7,
                                        decoration: BoxDecoration(
                                            color: ColorRes.appColor,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              AssetRes.add,
                                              height: 15,
                                              width: 15,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(
                                              "ADD",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'sfPro',
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  // category screen add button
                                  : GestureDetector(
                                      onTap: () {
                                        dashboardController.categoryController
                                            .clear();
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return BackdropFilter(
                                              filter: ImageFilter.blur(
                                                  sigmaX: 2, sigmaY: 2),
                                              child: Dialog(
                                                backgroundColor:
                                                    Colors.transparent,
                                                child: Container(
                                                  height: height * 0.6,
                                                  width: width * 2,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    vertical: 10,
                                                    horizontal: 10,
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
                                                          height: 2,
                                                        ),
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .end,
                                                          children: [
                                                            Padding(
                                                              padding: EdgeInsets.only(
                                                                  top: height *
                                                                      0.01,
                                                                  right: width *
                                                                      0.02),
                                                              child: InkWell(
                                                                child: Icon(
                                                                  Icons.close,
                                                                  color: Colors
                                                                      .black
                                                                      .withOpacity(
                                                                          0.8),
                                                                  size: 25,
                                                                ),
                                                                onTap: () {
                                                                  Get.back();
                                                                },
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        Text(
                                                          'Add category',
                                                          style: TextStyle(
                                                              height: 1.5,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.8),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w900,
                                                              fontSize:
                                                                  textHeight *
                                                                      0.045,
                                                              fontFamily:
                                                                  "sfPro",
                                                              letterSpacing: 2),
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              height * 0.008,
                                                        ),
                                                        Container(
                                                          height: 1,
                                                          width: width * 0.65,
                                                          color:
                                                              ColorRes.appColor,
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.06,
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              height:
                                                                  height * 0.02,
                                                            ),
                                                            Container(
                                                              height:
                                                                  height * 0.1,
                                                              width:
                                                                  width * 1.6,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: ColorRes
                                                                    .appColor
                                                                    .withOpacity(
                                                                        0.1),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  5,
                                                                ),
                                                                border: Border.all(
                                                                    color: ColorRes
                                                                        .appColor,
                                                                    width:
                                                                        border),
                                                              ),
                                                              child: Center(
                                                                child: Form(
                                                                  key: dashboardController
                                                                      .formKey,
                                                                  child:
                                                                      TextFormField(
                                                                    controller:
                                                                        dashboardController
                                                                            .categoryController,
                                                                    style:
                                                                        TextStyle(
                                                                      fontFamily:
                                                                          "sfPro",
                                                                      color: Colors
                                                                          .black
                                                                          .withOpacity(
                                                                              0.8),
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                    ),
                                                                    decoration:
                                                                        InputDecoration(
                                                                      border: InputBorder
                                                                          .none,
                                                                      contentPadding:
                                                                          EdgeInsets
                                                                              .only(
                                                                        left: width *
                                                                            0.08,
                                                                        bottom: height *
                                                                            0.005,
                                                                      ),
                                                                      hintStyle:
                                                                          TextStyle(
                                                                        fontFamily:
                                                                            "sfPro",
                                                                        color: Colors
                                                                            .black
                                                                            .withOpacity(0.6),
                                                                        fontSize:
                                                                            22,
                                                                        fontWeight:
                                                                            FontWeight.w500,
                                                                      ),
                                                                      hintText:
                                                                          'Add category',
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: height * 0.06,
                                                        ),
                                                        GestureDetector(
                                                          onTap: () async {
                                                            // main category add

                                                            Get.back();
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) {
                                                                return BackdropFilter(
                                                                  filter: ImageFilter
                                                                      .blur(
                                                                          sigmaX:
                                                                              2,
                                                                          sigmaY:
                                                                              2),
                                                                  child: Dialog(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    child:
                                                                        Container(
                                                                      height:
                                                                          height *
                                                                              0.6,
                                                                      width:
                                                                          width *
                                                                              2,
                                                                      padding:
                                                                          const EdgeInsets
                                                                              .symmetric(
                                                                        vertical:
                                                                            10,
                                                                        horizontal:
                                                                            10,
                                                                      ),
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        color: Colors
                                                                            .white,
                                                                        border:
                                                                            Border.all(
                                                                          color:
                                                                              ColorRes.borderColor,
                                                                          width:
                                                                              2,
                                                                        ),
                                                                        borderRadius:
                                                                            BorderRadius.circular(
                                                                          5,
                                                                        ),
                                                                      ),
                                                                      child:
                                                                          SingleChildScrollView(
                                                                        child:
                                                                            Column(
                                                                          children: [
                                                                            const SizedBox(
                                                                              height: 2,
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: EdgeInsets.only(top: Get.height * 0.01, right: Get.width * 0.01),
                                                                                  child: InkWell(
                                                                                    child: Icon(
                                                                                      Icons.close,
                                                                                      color: Colors.black.withOpacity(0.8),
                                                                                      size: 25,
                                                                                    ),
                                                                                    onTap: () {
                                                                                      Get.back();
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            Text(
                                                                              dashboardController.categoryController.text,
                                                                              style: TextStyle(height: 1.5, color: Colors.black.withOpacity(0.8), fontWeight: FontWeight.w900, fontSize: textHeight * 0.045, fontFamily: "sfPro", letterSpacing: 2),
                                                                            ),
                                                                            SizedBox(
                                                                              height: height * 0.008,
                                                                            ),
                                                                            Container(
                                                                              height: 1,
                                                                              width: width * 0.3,
                                                                              color: ColorRes.appColor,
                                                                            ),
                                                                            SizedBox(
                                                                              height: height * 0.07,
                                                                            ),
                                                                            Column(
                                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                                              children: [
                                                                                SizedBox(
                                                                                  height: height * 0.02,
                                                                                ),
                                                                                Container(
                                                                                  height: height * 0.1,
                                                                                  width: width * 1.6,
                                                                                  decoration: BoxDecoration(
                                                                                    color: ColorRes.appColor.withOpacity(0.1),
                                                                                    borderRadius: BorderRadius.circular(
                                                                                      5,
                                                                                    ),
                                                                                    border: Border.all(color: ColorRes.appColor, width: border),
                                                                                  ),
                                                                                  child: Center(
                                                                                    child: TextField(
                                                                                      controller: dashboardController.subCategoryController,
                                                                                      style: TextStyle(
                                                                                        fontFamily: "sfPro",
                                                                                        color: Colors.black.withOpacity(0.8),
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                      decoration: InputDecoration(
                                                                                        border: InputBorder.none,
                                                                                        contentPadding: EdgeInsets.only(
                                                                                          left: width * 0.08,
                                                                                          bottom: height * 0.001,
                                                                                        ),
                                                                                        hintStyle: TextStyle(
                                                                                          fontFamily: "sfPro",
                                                                                          fontSize: 22,
                                                                                          color: Colors.black.withOpacity(0.6),
                                                                                          fontWeight: FontWeight.w500,
                                                                                        ),
                                                                                        hintText: 'Add sport sub category',
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                            SizedBox(
                                                                              height: height * 0.07,
                                                                            ),
                                                                            GestureDetector(
                                                                              onTap: () async {
                                                                                if (dashboardController.subCategoryController.text.isNotEmpty) {
                                                                                  await Users.add(
                                                                                    {
                                                                                      "category": dashboardController.categoryController.text,
                                                                                      "subcategory": [
                                                                                        {
                                                                                          "Name": dashboardController.subCategoryController.text,
                                                                                          "Data": {},
                                                                                        }
                                                                                      ],
                                                                                      "DateTime": DateTime.now(),
                                                                                    },
                                                                                  );
                                                                                  PrefService.setValue('subcategory', dashboardController.subCategoryController.text);
                                                                                }
                                                                                Users.get().then(
                                                                                  (value) {
                                                                                    value.docs.forEach(
                                                                                      (element) async {
                                                                                        if (element['category'] == dashboardController.categoryController.text) {
                                                                                          dashboardController.id = element.id;
                                                                                          print(dashboardController.id);
                                                                                          PrefService.setValue('DocumentId', dashboardController.id.toString());
                                                                                          dashboardController.update(
                                                                                            ['category'],
                                                                                          );
                                                                                        }
                                                                                      },
                                                                                    );
                                                                                  },
                                                                                );
                                                                                dashboardController.subCategoryController.clear();
                                                                                dashboardController.isCategory = false;
                                                                                dashboardController.isNews = true;
                                                                                Get.back();
                                                                                dashboardController.isNewsCategory = false;
                                                                                dashboardController.subCNews = true;
                                                                                dashboardController.update([
                                                                                  'category'
                                                                                ]);
                                                                                dashboardController.update([
                                                                                  'dash'
                                                                                ]);
                                                                              },
                                                                              child: Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: ColorRes.appColor,
                                                                                  borderRadius: BorderRadius.circular(
                                                                                    5,
                                                                                  ),
                                                                                ),
                                                                                width: width * 0.9,
                                                                                height: height * 0.1,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "Add News",
                                                                                  style: TextStyle(
                                                                                    fontSize: height * 0.04,
                                                                                    fontWeight: FontWeight.w600,
                                                                                    color: Colors.white,
                                                                                  ),
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

                                                            dashboardController
                                                                .update([
                                                              'category'
                                                            ]);
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
                                                                5,
                                                              ),
                                                            ),
                                                            width: width * 0.9,
                                                            height:
                                                                height * 0.1,
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                              "Next",
                                                              style: TextStyle(
                                                                fontSize:
                                                                    height *
                                                                        0.04,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white,
                                                              ),
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
                                      },
                                      child: Container(
                                        height: sizingInformation.isDesktop
                                            ? 50
                                            : 40,
                                        width: width * 0.7,
                                        decoration: BoxDecoration(
                                            color: ColorRes.appColor,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              AssetRes.add,
                                              height: 15,
                                              width: 15,
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            const Text(
                                              "ADD",
                                              style: TextStyle(
                                                  fontSize: 17,
                                                  fontWeight: FontWeight.w400,
                                                  fontFamily: 'sfPro',
                                                  color: Colors.white),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.symmetric(
                              horizontal: sizingInformation.isMobile
                                  ? Get.width * 0.02
                                  : Get.width * 0.03,
                              vertical: Get.height * 0.04,
                            ),
                            height: Get.height * 0.8,
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    width: 2, color: ColorRes.borderColor)),
                            child: dashboardController.isTapCategory == true
                                // sub category pop up
                                ? Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        dashboardController
                                            .categoryData['category'],
                                        style: poppinsBold.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: sizingInformation.isMobile
                                                ? 22
                                                : 28,
                                            fontFamily: 'poppinsSemiBold'),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.04,
                                      ),
                                      SizedBox(
                                        child: GridView.builder(
                                          shrinkWrap: true,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                sizingInformation.isMobile
                                                    ? 1
                                                    : 2,
                                            mainAxisExtent:
                                                sizingInformation.isMobile
                                                    ? 60
                                                    : 90,
                                            crossAxisSpacing: 0,
                                          ),
                                          itemCount: dashboardController
                                              .categoryData['subcategory']
                                              .length,
                                          itemBuilder: (context, index) {
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: Get.height * 0.001),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      sizingInformation.isMobile
                                                          ? Get.width * 0.02
                                                          : Get.width * 0.04,
                                                  vertical:
                                                      sizingInformation.isMobile
                                                          ? Get.height * 0.015
                                                          : Get.height * 0.02),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        dashboardController
                                                            .isCategory = false;
                                                        dashboardController
                                                            .isNews = true;
                                                        Get.back();
                                                        dashboardController
                                                                .isNewsCategory =
                                                            false;
                                                        final SharedPreferences
                                                            prefs =
                                                            await SharedPreferences
                                                                .getInstance();
                                                        await prefs.setString(
                                                            'subcategory',
                                                            '${dashboardController.categoryData['subcategory'][index]['Name']}');
                                                        dashboardController
                                                            .subIndex = index;
                                                        dashboardController
                                                            .update(['dash']);
                                                      },
                                                      child: Container(
                                                        width: Get.width > 1150
                                                            ? width * 0.9
                                                            : width * 0.6,
                                                        alignment:
                                                            Alignment.center,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: ColorRes
                                                                  .appColor,
                                                              width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            5,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          dashboardController
                                                                      .categoryData[
                                                                  'subcategory']
                                                              [index]['Name'],
                                                          style: TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black
                                                                .withOpacity(
                                                              0.8,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: sizingInformation
                                                            .isMobile
                                                        ? 18
                                                        : 30,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        dashboardController
                                                            .editCategoryController
                                                            .text = dashboardController
                                                                    .categoryData[
                                                                'subcategory']
                                                            [index]['Name'];

                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return BackdropFilter(
                                                              filter: ImageFilter
                                                                  .blur(
                                                                      sigmaX: 2,
                                                                      sigmaY:
                                                                          2),
                                                              child: Dialog(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      height *
                                                                          0.6,
                                                                  width:
                                                                      width * 2,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        10,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: ColorRes
                                                                          .borderColor,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      5,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        const SizedBox(
                                                                          height:
                                                                              2,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.only(top: Get.height * 0.01, right: Get.width * 0.01),
                                                                              child: InkWell(
                                                                                child: Icon(
                                                                                  Icons.close,
                                                                                  color: Colors.black.withOpacity(0.8),
                                                                                  size: 25,
                                                                                ),
                                                                                onTap: () {
                                                                                  Get.back();
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Text(
                                                                          'Edit Category',
                                                                          style: TextStyle(
                                                                              height: 1.5,
                                                                              color: Colors.black.withOpacity(0.8),
                                                                              fontWeight: FontWeight.w900,
                                                                              fontSize: textHeight * 0.045,
                                                                              fontFamily: "sfPro",
                                                                              letterSpacing: 2),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              height * 0.008,
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              1,
                                                                          width:
                                                                              width * 0.7,
                                                                          color:
                                                                              ColorRes.appColor,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              height * 0.08,
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              height * 0.1,
                                                                          width:
                                                                              width * 1.6,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              5,
                                                                            ),
                                                                            color:
                                                                                ColorRes.appColor.withOpacity(0.1),
                                                                            border:
                                                                                Border.all(color: ColorRes.appColor, width: border),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                TextField(
                                                                              controller: dashboardController.editCategoryController,
                                                                              style: TextStyle(
                                                                                fontFamily: "sfPro",
                                                                                color: Colors.black.withOpacity(0.8),
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                contentPadding: EdgeInsets.only(
                                                                                  left: width * 0.08,
                                                                                  bottom: height * 0.005,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              height * 0.08,
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () async {
                                                                            dashboardController.newsData =
                                                                                dashboardController.categoryData['subcategory'];

                                                                            dashboardController.newsData.removeAt(index);

                                                                            dashboardController.newsData.insert(index, {
                                                                              "Name": dashboardController.editCategoryController.text,
                                                                              "Data": {},
                                                                            });
                                                                            await Users.doc(snapshot.data!.docs[dashboardController.idindex].id).update({
                                                                              'subcategory': dashboardController.newsData,
                                                                            });

                                                                            dashboardController.update([
                                                                              'category'
                                                                            ]);
                                                                            dashboardController.update([
                                                                              'dash'
                                                                            ]);
                                                                            Get.back();
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: ColorRes.appColor,
                                                                              borderRadius: BorderRadius.circular(
                                                                                5,
                                                                              ),
                                                                            ),
                                                                            width:
                                                                                width * 0.9,
                                                                            height:
                                                                                height * 0.1,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                Text(
                                                                              "Upload",
                                                                              style: TextStyle(fontSize: height * 0.035, fontWeight: FontWeight.w600, color: Colors.white),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              height * 0.02,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Image.asset(
                                                        AssetRes.edit,
                                                        height:
                                                            sizingInformation
                                                                    .isMobile
                                                                ? 18
                                                                : 20,
                                                        width: sizingInformation
                                                                .isMobile
                                                            ? 18
                                                            : 20,
                                                        color:
                                                            ColorRes.appColor,
                                                      )),
                                                  SizedBox(
                                                    width: sizingInformation
                                                            .isMobile
                                                        ? 10
                                                        : 20,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return BackdropFilter(
                                                              filter: ImageFilter
                                                                  .blur(
                                                                      sigmaX: 2,
                                                                      sigmaY:
                                                                          2),
                                                              child: Dialog(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      height *
                                                                          0.6,
                                                                  width:
                                                                      width * 2,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        10,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: ColorRes
                                                                          .borderColor,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      5,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        const SizedBox(
                                                                          height:
                                                                              2,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.only(top: Get.height * 0.01, right: Get.width * 0.01),
                                                                              child: InkWell(
                                                                                child: Icon(
                                                                                  Icons.close,
                                                                                  color: Colors.black.withOpacity(0.8),
                                                                                  size: 25,
                                                                                ),
                                                                                onTap: () {
                                                                                  Get.back();
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        CircleAvatar(
                                                                          maxRadius:
                                                                              width * 0.18,
                                                                          backgroundColor:
                                                                              Colors.white,
                                                                          child:
                                                                              Image.asset(
                                                                            "assets/icons/delete_icon.png",
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              Get.height * 0.02,
                                                                        ),
                                                                        Text(
                                                                          'Are you sure you want to delete ${dashboardController.categoryData['subcategory'][index]['Name']} Category?',
                                                                          style:
                                                                              TextStyle(
                                                                            height:
                                                                                1.5,
                                                                            color:
                                                                                Colors.black.withOpacity(0.8),
                                                                            fontWeight:
                                                                                FontWeight.w900,
                                                                            fontSize:
                                                                                textHeight * 0.04,
                                                                            fontFamily:
                                                                                "sfPro",
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.center,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              Get.height * 0.03,
                                                                        ),
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceEvenly,
                                                                            children: [
                                                                              InkWell(
                                                                                onTap: () async {
                                                                                  dashboardController.newsData = dashboardController.categoryData['subcategory'];
                                                                                  dashboardController.newsData.removeAt(index);

                                                                                  await Users.doc(snapshot.data!.docs[dashboardController.idindex].id).update({
                                                                                    'subcategory': dashboardController.newsData,
                                                                                  });
                                                                                  dashboardController.update([
                                                                                    'category'
                                                                                  ]);
                                                                                  dashboardController.update([
                                                                                    'dash'
                                                                                  ]);
                                                                                  Get.back();
                                                                                },
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    color: ColorRes.appColor,
                                                                                    borderRadius: BorderRadius.circular(
                                                                                      5,
                                                                                    ),
                                                                                  ),
                                                                                  width: width * 0.6,
                                                                                  height: height * 0.09,
                                                                                  alignment: Alignment.center,
                                                                                  child: Text(
                                                                                    "Yes",
                                                                                    style: TextStyle(
                                                                                      fontSize: height * 0.035,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      color: Colors.white,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  Get.back();
                                                                                },
                                                                                child: Container(
                                                                                  decoration: BoxDecoration(
                                                                                    border: Border.all(color: ColorRes.borderColor, width: 1),
                                                                                    borderRadius: BorderRadius.circular(
                                                                                      5,
                                                                                    ),
                                                                                  ),
                                                                                  width: width * 0.6,
                                                                                  height: height * 0.09,
                                                                                  alignment: Alignment.center,
                                                                                  child: Text(
                                                                                    "No",
                                                                                    style: TextStyle(
                                                                                      fontSize: height * 0.035,
                                                                                      fontWeight: FontWeight.w600,
                                                                                      color: ColorRes.borderColor,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              )
                                                                            ]),
                                                                        SizedBox(
                                                                          height:
                                                                              height * 0.02,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Image.asset(
                                                        AssetRes.delete,
                                                        height:
                                                            sizingInformation
                                                                    .isMobile
                                                                ? 18
                                                                : 20,
                                                        width: sizingInformation
                                                                .isMobile
                                                            ? 18
                                                            : 20,
                                                        color:
                                                            ColorRes.appColor,
                                                      )),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  )
                                // category pop up
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        Strings.category,
                                        style: poppinsBold.copyWith(
                                            fontWeight: FontWeight.w600,
                                            fontSize: sizingInformation.isMobile
                                                ? 22
                                                : 28,
                                            fontFamily: 'poppinsSemiBold'),
                                      ),
                                      SizedBox(
                                        height: Get.height * 0.04,
                                      ),
                                      Expanded(
                                        child: GridView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.docs.length,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                sizingInformation.isMobile
                                                    ? 1
                                                    : 2,
                                            mainAxisExtent:
                                                sizingInformation.isMobile
                                                    ? 60
                                                    : 90,
                                            crossAxisSpacing: 0,
                                          ),
                                          itemBuilder: (context, index) {
                                            Map data = snapshot
                                                .data!.docs[index]
                                                .data() as Map<String, dynamic>;
                                            return Container(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: Get.height * 0.001),
                                              margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      sizingInformation.isMobile
                                                          ? Get.width * 0.02
                                                          : Get.width * 0.04,
                                                  vertical:
                                                      sizingInformation.isMobile
                                                          ? Get.height * 0.015
                                                          : Get.height * 0.02),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        dashboardController
                                                            .idindex = index;
                                                        dashboardController
                                                                .isTapCategory =
                                                            true;
                                                        dashboardController
                                                            .update(
                                                                ['category']);
                                                        dashboardController
                                                            .update(['dash']);
                                                        dashboardController
                                                                .docId =
                                                            snapshot.data!
                                                                .docs[index].id;

                                                        PrefService.setValue(
                                                            'DocumentId',
                                                            snapshot
                                                                .data!
                                                                .docs[index]
                                                                .id);
                                                        dashboardController
                                                                .categoryData =
                                                            snapshot.data!
                                                                .docs[index]
                                                                .data();
                                                        dashboardController
                                                            .update(
                                                                ['category']);
                                                        dashboardController
                                                            .update(['dash']);
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height:
                                                            Get.height * 0.7,
                                                        width: Get.width * 0.5,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: Colors.white,
                                                          border: Border.all(
                                                              color: ColorRes
                                                                  .appColor,
                                                              width: 1),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                            5,
                                                          ),
                                                        ),
                                                        child: Text(
                                                          data['category'],
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.8)),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: sizingInformation
                                                            .isMobile
                                                        ? 20
                                                        : 30,
                                                  ),
                                                  GestureDetector(
                                                      onTap: () {
                                                        dashboardController
                                                                .editCategoryController
                                                                .text =
                                                            data['category'];

                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return BackdropFilter(
                                                              filter: ImageFilter
                                                                  .blur(
                                                                      sigmaX: 2,
                                                                      sigmaY:
                                                                          2),
                                                              child: Dialog(
                                                                backgroundColor:
                                                                    Colors
                                                                        .transparent,
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      height *
                                                                          0.6,
                                                                  width:
                                                                      width * 2,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .symmetric(
                                                                    vertical:
                                                                        10,
                                                                    horizontal:
                                                                        10,
                                                                  ),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Colors
                                                                        .white,
                                                                    border:
                                                                        Border
                                                                            .all(
                                                                      color: ColorRes
                                                                          .borderColor,
                                                                      width: 2,
                                                                    ),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      5,
                                                                    ),
                                                                  ),
                                                                  child:
                                                                      SingleChildScrollView(
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        const SizedBox(
                                                                          height:
                                                                              2,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            Padding(
                                                                              padding: EdgeInsets.only(top: Get.height * 0.01, right: Get.width * 0.01),
                                                                              child: InkWell(
                                                                                child: Icon(
                                                                                  Icons.close,
                                                                                  color: Colors.black.withOpacity(0.8),
                                                                                  size: 25,
                                                                                ),
                                                                                onTap: () {
                                                                                  Get.back();
                                                                                },
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        Text(
                                                                          'Edit Category',
                                                                          style: TextStyle(
                                                                              height: 1.5,
                                                                              color: Colors.black,
                                                                              fontWeight: FontWeight.w900,
                                                                              fontSize: textHeight * 0.045,
                                                                              fontFamily: "sfPro",
                                                                              letterSpacing: 2),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              Get.height * 0.008,
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              1,
                                                                          width:
                                                                              width * 0.7,
                                                                          color:
                                                                              ColorRes.appColor,
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              height * 0.07,
                                                                        ),
                                                                        Container(
                                                                          height:
                                                                              height * 0.1,
                                                                          width:
                                                                              width * 1.6,
                                                                          decoration:
                                                                              BoxDecoration(
                                                                            color:
                                                                                ColorRes.appColor.withOpacity(0.1),
                                                                            borderRadius:
                                                                                BorderRadius.circular(
                                                                              5,
                                                                            ),
                                                                            border:
                                                                                Border.all(color: ColorRes.appColor, width: border),
                                                                          ),
                                                                          child:
                                                                              Center(
                                                                            child:
                                                                                TextField(
                                                                              controller: dashboardController.editCategoryController,
                                                                              style: TextStyle(
                                                                                fontSize: 22,
                                                                                fontFamily: "sfPro",
                                                                                color: Colors.black.withOpacity(0.8),
                                                                                fontWeight: FontWeight.w500,
                                                                              ),
                                                                              decoration: InputDecoration(
                                                                                border: InputBorder.none,
                                                                                contentPadding: EdgeInsets.only(
                                                                                  left: width * 0.18,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              height * 0.07,
                                                                        ),
                                                                        GestureDetector(
                                                                          onTap:
                                                                              () async {
                                                                            await Users.doc(snapshot.data!.docs[index].id).update({
                                                                              "category": dashboardController.editCategoryController.text,
                                                                            });
                                                                            Get.back();
                                                                            dashboardController.update([
                                                                              'category'
                                                                            ]);
                                                                            dashboardController.update([
                                                                              'dash'
                                                                            ]);
                                                                          },
                                                                          child:
                                                                              Container(
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: ColorRes.appColor,
                                                                              borderRadius: BorderRadius.circular(
                                                                                5,
                                                                              ),
                                                                            ),
                                                                            width:
                                                                                width * 0.9,
                                                                            height:
                                                                                height * 0.1,
                                                                            alignment:
                                                                                Alignment.center,
                                                                            child:
                                                                                Text(
                                                                              "Upload",
                                                                              style: TextStyle(fontSize: height * 0.035, fontWeight: FontWeight.w600, color: Colors.white),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              height * 0.02,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      child: Image.asset(
                                                        AssetRes.edit,
                                                        height:
                                                            sizingInformation
                                                                    .isMobile
                                                                ? 18
                                                                : 20,
                                                        width: sizingInformation
                                                                .isMobile
                                                            ? 18
                                                            : 20,
                                                        color:
                                                            ColorRes.appColor,
                                                      )),
                                                  SizedBox(
                                                    width: sizingInformation
                                                            .isMobile
                                                        ? 15
                                                        : 20,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) {
                                                          return BackdropFilter(
                                                            filter: ImageFilter
                                                                .blur(
                                                                    sigmaX: 2,
                                                                    sigmaY: 2),
                                                            child: Dialog(
                                                              backgroundColor:
                                                                  Colors
                                                                      .transparent,
                                                              child: Container(
                                                                height: height *
                                                                    0.6,
                                                                width:
                                                                    width * 2,
                                                                padding:
                                                                    const EdgeInsets
                                                                        .symmetric(
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      10,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  border: Border
                                                                      .all(
                                                                    color: ColorRes
                                                                        .borderColor,
                                                                    width: 2,
                                                                  ),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    5,
                                                                  ),
                                                                ),
                                                                child:
                                                                    SingleChildScrollView(
                                                                  child: Column(
                                                                    children: [
                                                                      const SizedBox(
                                                                        height:
                                                                            2,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.only(top: Get.height * 0.01, right: Get.width * 0.01),
                                                                            child:
                                                                                InkWell(
                                                                              child: Icon(
                                                                                Icons.close,
                                                                                color: Colors.black.withOpacity(0.8),
                                                                                size: 25,
                                                                              ),
                                                                              onTap: () {
                                                                                Get.back();
                                                                              },
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      CircleAvatar(
                                                                        maxRadius:
                                                                            width *
                                                                                0.18,
                                                                        backgroundColor:
                                                                            Colors.white,
                                                                        child: Image
                                                                            .asset(
                                                                          "assets/icons/delete_icon.png",
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: Get.height *
                                                                            0.02,
                                                                      ),
                                                                      Text(
                                                                        'Are you sure you want to delete\n${data['category']} Category?',
                                                                        style:
                                                                            TextStyle(
                                                                          height:
                                                                              1.5,
                                                                          color: Colors
                                                                              .black
                                                                              .withOpacity(0.8),
                                                                          fontWeight:
                                                                              FontWeight.w900,
                                                                          fontSize:
                                                                              textHeight * 0.04,
                                                                          fontFamily:
                                                                              "sfPro",
                                                                        ),
                                                                        textAlign:
                                                                            TextAlign.center,
                                                                      ),
                                                                      SizedBox(
                                                                        height: Get.height *
                                                                            0.04,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceEvenly,
                                                                        children: [
                                                                          InkWell(
                                                                            onTap:
                                                                                () async {
                                                                              await Users.doc(snapshot.data!.docs[index].id).delete();
                                                                              Get.back();
                                                                              dashboardController.update([
                                                                                'category'
                                                                              ]);
                                                                              dashboardController.update([
                                                                                'dash'
                                                                              ]);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                color: ColorRes.appColor,
                                                                                borderRadius: BorderRadius.circular(
                                                                                  5,
                                                                                ),
                                                                              ),
                                                                              width: width * 0.6,
                                                                              height: height * 0.09,
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                "Yes",
                                                                                style: TextStyle(
                                                                                  fontSize: height * 0.035,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  color: Colors.white,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Get.back();
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              decoration: BoxDecoration(
                                                                                border: Border.all(color: ColorRes.borderColor, width: 1),
                                                                                borderRadius: BorderRadius.circular(
                                                                                  5,
                                                                                ),
                                                                              ),
                                                                              width: width * 0.6,
                                                                              height: height * 0.09,
                                                                              alignment: Alignment.center,
                                                                              child: Text(
                                                                                "No",
                                                                                style: TextStyle(
                                                                                  fontSize: height * 0.035,
                                                                                  fontWeight: FontWeight.w600,
                                                                                  color: ColorRes.borderColor,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.02,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      );
                                                    },
                                                    child: Image.asset(
                                                      AssetRes.delete,
                                                      height: sizingInformation
                                                              .isMobile
                                                          ? 18
                                                          : 20,
                                                      width: sizingInformation
                                                              .isMobile
                                                          ? 18
                                                          : 20,
                                                      color: ColorRes.appColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                          )
                        ],
                      ),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            );
          }),
        );
      },
    );
  }
}
