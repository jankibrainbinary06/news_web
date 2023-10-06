// ignore_for_file: unused_local_variable, avoid_print, deprecated_member_use, no_leading_underscores_for_local_identifiers

import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_web_app/screens/dashboard_screen/dashboard_controller.dart';
import 'package:news_web_app/screens/news_screen/widgets/edit_news_popup.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:video_player/video_player.dart';
import '../../../common/text_styles.dart';
import '../../../utils/assets_res.dart';
import '../../../utils/color_res.dart';

class NewsDetail extends StatelessWidget {
  const NewsDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = 0;
    double height = 0;
    double textHeight = 0;
    double border = 0;
    bool isMobile = false;

    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
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
        return StreamBuilder(
          stream: dashboardController.Users.orderBy('DateTime').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print("---->ShowNewsIndex ${dashboardController.showNewsIndex}");
              Map<String, dynamic> data =
                  snapshot.data!.docs[dashboardController.showNewsIndex!].data()
                      as Map<String, dynamic>;
              print(data);
              print(
                  "--------->${data['subcategory'][dashboardController.indexOfDropDown]['Data']['ImageUrl']}");

              if (data['subcategory'][dashboardController.indexOfDropDown]
                      ['Data']['AssetType'] ==
                  'mp4') {
                if (dashboardController.isVideo == false) {
                  dashboardController.VideoCntrl =
                      VideoPlayerController.network(data['subcategory']
                              [dashboardController.indexOfDropDown]['Data']
                          ['ImageUrl'])
                        ..initialize().then((_) {});

                  if (dashboardController.VideoCntrl!.value.isCompleted) {
                    dashboardController.isVideo = false;
                    dashboardController.update(['detailscreen']);
                  } else {
                    dashboardController.isVideo = true;
                  }
                  dashboardController.update(['detailscreen']);
                }
              }
              void _toggleVideo() {
                if (dashboardController.VideoCntrl!.value.isPlaying) {
                  dashboardController.VideoCntrl!.pause();
                } else {
                  dashboardController.VideoCntrl!.play();
                }
              }

              return WillPopScope(
                onWillPop: () async {
                  if (dashboardController.isTapCategory == true) {
                    dashboardController.isTapCategory = false;
                    dashboardController.update(['category']);
                    return false;
                  } else {
                    return true;
                  }
                },
                child: GetBuilder<DashboardController>(
                    id: "detailscreen",
                    builder: (con) {
                      return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(
                            horizontal: sizingInformation.isMobile
                                ? 10
                                : Get.height > 1360
                                    ? width * 0.6
                                    : Get.height <= 1360 && Get.height > 1050
                                        ? width * 0.25
                                        : width * 0.3,
                            vertical: Get.height * 0.04),
                        height: Get.height * 0.8,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                ColorRes.menuBarWhite,
                                ColorRes.menuBar,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                                width: 2, color: ColorRes.borderColor)),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Text(
                                "${data['subcategory'][dashboardController.indexOfDropDown]['Data']['HeadLine'] ?? "No Data"}",
                                style: mediumSf.copyWith(
                                  fontSize: 27,
                                  fontWeight: FontWeight.w700,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: Get.height * 0.035,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "${data['subcategory'][dashboardController.indexOfDropDown]['Data']['ChannelName'] ?? "No Data"}",
                                    style: mediumSf.copyWith(fontSize: 20),
                                  ),
                                  const Spacer(),
                                  Text(
                                    "${data['subcategory'][dashboardController.indexOfDropDown]['Data']['City'] ?? "No Data"}, ",
                                    style: mediumSf.copyWith(fontSize: 20),
                                  ),
                                  Text(
                                    "${data['subcategory'][dashboardController.indexOfDropDown]['Data']['Date'] ?? "No Data"}",
                                    style: mediumSf.copyWith(fontSize: 20),
                                  ),
                                  Text(
                                    "${data['subcategory'][dashboardController.indexOfDropDown]['Data']['Time'] ?? "No Data"}",
                                    style: mediumSf.copyWith(fontSize: 20),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: Get.height * 0.035,
                              ),
                              Container(
                                width: width * 25,
                                height: sizingInformation.isDesktop
                                    ? height * 0.5
                                    : height * 0.34,
                                margin: EdgeInsets.symmetric(
                                    horizontal: width * 0.3),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                ),
                                child: data['subcategory'][dashboardController
                                                .indexOfDropDown]['Data']
                                            ['AssetType'] ==
                                        'mp4'
                                    ? Stack(
                                        children: [
                                          VideoPlayer(
                                              dashboardController.VideoCntrl!),
                                          Positioned(
                                            child: Center(
                                              child: InkWell(
                                                onTap: () {
                                                  _toggleVideo();
                                                  dashboardController
                                                      .update(['detailscreen']);
                                                },
                                                child: CircleAvatar(
                                                  maxRadius: 20,
                                                  child: dashboardController
                                                          .VideoCntrl!
                                                          .value
                                                          .isPlaying
                                                      ? const Icon(Icons.pause)
                                                      : const Icon(
                                                          Icons.play_arrow),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : CachedNetworkImage(
                                        imageUrl: data['subcategory'][
                                                    dashboardController
                                                        .indexOfDropDown]
                                                ['Data']['ImageUrl'] ??
                                            "",
                                        placeholder: (context, url) =>
                                            const Center(
                                                child:
                                                    CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.error),
                                      ),
                              ),
                              SizedBox(
                                height: Get.height * 0.025,
                              ),
                              Text(
                                "${data['subcategory'][dashboardController.indexOfDropDown]['Data']['Topic'] ?? "No Data"}",
                                style: mediumSf.copyWith(
                                    fontSize: 32, fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                height: Get.height * 0.025,
                              ),
                              Text(
                                "${data['subcategory'][dashboardController.indexOfDropDown]['Data']['Description'] ?? ""}",
                                style: mediumSf.copyWith(
                                    fontSize: 22, fontWeight: FontWeight.w400),
                              ),
                              SizedBox(
                                height: Get.height * 0.04,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      dashboardController.editImg =
                                          data['subcategory'][
                                                  dashboardController
                                                      .indexOfDropDown]['Data']
                                              ['ImageUrl'];
                                      dashboardController.assetType =
                                          data['subcategory'][
                                                  dashboardController
                                                      .indexOfDropDown]['Data']
                                              ['AssetType'];
                                      dashboardController.editHeadlineC.text =
                                          data['subcategory'][
                                                  dashboardController
                                                      .indexOfDropDown]['Data']
                                              ['HeadLine'];
                                      dashboardController.editChannelC.text =
                                          data['subcategory'][
                                                  dashboardController
                                                      .indexOfDropDown]['Data']
                                              ['ChannelName'];
                                      dashboardController.editTimeC.text =
                                          data['subcategory'][
                                                  dashboardController
                                                      .indexOfDropDown]['Data']
                                              ['Time'];
                                      dashboardController.editDateC.text =
                                          data['subcategory'][
                                                  dashboardController
                                                      .indexOfDropDown]['Data']
                                              ['Date'];
                                      dashboardController.editCityC.text =
                                          data['subcategory'][
                                                  dashboardController
                                                      .indexOfDropDown]['Data']
                                              ['City'];
                                      dashboardController.editStateC.text =
                                          data['subcategory'][
                                                  dashboardController
                                                      .indexOfDropDown]['Data']
                                              ['State'];
                                      dashboardController.editDesC.text =
                                          data['subcategory'][
                                                  dashboardController
                                                      .indexOfDropDown]['Data']
                                              ['Description'];
                                      dashboardController.editTopicC.text =
                                          data['subcategory'][
                                                  dashboardController
                                                      .indexOfDropDown]['Data']
                                              ['Topic'];
                                      editNewsPopup(
                                        context,
                                        width,
                                        height,
                                        textHeight,
                                        sizingInformation,
                                        'NewsDetail',
                                      );
                                    },
                                    child: Image.asset(
                                      AssetRes.edit,
                                      height:
                                          sizingInformation.isMobile ? 15 : 20,
                                      width:
                                          sizingInformation.isMobile ? 15 : 20,
                                      color: ColorRes.appColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Edit',
                                    style: mediumSf.copyWith(
                                        color: ColorRes.appColor, fontSize: 20),
                                  ),
                                  const SizedBox(
                                    width: 40,
                                  ),
                                  InkWell(
                                    onTap: () {
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  vertical: 10,
                                                  horizontal: 10,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  border: Border.all(
                                                    color: ColorRes.borderColor,
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
                                                                top:
                                                                    Get.height *
                                                                        0.01,
                                                                right:
                                                                    Get.width *
                                                                        0.01),
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
                                                      CircleAvatar(
                                                        maxRadius: width * 0.18,
                                                        backgroundColor:
                                                            Colors.white,
                                                        child: Image.asset(
                                                          "assets/icons/delete_icon.png",
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.06,
                                                      ),
                                                      Text(
                                                        'Are you sure you want to delete ${data['subcategory'][dashboardController.indexOfDropDown]['Data']['HeadLine']} Category?',
                                                        style: TextStyle(
                                                          height: 1.5,
                                                          color: Colors.black
                                                              .withOpacity(0.8),
                                                          fontWeight:
                                                              FontWeight.w900,
                                                          fontSize:
                                                              textHeight * 0.04,
                                                          fontFamily: "sfPro",
                                                        ),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        height: height * 0.04,
                                                      ),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceEvenly,
                                                          children: [
                                                            InkWell(
                                                              onTap: () async {
                                                                await dashboardController
                                                                            .Users
                                                                        .doc(dashboardController
                                                                            .imagedocid)
                                                                    .get()
                                                                    .then(
                                                                        (value) {
                                                                  print(value
                                                                      .data());
                                                                  dashboardController
                                                                          .newsData =
                                                                      value[
                                                                          'subcategory'];
                                                                });

                                                                dashboardController
                                                                    .newsData
                                                                    .removeAt(
                                                                        dashboardController
                                                                            .indexOfDropDown!);
                                                                await dashboardController
                                                                            .Users
                                                                        .doc(dashboardController
                                                                            .imagedocid)
                                                                    .update({
                                                                  'subcategory':
                                                                      dashboardController
                                                                          .newsData,
                                                                });
                                                                dashboardController
                                                                        .isCategory =
                                                                    true;
                                                                dashboardController
                                                                        .isTapCategory =
                                                                    false;
                                                                dashboardController
                                                                        .isNews =
                                                                    false;
                                                                Get.back();
                                                                dashboardController
                                                                    .update([
                                                                  'news'
                                                                ]);
                                                                dashboardController
                                                                    .update([
                                                                  'dash'
                                                                ]);
                                                                dashboardController
                                                                    .update([
                                                                  'category'
                                                                ]);
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
                                                                width:
                                                                    width * 0.6,
                                                                height: height *
                                                                    0.09,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "Yes",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        height *
                                                                            0.035,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                            InkWell(
                                                              onTap: () {
                                                                Get.back();
                                                              },
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: ColorRes
                                                                          .borderColor,
                                                                      width: 1),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                    5,
                                                                  ),
                                                                ),
                                                                width:
                                                                    width * 0.6,
                                                                height: height *
                                                                    0.09,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child: Text(
                                                                  "No",
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        height *
                                                                            0.035,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color: ColorRes
                                                                        .borderColor,
                                                                  ),
                                                                ),
                                                              ),
                                                            )
                                                          ]),
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
                                    child: Image.asset(
                                      AssetRes.delete,
                                      height:
                                          sizingInformation.isMobile ? 15 : 20,
                                      width:
                                          sizingInformation.isMobile ? 15 : 20,
                                      color: ColorRes.appColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Delete',
                                    style: mediumSf.copyWith(
                                        color: ColorRes.appColor, fontSize: 20),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        );
      },
    );
  }
}
