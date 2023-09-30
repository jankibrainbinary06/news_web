import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_web_app/screens/news_screen/widgets/delete_popup.dart';
import 'package:news_web_app/screens/news_screen/widgets/edit_news_popup.dart';
import 'package:news_web_app/screens/news_screen/widgets/news_detail_controller.dart';
import 'package:responsive_builder/responsive_builder.dart';

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
    NewsDetailController newsDetailController = Get.put(NewsDetailController());

    final FirebaseStorage storage = FirebaseStorage.instance;
    String? imageUrl; // This will store the image URL once retrieved.

    Future<void> getImageFromFirebaseStorage() async {
      try {
        final Reference ref = storage.ref().child(
            'NewsImage/3Rvtw7tW8tUgBxNlRylo.png'); // Replace 'your_image.jpg' with your image's path.
        final String downloadUrl = await ref.getDownloadURL();
      } catch (e) {
        print('Error retrieving image: $e');
      }
    }

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

              // dashboardController.newsId = snapshot.data[]

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
                child: Container(
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
                      border:
                          Border.all(width: 2, color: ColorRes.borderColor)),
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
                          margin: EdgeInsets.symmetric(horizontal: width * 0.3),
                          decoration: BoxDecoration(
                            image: const DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(AssetRes.imagePicker),
                            ),
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                            border: Border.all(color: Colors.white, width: 1),
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
                          "${data['subcategory'][dashboardController.indexOfDropDown]['Data']['Description'] ?? "No Data"}",
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
                                height: sizingInformation.isMobile ? 15 : 20,
                                width: sizingInformation.isMobile ? 15 : 20,
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
                                deleteNews(context, width, height, textHeight,
                                    sizingInformation);
                              },
                              child: Image.asset(
                                AssetRes.delete,
                                height: sizingInformation.isMobile ? 15 : 20,
                                width: sizingInformation.isMobile ? 15 : 20,
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
                ),
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
