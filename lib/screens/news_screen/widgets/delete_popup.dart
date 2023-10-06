import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/color_res.dart';
import 'edit_news_popup.dart';

deleteNews(
  BuildContext context,
  double width,
  double height,
  double textHeight,
  var sizingInformation,
  var name,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
        child: Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: height * 0.6,
            width: width * 2,
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: ColorRes.borderColor,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(
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
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: Get.height * 0.01, right: Get.width * 0.01),
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
                    maxRadius: width * 0.18,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      "assets/icons/delete_icon.png",
                    ),
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  Text(
                    'Are you sure you want to delete ${name} Category?',
                    style: TextStyle(
                      height: 1.5,
                      color: Colors.black.withOpacity(0.8),
                      fontWeight: FontWeight.w900,
                      fontSize: textHeight * 0.04,
                      fontFamily: "sfPro",
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: height * 0.04,
                  ),
                  GestureDetector(
                    onTap: () async {},
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () async {
                              await dashboardController.Users.doc(
                                      dashboardController.imagedocid)
                                  .get()
                                  .then((value) {
                                print(value.data());
                                dashboardController.newsData =
                                    value['subcategory'];
                              });

                              dashboardController.newsData.removeAt(
                                  dashboardController.indexOfDropDown!);
                              await dashboardController.Users.doc(
                                      dashboardController.imagedocid)
                                  .update({
                                'subcategory': dashboardController.newsData,
                              });
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
                                border: Border.all(
                                    color: ColorRes.borderColor, width: 1),
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
}
