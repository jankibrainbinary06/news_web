// ignore_for_file: avoid_print, avoid_function_literals_in_foreach_calls

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_web_app/common/text_styles.dart';
import 'package:news_web_app/screens/dashboard_screen/dashboard_controller.dart';
import 'package:news_web_app/screens/news_screen/widgets/edit_news_popup.dart';
import 'package:news_web_app/screens/news_screen/widgets/news_detail.dart';
import 'package:news_web_app/utils/assets_res.dart';
import 'package:news_web_app/utils/color_res.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import '../../demo.dart';
import '../../utils/string_res.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    DashboardController dashboardController = Get.put(DashboardController());
    var selectedItem = '';
    double width = 0;
    double height = 0;
    double textHeight = 0;
    double border = 0;
    bool isMobile = false;
    int selectedIndex = 0;
    bool upload = false;

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
        }
        return StreamBuilder(
          stream: dashboardController.Users.orderBy("DateTime").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              dashboardController.dropItems.clear();

              snapshot.data!.docs.forEach((element) {
                dashboardController.dropItems.add({
                  "category": element['category'],
                  "subCategory": element['subcategory'],
                });
              });
              void _toggleVideo() {
                if (dashboardController.DetailVideo!.value.isPlaying) {
                  dashboardController.DetailVideo!.pause();
                } else {
                  dashboardController.DetailVideo!.play();
                }
              }

              return Container(
                margin: EdgeInsets.only(
                  top: height * 0.062,
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
                  physics: const NeverScrollableScrollPhysics(),
                  child: GetBuilder<DashboardController>(
                    id: 'news',
                    builder: (controller) {
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: dashboardController.isNewsAdded
                                  ? Get.height * 0.06
                                  : sizingInformation.isMobile
                                      ? Get.height * 0.02
                                      : Get.height * 0.097,
                            ),
                            Visibility(
                              visible: Get.width <= 818,
                              child: GestureDetector(
                                onTap: () {
                                  dashboardController.scaffoldKey.currentState
                                      ?.openDrawer();
                                },
                                child: Container(
                                  height: sizingInformation.isDesktop ? 50 : 40,
                                  width: width * 0.7,
                                  decoration: BoxDecoration(
                                    color: ColorRes.appColor,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                            dashboardController.isNewsAdded
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          dashboardController
                                                  .editHeadlineC.text =
                                              dashboardController.headline!;
                                          dashboardController
                                                  .editChannelC.text =
                                              dashboardController.channel!;
                                          dashboardController.editTimeC.text =
                                              dashboardController.time!;
                                          dashboardController.editDateC.text =
                                              dashboardController.date!;
                                          dashboardController.editCityC.text =
                                              dashboardController.city!;
                                          dashboardController.editStateC.text =
                                              dashboardController.state!;
                                          dashboardController.editDesC.text =
                                              dashboardController.description!;
                                          dashboardController.editTopicC.text =
                                              dashboardController.topic!;

                                          editNewsPopup(context, width, height,
                                              textHeight, sizingInformation);
                                        },
                                        child: Image.asset(
                                          AssetRes.edit,
                                          height: sizingInformation.isMobile
                                              ? 15
                                              : 20,
                                          width: sizingInformation.isMobile
                                              ? 15
                                              : 20,
                                          color: ColorRes.appColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Edit',
                                        style: mediumSf.copyWith(
                                            color: ColorRes.appColor,
                                            fontSize: 20),
                                      ),
                                      const SizedBox(
                                        width: 30,
                                      ),
                                      GestureDetector(
                                        onTap: () {},
                                        child: Image.asset(
                                          AssetRes.delete,
                                          height: sizingInformation.isMobile
                                              ? 15
                                              : 20,
                                          width: sizingInformation.isMobile
                                              ? 15
                                              : 20,
                                          color: ColorRes.appColor,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Delete',
                                        style: mediumSf.copyWith(
                                            color: ColorRes.appColor,
                                            fontSize: 20),
                                      ),
                                    ],
                                  )
                                : const SizedBox(),
                            SizedBox(
                              height: dashboardController.isNewsAdded
                                  ? Get.height * 0.02
                                  : Get.height * 0.02,
                            ),
                            dashboardController.isNewsDetail == false
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: width * 0.3),
                                    alignment: Alignment.center,
                                    height: Get.height * 0.8,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: BoxDecoration(
                                        gradient:
                                            (dashboardController.isNewsAdded ==
                                                        false &&
                                                    dashboardController
                                                            .isNewsCategory ==
                                                        false)
                                                ? const LinearGradient(
                                                    colors: [
                                                      ColorRes.menuBarWhite,
                                                      ColorRes.menuBar
                                                    ],
                                                    begin: AlignmentDirectional
                                                        .topCenter,
                                                    end: AlignmentDirectional
                                                        .bottomCenter,
                                                  )
                                                : const LinearGradient(colors: [
                                                    Colors.white,
                                                    Colors.white
                                                  ]),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            width: 2,
                                            color: ColorRes.appColor)),
                                    child: dashboardController.isNewsCategory
                                        ? dashboardController.isLoading
                                            ? const Center(
                                                child:
                                                    CircularProgressIndicator())
                                            : Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: Get.height * 0.04,
                                                  ),
                                                  Text(
                                                    Strings.news,
                                                    style: poppinsBold.copyWith(
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        fontSize: 28,
                                                        fontFamily:
                                                            'poppinsSemiBold'),
                                                  ),
                                                  SizedBox(
                                                    height: Get.height * 0.04,
                                                  ),
                                                  Expanded(
                                                    child:
                                                        SingleChildScrollView(
                                                      child: GridView.builder(
                                                        physics:
                                                            const BouncingScrollPhysics(),
                                                        shrinkWrap: true,
                                                        itemCount:
                                                            dashboardController
                                                                .dropItems
                                                                .length,
                                                        gridDelegate:
                                                            SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount:
                                                              sizingInformation
                                                                      .isMobile
                                                                  ? 1
                                                                  : 2,
                                                          mainAxisExtent:
                                                              sizingInformation
                                                                      .isMobile
                                                                  ? 60
                                                                  : 80,
                                                        ),
                                                        itemBuilder:
                                                            (context, y) {
                                                          return Container(
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                    horizontal:
                                                                        width *
                                                                            0.01),
                                                            margin: EdgeInsets.symmetric(
                                                                horizontal: sizingInformation
                                                                        .isMobile
                                                                    ? width *
                                                                        0.1
                                                                    : width *
                                                                        0.25,
                                                                vertical: sizingInformation
                                                                        .isMobile
                                                                    ? height *
                                                                        0.015
                                                                    : height *
                                                                        0.02),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          5),
                                                              border: Border.all(
                                                                  color: ColorRes
                                                                      .borderColor),
                                                            ),
                                                            height: Get.height *
                                                                0.07,
                                                            child:
                                                                DropdownButtonHideUnderline(
                                                              child:
                                                                  DropdownButton(
                                                                hint: Row(
                                                                  children: [
                                                                    const Spacer(),
                                                                    Text(
                                                                      dashboardController
                                                                          .dropItems[
                                                                              y]
                                                                              [
                                                                              'category']
                                                                          .toString(),
                                                                      style: const TextStyle(
                                                                          fontSize:
                                                                              18,
                                                                          fontWeight: FontWeight
                                                                              .normal,
                                                                          color:
                                                                              Colors.black),
                                                                    ),
                                                                    const Spacer(),
                                                                  ],
                                                                ),
                                                                onTap: () {
                                                                  dashboardController
                                                                      .showNewsIndex = y;

                                                                  dashboardController
                                                                          .imagedocid =
                                                                      snapshot
                                                                          .data!
                                                                          .docs[
                                                                              dashboardController.showNewsIndex!]
                                                                          .id;

                                                                  dashboardController
                                                                      .update([
                                                                    'dash'
                                                                  ]);
                                                                  dashboardController
                                                                      .update([
                                                                    'news'
                                                                  ]);
                                                                },
                                                                isExpanded:
                                                                    true,
                                                                dropdownColor:
                                                                    Colors
                                                                        .white,
                                                                focusColor: ColorRes
                                                                    .newsbgtextfield,
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                icon:
                                                                    const Padding(
                                                                  padding: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              10),
                                                                  child: Icon(
                                                                      Icons
                                                                          .keyboard_arrow_down_outlined,
                                                                      color: Colors
                                                                          .black,
                                                                      size: 20),
                                                                ),
                                                                elevation: 16,
                                                                onChanged:
                                                                    (value) {
                                                                  print(value);
                                                                  dashboardController
                                                                          .isNewsDetail =
                                                                      true;

                                                                  print(
                                                                      "------>DropIndex${dashboardController.indexOfDropDown}");

                                                                  dashboardController
                                                                      .update([
                                                                    'news'
                                                                  ]);
                                                                  dashboardController
                                                                      .update([
                                                                    'dash'
                                                                  ]);
                                                                },
                                                                items: List
                                                                    .generate(
                                                                  dashboardController
                                                                      .dropItems[
                                                                          y][
                                                                          'subCategory']
                                                                      .length,
                                                                  (index) =>
                                                                      DropdownMenuItem(
                                                                    value: dashboardController.dropItems[y]
                                                                            [
                                                                            'subCategory']
                                                                        [index],
                                                                    onTap: () {
                                                                      print(dashboardController
                                                                          .dropItems);
                                                                      dashboardController
                                                                          .dropItems
                                                                          .forEach(
                                                                        (element) {
                                                                          element['subCategory']
                                                                              .forEach(
                                                                            (e) {
                                                                              if (e == dashboardController.dropItems[y]['subCategory'][index]) {
                                                                                dashboardController.indexOfDropDown = element['subCategory'].indexOf(e);
                                                                              }
                                                                            },
                                                                          );
                                                                        },
                                                                      );
                                                                    },
                                                                    child: Text(dashboardController
                                                                        .dropItems[
                                                                            y][
                                                                            'subCategory']
                                                                            [
                                                                            index]
                                                                            [
                                                                            'Name']
                                                                        .toString()), // Convert the dynamic item to a string
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              )
                                        : dashboardController.isNewsAdded
                                            ? SingleChildScrollView(
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: width * 0.2,
                                                      vertical: height * 0.05),
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                        dashboardController
                                                            .headline!,
                                                        style:
                                                            mediumSf.copyWith(
                                                                fontSize: 27,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.035,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Text(
                                                            dashboardController
                                                                .channel!,
                                                            style: mediumSf
                                                                .copyWith(
                                                                    fontSize:
                                                                        20),
                                                          ),
                                                          const Spacer(),
                                                          Text(
                                                            "${dashboardController.city!},",
                                                            style: mediumSf
                                                                .copyWith(
                                                                    fontSize:
                                                                        20),
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          Text(
                                                            dashboardController
                                                                .date!,
                                                            style: mediumSf
                                                                .copyWith(
                                                                    fontSize:
                                                                        20),
                                                          ),
                                                          Text(
                                                            dashboardController
                                                                .time!,
                                                            style: mediumSf
                                                                .copyWith(
                                                                    fontSize:
                                                                        20),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.035,
                                                      ),
                                                      dashboardController
                                                                  .newsImage ==
                                                              null
                                                          ? const SizedBox()
                                                          : Container(
                                                              height:
                                                                  height * 0.5,
                                                              margin: EdgeInsets
                                                                  .symmetric(
                                                                      horizontal:
                                                                          width *
                                                                              0.2),
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                  5,
                                                                ),
                                                                // border: Border.all(
                                                                //     color: ColorRes
                                                                //         .newsborder,
                                                                //     width: 1),
                                                              ),
                                                              child: ClipRRect(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            5),
                                                                child: dashboardController
                                                                            .result!
                                                                            .files
                                                                            .first
                                                                            .extension !=
                                                                        'mp4'
                                                                    ? Image
                                                                        .memory(
                                                                        Uint8List
                                                                            .fromList(
                                                                          dashboardController
                                                                              .newsImage!,
                                                                        ),
                                                                        // width: width *
                                                                        //     25,
                                                                        height: sizingInformation.isDesktop
                                                                            ? height *
                                                                                0.5
                                                                            : height *
                                                                                0.34,
                                                                        fit: BoxFit
                                                                            .cover,
                                                                      )
                                                                    : Stack(
                                                                        children: [
                                                                          VideoPlayer(
                                                                              dashboardController.DetailVideo!),
                                                                          Center(
                                                                            child:
                                                                                InkWell(
                                                                              onTap: () {
                                                                                _toggleVideo();
                                                                                dashboardController.update([
                                                                                  'news'
                                                                                ]);
                                                                              },
                                                                              child: CircleAvatar(
                                                                                maxRadius: 20,
                                                                                child: dashboardController.DetailVideo!.value.isPlaying
                                                                                    ? const Icon(Icons.pause)
                                                                                    : const Icon(
                                                                                        Icons.play_arrow,
                                                                                      ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                              ),
                                                            ),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.025,
                                                      ),
                                                      Text(
                                                        dashboardController
                                                            .topic!,
                                                        style:
                                                            mediumSf.copyWith(
                                                                fontSize: 32,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                      ),
                                                      SizedBox(
                                                        height:
                                                            Get.height * 0.025,
                                                      ),
                                                      Text(
                                                        dashboardController
                                                            .description!,
                                                        style:
                                                            mediumSf.copyWith(
                                                                fontSize: 22,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      GestureDetector(
                                                        onTap: () async {
                                                          dashboardController
                                                              .isLoading = true;
                                                          dashboardController
                                                              .update(['news']);
                                                          dashboardController
                                                                  .isNewsCategory =
                                                              true;
                                                          dashboardController
                                                                  .isNewsAdded =
                                                              false;
                                                          final SharedPreferences
                                                              prefs =
                                                              await SharedPreferences
                                                                  .getInstance();
                                                          final String? action =
                                                              prefs.getString(
                                                                  'DocumentId');

                                                          final String?
                                                              subcategory =
                                                              prefs.getString(
                                                                  'subcategory');

                                                          print(
                                                              "DOC ID-------------->$action");

                                                          await dashboardController
                                                              .storage
                                                              .ref(
                                                                  "NewsImage/${DateTime.now().millisecond}.png")
                                                              .putData(
                                                                  dashboardController
                                                                      .imageData!)
                                                              .then((p0) async {
                                                            dashboardController
                                                                    .url =
                                                                await p0.ref
                                                                    .getDownloadURL();
                                                            dashboardController
                                                                .update(
                                                                    ['news']);
                                                            print(
                                                                'URL ${dashboardController.url}');
                                                          });

                                                          await dashboardController
                                                                      .Users
                                                                  .doc(action)
                                                              .get()
                                                              .then((value) {
                                                            print(value.data());
                                                            dashboardController
                                                                    .newsData =
                                                                value[
                                                                    'subcategory'];
                                                            dashboardController
                                                                .update(
                                                                    ['news']);
                                                          });

                                                          print(subcategory);
                                                          print(
                                                              dashboardController
                                                                  .subIndex);

                                                          dashboardController
                                                                      .subIndex ==
                                                                  null
                                                              ? dashboardController
                                                                  .newsData
                                                                  .removeAt(0)
                                                              : dashboardController
                                                                  .newsData
                                                                  .removeAt(
                                                                      dashboardController
                                                                          .subIndex!);

                                                          print(
                                                              dashboardController
                                                                  .newsData);

                                                          dashboardController.newsData.insert(
                                                              dashboardController
                                                                          .subIndex ==
                                                                      null
                                                                  ? 0
                                                                  : dashboardController
                                                                      .subIndex!,
                                                              {
                                                                "Name":
                                                                    subcategory,
                                                                "Data": {
                                                                  "HeadLine":
                                                                      dashboardController
                                                                          .headline,
                                                                  "ChannelName":
                                                                      dashboardController
                                                                          .channel,
                                                                  "Date":
                                                                      dashboardController
                                                                          .date,
                                                                  "Time":
                                                                      dashboardController
                                                                          .time,
                                                                  "State":
                                                                      dashboardController
                                                                          .state,
                                                                  "City":
                                                                      dashboardController
                                                                          .city,
                                                                  "Topic":
                                                                      dashboardController
                                                                          .topic,
                                                                  "Description":
                                                                      dashboardController
                                                                          .description,
                                                                  "ImageUrl":
                                                                      dashboardController
                                                                          .url,
                                                                  "AssetType":
                                                                      dashboardController
                                                                          .type,
                                                                }
                                                              });

                                                          print(
                                                              "${dashboardController.newsData}");

                                                          await dashboardController
                                                                      .Users
                                                                  .doc(action)
                                                              .update({
                                                            'subcategory':
                                                                dashboardController
                                                                    .newsData,
                                                          });
                                                          dashboardController
                                                                  .isLoading =
                                                              false;
                                                          dashboardController
                                                              .update(['dash']);
                                                          dashboardController
                                                              .update(['news']);
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
                                                          width: width * 0.7,
                                                          height: height * 0.08,
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            "Upload",
                                                            style: TextStyle(
                                                                fontSize:
                                                                    height *
                                                                        0.03,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            : GestureDetector(
                                                onTap: () {
                                                  showDialog(
                                                    context: context,
                                                    builder: (context) {
                                                      return StatefulBuilder(
                                                        builder: (context,
                                                            updateDialog) {
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
                                                                // height: height * 0.55,
                                                                width: sizingInformation
                                                                        .isMobile
                                                                    ? width * 3
                                                                    : width * 2,
                                                                padding: EdgeInsets
                                                                    .symmetric(
                                                                  vertical: 10,
                                                                  horizontal:
                                                                      sizingInformation
                                                                              .isMobile
                                                                          ? 5
                                                                          : 10,
                                                                ),
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: Colors
                                                                      .white,
                                                                  border: Border
                                                                      .all(
                                                                    color: ColorRes
                                                                        .newsborder,
                                                                    width: 1,
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
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      const SizedBox(
                                                                        height:
                                                                            2,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          GestureDetector(
                                                                            child:
                                                                                Icon(
                                                                              Icons.close,
                                                                              color: Colors.black.withOpacity(0.8),
                                                                              size: 20,
                                                                            ),
                                                                            onTap:
                                                                                () {
                                                                              Get.back();
                                                                            },
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      Text(
                                                                        'Add News detail',
                                                                        style: TextStyle(
                                                                            height:
                                                                                1.5,
                                                                            color: Colors.black.withOpacity(
                                                                                0.8),
                                                                            fontWeight: FontWeight
                                                                                .w600,
                                                                            fontSize: textHeight *
                                                                                0.04,
                                                                            fontFamily:
                                                                                "sfPro",
                                                                            letterSpacing:
                                                                                2),
                                                                      ),
                                                                      SizedBox(
                                                                        height: Get.height *
                                                                            0.008,
                                                                      ),
                                                                      Container(
                                                                        height:
                                                                            1,
                                                                        width: width *
                                                                            0.8,
                                                                        color: ColorRes
                                                                            .appColor,
                                                                      ),
                                                                      SizedBox(
                                                                        height: Get.height *
                                                                            0.04,
                                                                      ),
                                                                      Column(
                                                                        crossAxisAlignment:
                                                                            CrossAxisAlignment.center,
                                                                        children: [
                                                                          SizedBox(
                                                                            height:
                                                                                Get.height * 0.02,
                                                                          ),
                                                                          dashboardController.imageData == null
                                                                              ? GestureDetector(
                                                                                  onTap: () async {
                                                                                    await dashboardController.pickImage(updateDialog);
                                                                                    updateDialog.call(() {});
                                                                                  },
                                                                                  child: dashboardController.loadImg == true
                                                                                      ? SizedBox(height: height * 0.2, child: const Center(child: CircularProgressIndicator()))
                                                                                      : Container(
                                                                                          padding: EdgeInsets.symmetric(horizontal: width * 0.4, vertical: width * 0.2),
                                                                                          decoration: BoxDecoration(
                                                                                              borderRadius: BorderRadius.circular(
                                                                                                6,
                                                                                              ),
                                                                                              color: ColorRes.newsbgtextfield,
                                                                                              border: Border.all(width: 1, color: ColorRes.newsborder)),
                                                                                          child: Stack(
                                                                                            alignment: Alignment.center,
                                                                                            children: [
                                                                                              Image.asset(
                                                                                                AssetRes.imagePicker,
                                                                                                height: height * 0.08,
                                                                                                width: height * 0.1,
                                                                                              ),
                                                                                              Stack(
                                                                                                alignment: Alignment.bottomRight,
                                                                                                children: [
                                                                                                  Container(
                                                                                                    // color: Colors.red,
                                                                                                    height: height * 0.1,
                                                                                                    width: height * 0.1,
                                                                                                  ),
                                                                                                  Container(
                                                                                                    height: width * 0.08,
                                                                                                    width: width * 0.08,
                                                                                                    decoration: const BoxDecoration(
                                                                                                      color: Color(0xff55A1FF),
                                                                                                      shape: BoxShape.circle,
                                                                                                    ),
                                                                                                    alignment: Alignment.center,
                                                                                                    child: Wrap(
                                                                                                      children: [
                                                                                                        Icon(
                                                                                                          Icons.add,
                                                                                                          color: Colors.white,
                                                                                                          size: width * 0.04,
                                                                                                        ),
                                                                                                      ],
                                                                                                    ),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                )
                                                                              : Container(
                                                                                  decoration: BoxDecoration(
                                                                                    borderRadius: BorderRadius.circular(
                                                                                      6,
                                                                                    ),
                                                                                    border: Border.all(color: Colors.white, width: 1),
                                                                                  ),
                                                                                  child: ClipRRect(
                                                                                    borderRadius: BorderRadius.circular(
                                                                                      10,
                                                                                    ),
                                                                                    child: dashboardController.result!.files.first.extension != 'mp4'
                                                                                        ? Image.memory(
                                                                                            Uint8List.fromList(dashboardController.imageData!),
                                                                                            width: width * 0.85,
                                                                                            height: sizingInformation.isDesktop ? height * 0.24 : height * 0.14,
                                                                                            fit: BoxFit.cover,
                                                                                          )
                                                                                        : Image.asset(AssetRes.videoThumbnail),
                                                                                  ),
                                                                                ),
                                                                          const SizedBox(),
                                                                          SizedBox(
                                                                            height:
                                                                                height * 0.03,
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                height * 0.08,
                                                                            width: sizingInformation.isMobile
                                                                                ? width * 1.7
                                                                                : width * 1.3,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: ColorRes.newsbgtextfield,
                                                                              borderRadius: BorderRadius.circular(
                                                                                4,
                                                                              ),
                                                                              border: Border.all(color: ColorRes.newsborder, width: 1),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: TextField(
                                                                                controller: dashboardController.addHeadLineController,
                                                                                style: TextStyle(
                                                                                  fontFamily: "sfPro",
                                                                                  color: Colors.black.withOpacity(0.8),
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                                decoration: InputDecoration(
                                                                                  border: InputBorder.none,
                                                                                  contentPadding: EdgeInsets.only(
                                                                                    left: width * 0.08,
                                                                                    bottom: height * 0.01,
                                                                                  ),
                                                                                  hintStyle: const TextStyle(
                                                                                    fontFamily: "sfPro",
                                                                                    fontSize: 20,
                                                                                    color: ColorRes.newsText,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                  hintText: 'Add Headline',
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                height * 0.03,
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                height * 0.08,
                                                                            width: sizingInformation.isMobile
                                                                                ? width * 1.7
                                                                                : width * 1.3,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: ColorRes.newsbgtextfield,
                                                                              borderRadius: BorderRadius.circular(
                                                                                4,
                                                                              ),
                                                                              border: Border.all(color: ColorRes.newsborder, width: border),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: TextField(
                                                                                controller: dashboardController.channelController,
                                                                                style: TextStyle(
                                                                                  fontFamily: "sfPro",
                                                                                  color: Colors.black.withOpacity(0.8),
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                                decoration: InputDecoration(
                                                                                  border: InputBorder.none,
                                                                                  contentPadding: EdgeInsets.only(
                                                                                    left: width * 0.08,
                                                                                    bottom: height * 0.01,
                                                                                  ),
                                                                                  hintStyle: const TextStyle(
                                                                                    fontSize: 20,
                                                                                    fontFamily: "sfPro",
                                                                                    color: ColorRes.newsText,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                  hintText: 'Add your channel name',
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                height * 0.03,
                                                                          ),
                                                                          Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            children: [
                                                                              Container(
                                                                                height: height * 0.08,
                                                                                width: sizingInformation.isMobile ? width * 0.8 : width * 0.6,
                                                                                decoration: BoxDecoration(
                                                                                  color: ColorRes.newsbgtextfield,
                                                                                  borderRadius: BorderRadius.circular(
                                                                                    5,
                                                                                  ),
                                                                                  border: Border.all(color: ColorRes.newsborder, width: 1),
                                                                                ),
                                                                                child: Center(
                                                                                  child: TextField(
                                                                                    controller: dashboardController.dateController,
                                                                                    style: TextStyle(
                                                                                      fontFamily: "sfPro",
                                                                                      color: Colors.black.withOpacity(0.8),
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                    decoration: InputDecoration(
                                                                                      border: InputBorder.none,
                                                                                      contentPadding: EdgeInsets.only(
                                                                                        left: width * 0.08,
                                                                                        bottom: height * 0.01,
                                                                                      ),
                                                                                      hintStyle: TextStyle(
                                                                                        fontSize: 20,
                                                                                        fontFamily: "sfPro",
                                                                                        color: Colors.black.withOpacity(0.6),
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                      hintText: 'Add date',
                                                                                    ),
                                                                                    onTap: () async {
                                                                                      DateTime? pickedDate = await showDatePicker(
                                                                                        context: context,
                                                                                        initialDate: DateTime.now(),
                                                                                        firstDate: DateTime(1950),
                                                                                        lastDate: DateTime(2100),
                                                                                      );

                                                                                      if (pickedDate != null) {
                                                                                        print(pickedDate);
                                                                                        String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                                                                        print(formattedDate);

                                                                                        dashboardController.dateController.text = formattedDate;
                                                                                        dashboardController.update(['dash']);
                                                                                        dashboardController.update(['news']);
                                                                                      } else {}
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              SizedBox(width: width * 0.12),
                                                                              Container(
                                                                                height: height * 0.08,
                                                                                width: sizingInformation.isMobile ? width * 0.75 : width * 0.6,
                                                                                decoration: BoxDecoration(
                                                                                  color: ColorRes.newsbgtextfield,
                                                                                  borderRadius: BorderRadius.circular(
                                                                                    5,
                                                                                  ),
                                                                                  border: Border.all(color: ColorRes.newsborder, width: 1),
                                                                                ),
                                                                                child: Center(
                                                                                  child: TextField(
                                                                                    controller: dashboardController.timeController,
                                                                                    style: TextStyle(
                                                                                      fontFamily: "sfPro",
                                                                                      color: Colors.black.withOpacity(0.8),
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                    decoration: InputDecoration(
                                                                                      border: InputBorder.none,
                                                                                      contentPadding: EdgeInsets.only(
                                                                                        left: width * 0.08,
                                                                                        bottom: height * 0.01,
                                                                                      ),
                                                                                      hintStyle: const TextStyle(
                                                                                        fontFamily: "sfPro",
                                                                                        fontSize: 20,
                                                                                        color: ColorRes.newsText,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                      hintText: 'Add Time',
                                                                                    ),
                                                                                    onTap: () async {
                                                                                      TimeOfDay? pickedTime = await showTimePicker(
                                                                                        initialTime: TimeOfDay.now(),
                                                                                        context: context,
                                                                                      );

                                                                                      if (pickedTime != null) {
                                                                                        String formattedTime = pickedTime.format(context);
                                                                                        print(formattedTime);
                                                                                        dashboardController.timeController.text = formattedTime;
                                                                                        dashboardController.update(['dash']);
                                                                                        dashboardController.update(['news']);
                                                                                      } else {
                                                                                        print("Time is not selected");
                                                                                      }
                                                                                    },
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                height * 0.03,
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                height * 0.08,
                                                                            width: sizingInformation.isMobile
                                                                                ? width * 1.7
                                                                                : width * 1.3,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: ColorRes.newsbgtextfield,
                                                                              borderRadius: BorderRadius.circular(
                                                                                5,
                                                                              ),
                                                                              border: Border.all(color: ColorRes.newsborder, width: 1),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: TextField(
                                                                                controller: dashboardController.stateController,
                                                                                style: TextStyle(
                                                                                  fontFamily: "sfPro",
                                                                                  color: Colors.black.withOpacity(0.8),
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                                decoration: InputDecoration(
                                                                                  border: InputBorder.none,
                                                                                  contentPadding: EdgeInsets.only(
                                                                                    left: width * 0.08,
                                                                                    bottom: height * 0.01,
                                                                                  ),
                                                                                  hintStyle: const TextStyle(
                                                                                    fontSize: 20,
                                                                                    fontFamily: "sfPro",
                                                                                    color: ColorRes.newsText,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                  hintText: 'Add which state....',
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                height * 0.03,
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                height * 0.08,
                                                                            width: sizingInformation.isMobile
                                                                                ? width * 1.7
                                                                                : width * 1.3,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: ColorRes.newsbgtextfield,
                                                                              borderRadius: BorderRadius.circular(
                                                                                5,
                                                                              ),
                                                                              border: Border.all(color: ColorRes.newsborder, width: 1),
                                                                            ),
                                                                            child:
                                                                                Center(
                                                                              child: TextField(
                                                                                controller: dashboardController.cityController,
                                                                                style: TextStyle(
                                                                                  fontFamily: "sfPro",
                                                                                  color: Colors.black.withOpacity(0.8),
                                                                                  fontWeight: FontWeight.w500,
                                                                                ),
                                                                                decoration: InputDecoration(
                                                                                  border: InputBorder.none,
                                                                                  contentPadding: EdgeInsets.only(
                                                                                    left: width * 0.08,
                                                                                    bottom: height * 0.01,
                                                                                  ),
                                                                                  hintStyle: const TextStyle(
                                                                                    fontSize: 20,
                                                                                    fontFamily: "sfPro",
                                                                                    color: ColorRes.newsText,
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                  hintText: 'Add which city...',
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                          SizedBox(
                                                                            height:
                                                                                height * 0.03,
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                height * 0.3,
                                                                            width: sizingInformation.isMobile
                                                                                ? width * 1.7
                                                                                : width * 1.3,
                                                                            decoration:
                                                                                BoxDecoration(
                                                                              color: ColorRes.newsbgtextfield,
                                                                              borderRadius: BorderRadius.circular(
                                                                                5,
                                                                              ),
                                                                              border: Border.all(color: ColorRes.newsborder, width: 1),
                                                                            ),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                TextField(
                                                                                  controller: dashboardController.topicController,
                                                                                  style: TextStyle(
                                                                                    fontFamily: "sfPro",
                                                                                    color: Colors.black.withOpacity(0.8),
                                                                                    fontWeight: FontWeight.w500,
                                                                                  ),
                                                                                  decoration: InputDecoration(
                                                                                    border: InputBorder.none,
                                                                                    contentPadding: EdgeInsets.only(
                                                                                      left: width * 0.08,
                                                                                      bottom: height * 0.01,
                                                                                    ),
                                                                                    hintStyle: const TextStyle(
                                                                                      fontFamily: "sfPro",
                                                                                      fontSize: 20,
                                                                                      color: ColorRes.newsText,
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                    hintText: 'Add Topic...',
                                                                                  ),
                                                                                ),
                                                                                Container(
                                                                                  margin: const EdgeInsets.symmetric(horizontal: 10),
                                                                                  height: height * 0.2,
                                                                                  width: sizingInformation.isMobile ? width * 1.7 : width * 1.3,
                                                                                  decoration: BoxDecoration(
                                                                                    color: Colors.white,
                                                                                    border: Border.all(color: ColorRes.newsborder, width: 1),
                                                                                  ),
                                                                                  child: TextField(
                                                                                    maxLines: 6,
                                                                                    controller: dashboardController.desController,
                                                                                    style: TextStyle(
                                                                                      fontFamily: "sfPro",
                                                                                      color: Colors.black.withOpacity(0.8),
                                                                                      fontWeight: FontWeight.w500,
                                                                                    ),
                                                                                    decoration: InputDecoration(
                                                                                      border: InputBorder.none,
                                                                                      contentPadding: EdgeInsets.only(
                                                                                        left: width * 0.02,
                                                                                        top: height * 0.01,
                                                                                        bottom: 5,
                                                                                      ),
                                                                                      hintStyle: const TextStyle(
                                                                                        fontFamily: "sfPro",
                                                                                        fontSize: 18,
                                                                                        color: ColorRes.newsText,
                                                                                        fontWeight: FontWeight.w500,
                                                                                      ),
                                                                                      hintText: 'Add description here..',
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: Get.height *
                                                                            0.05,
                                                                      ),
                                                                      GestureDetector(
                                                                        onTap:
                                                                            () async {
                                                                          if (dashboardController.addHeadLineController.text.isNotEmpty &&
                                                                              dashboardController.channelController.text.isNotEmpty &&
                                                                              dashboardController.cityController.text.isNotEmpty &&
                                                                              dashboardController.dateController.text.isNotEmpty &&
                                                                              dashboardController.timeController.text.isNotEmpty &&
                                                                              dashboardController.topicController.text.isNotEmpty &&
                                                                              dashboardController.desController.text.isNotEmpty &&
                                                                              dashboardController.imageData != null) {
                                                                            dashboardController.isNewsAdded =
                                                                                true;
                                                                            dashboardController.headline =
                                                                                dashboardController.addHeadLineController.text;
                                                                            dashboardController.channel =
                                                                                dashboardController.channelController.text;
                                                                            dashboardController.state =
                                                                                dashboardController.stateController.text;
                                                                            dashboardController.city =
                                                                                dashboardController.cityController.text;
                                                                            dashboardController.date =
                                                                                dashboardController.dateController.text;
                                                                            dashboardController.time =
                                                                                dashboardController.timeController.text;
                                                                            dashboardController.topic =
                                                                                dashboardController.topicController.text;
                                                                            dashboardController.description =
                                                                                dashboardController.desController.text;
                                                                            dashboardController.newsImage =
                                                                                dashboardController.imageData;

                                                                            upload =
                                                                                true;
                                                                            updateDialog.call(() {});
                                                                            await dashboardController.storage.ref("NewsImage/${DateTime.now().millisecond}.png").putData(dashboardController.imageData!).then((p0) async {
                                                                              dashboardController.url = await p0.ref.getDownloadURL();
                                                                              dashboardController.update([
                                                                                'news'
                                                                              ]);
                                                                              print('URL ${dashboardController.url}');
                                                                            });
                                                                            dashboardController.DetailVideo = VideoPlayerController.network("${dashboardController.url}")
                                                                              ..initialize().then((_) {});

                                                                            upload =
                                                                                false;
                                                                            updateDialog.call(() {});
                                                                            Get.back();
                                                                            dashboardController.update([
                                                                              'dash'
                                                                            ]);
                                                                            dashboardController.update([
                                                                              'news'
                                                                            ]);
                                                                          } else {
                                                                            Get.snackbar(
                                                                                backgroundColor: Colors.black,
                                                                                colorText: Colors.white,
                                                                                'Error',
                                                                                'Please enter all fields');
                                                                          }

                                                                          dashboardController
                                                                              .update([
                                                                            'dash'
                                                                          ]);
                                                                          dashboardController
                                                                              .update([
                                                                            'news'
                                                                          ]);
                                                                        },
                                                                        child: upload
                                                                            ? const Center(child: CircularProgressIndicator())
                                                                            : Container(
                                                                                decoration: BoxDecoration(
                                                                                  color: ColorRes.appColor,
                                                                                  borderRadius: BorderRadius.circular(
                                                                                    5,
                                                                                  ),
                                                                                ),
                                                                                width: width * 0.8,
                                                                                height: height * 0.08,
                                                                                alignment: Alignment.center,
                                                                                child: Text(
                                                                                  "Next",
                                                                                  style: TextStyle(fontSize: height * 0.035, fontWeight: FontWeight.w600, color: Colors.white),
                                                                                ),
                                                                              ),
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
                                                  );
                                                },
                                                child: Container(
                                                  height: sizingInformation
                                                          .isDesktop
                                                      ? 50
                                                      : 40,
                                                  width: width * 0.7,
                                                  decoration: BoxDecoration(
                                                      color: ColorRes.appColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5)),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontFamily: 'sfPro',
                                                            color:
                                                                Colors.white),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                  )
                                : const NewsDetail(),
                          ],
                        ),
                      );
                    },
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
  }
}
