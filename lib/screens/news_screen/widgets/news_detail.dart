import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_web_app/screens/dashboard_screen/dashboard_controller.dart';
import 'package:news_web_app/screens/news_screen/widgets/delete_popup.dart';
import 'package:news_web_app/screens/news_screen/widgets/edit_news_popup.dart';
import 'package:news_web_app/screens/news_screen/widgets/news_detail_controller.dart';
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
                                  border:
                                      Border.all(color: Colors.white, width: 1),
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
                                                      ? Icon(Icons.pause)
                                                      : Icon(Icons.play_arrow),
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
                                        placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
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
                                      editNewsPopup(context, width, height,
                                          textHeight, sizingInformation);
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
                                      deleteNews(context, width, height,
                                          textHeight, sizingInformation);
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
