import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:news_web_app/screens/dashboard_screen/dashboard_controller.dart';
import 'package:news_web_app/utils/assets_res.dart';
import 'package:video_player/video_player.dart';

import '../../../Services/Shared_pref_services/pref_service.dart';
import '../../../utils/color_res.dart';

DashboardController dashboardController = Get.put(DashboardController());
editNewsPopup(
  BuildContext context,
  double width,
  double height,
  double textHeight,
  var sizingInformation,
  var from,
) {
  return showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, updateDialog) {
          updateDialog.call(() {});
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: Dialog(
              backgroundColor: Colors.transparent,
              child: Container(
                // height: height * 0.55,
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
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 2,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            child: Icon(
                              Icons.close,
                              color: Colors.black.withOpacity(0.8),
                              size: 20,
                            ),
                            onTap: () {
                              Get.back();
                            },
                          ),
                        ],
                      ),
                      Text(
                        'Edit News detail',
                        style: TextStyle(
                            height: 1.5,
                            color: Colors.black.withOpacity(0.8),
                            fontWeight: FontWeight.w600,
                            fontSize: textHeight * 0.04,
                            fontFamily: "sfPro",
                            letterSpacing: 2),
                      ),
                      SizedBox(
                        height: Get.height * 0.008,
                      ),
                      Container(
                        height: 1,
                        width: width * 0.8,
                        color: ColorRes.appColor,
                      ),
                      SizedBox(
                        height: Get.height * 0.04,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: Get.height * 0.02,
                          ),
                          Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  border: Border.all(
                                      color: ColorRes.newsborder, width: 1),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                    10,
                                  ),
                                  child: dashboardController.type == 'mp4'
                                      ? SizedBox(
                                          height: height * 0.3,
                                          width: width * 1,
                                          child: Image.asset(
                                            fit: BoxFit.fill,
                                            AssetRes.videoThumbnail,
                                          ),
                                        )
                                      : dashboardController.editImg!.isNotEmpty
                                          ? SizedBox(
                                              height: height * 0.3,
                                              width: width * 1,
                                              child: Image.network(
                                                fit: BoxFit.fill,
                                                dashboardController.editImg!,
                                              ),
                                            )
                                          : Image.memory(
                                              Uint8List.fromList(
                                                  dashboardController
                                                      .imageData!),
                                              width: width * 0.9,
                                              height:
                                                  sizingInformation.isDesktop
                                                      ? height * 0.24
                                                      : height * 0.14,
                                              fit: BoxFit.cover,
                                            ),
                                ),
                              ),
                              Positioned(
                                right: -5,
                                bottom: -5,
                                child: InkWell(
                                  onTap: () async {
                                    await dashboardController
                                        .pickImage(updateDialog);
                                    if (from == 'NewsDetail') {
                                      await dashboardController.storage
                                          .ref(
                                              "NewsImage/${DateTime.now().millisecond}.png")
                                          .putData(
                                              dashboardController.imageData!)
                                          .then((p0) async {
                                        dashboardController.editImg =
                                            await p0.ref.getDownloadURL();
                                        print(
                                            'URL ${dashboardController.editImg}');
                                      });
                                      // dashboardController.editImg = "";
                                    }
                                    updateDialog.call(() {});
                                  },
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        color: Colors.white),
                                    child: Image.asset(
                                      AssetRes.edit,
                                      height: 20,
                                      width: 20,
                                      color: Colors.black.withOpacity(0.8),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Container(
                            width: width * 1.3,
                            decoration: BoxDecoration(
                              color: ColorRes.newsbgtextfield,
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                              border: Border.all(
                                  color: ColorRes.newsborder, width: 1),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  width: width * 1.15,
                                  child: Center(
                                    child: TextField(
                                      maxLines: 2,
                                      controller:
                                          dashboardController.editHeadlineC,
                                      style: TextStyle(
                                        fontFamily: "sfPro",
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                          top: height * 0.03,
                                          left: width * 0.05,
                                          bottom: height * 0.03,
                                        ),
                                        hintStyle: const TextStyle(
                                          fontFamily: "sfPro",
                                          color: ColorRes.newsText,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        hintText: 'Add Headline',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    child: Image.asset(
                                  AssetRes.edit,
                                  height: 20,
                                  width: 20,
                                  color: Colors.black.withOpacity(0.8),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Container(
                            width: width * 1.3,
                            decoration: BoxDecoration(
                              color: ColorRes.newsbgtextfield,
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                              border: Border.all(
                                  color: ColorRes.newsborder, width: 1),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width * 1.15,
                                  child: Center(
                                    child: TextField(
                                      controller:
                                          dashboardController.editChannelC,
                                      style: TextStyle(
                                        fontFamily: "sfPro",
                                        color: Colors.black.withOpacity(0.8),
                                        fontWeight: FontWeight.w500,
                                      ),
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        contentPadding: EdgeInsets.only(
                                          top: height * 0.03,
                                          left: width * 0.05,
                                          bottom: height * 0.03,
                                        ),
                                        hintStyle: const TextStyle(
                                          fontFamily: "sfPro",
                                          color: ColorRes.newsText,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        hintText: 'Add Your Channel name',
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    child: Image.asset(
                                  AssetRes.edit,
                                  height: 20,
                                  width: 20,
                                  color: Colors.black.withOpacity(0.8),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: width * 0.6,
                                decoration: BoxDecoration(
                                  color: ColorRes.newsbgtextfield,
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  border: Border.all(
                                      color: ColorRes.newsborder, width: 1),
                                ),
                                child: TextField(
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(1950),
                                        lastDate: DateTime(2100));

                                    if (pickedDate != null) {
                                      print(pickedDate);
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      print(formattedDate);

                                      dashboardController.editDateC.text =
                                          formattedDate;
                                      dashboardController.update(['dash']);
                                    } else {}
                                  },
                                  controller: dashboardController.editDateC,
                                  style: TextStyle(
                                    fontFamily: "sfPro",
                                    color: Colors.black.withOpacity(0.8),
                                    fontWeight: FontWeight.w500,
                                  ),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.only(
                                      top: height * 0.03,
                                      left: width * 0.05,
                                      bottom: height * 0.03,
                                    ),
                                    hintStyle: const TextStyle(
                                        fontFamily: "sfPro",
                                        color: ColorRes.newsText),
                                    hintText: 'Add date',
                                  ),
                                ),
                              ),
                              SizedBox(width: width * 0.1),
                              Container(
                                width: width * 0.6,
                                decoration: BoxDecoration(
                                  color: ColorRes.newsbgtextfield,
                                  borderRadius: BorderRadius.circular(
                                    5,
                                  ),
                                  border: Border.all(
                                      color: ColorRes.newsborder, width: 1),
                                ),
                                child: Center(
                                  child: TextField(
                                    onTap: () async {
                                      TimeOfDay? pickedTime =
                                          await showTimePicker(
                                        initialTime: TimeOfDay.now(),
                                        context: context,
                                      );

                                      if (pickedTime != null) {
                                        String formattedTime =
                                            pickedTime.format(context);
                                        print(formattedTime);
                                        dashboardController.editTimeC.text =
                                            formattedTime;
                                        dashboardController.update(['dash']);
                                      } else {
                                        print("Time is not selected");
                                      }
                                    },
                                    controller: dashboardController.editTimeC,
                                    style: TextStyle(
                                      fontFamily: "sfPro",
                                      color: Colors.black.withOpacity(0.8),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                        top: height * 0.03,
                                        left: width * 0.05,
                                        bottom: height * 0.03,
                                      ),
                                      hintStyle: const TextStyle(
                                        fontFamily: "sfPro",
                                        color: ColorRes.newsText,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hintText: 'Add Time',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Container(
                            width: width * 1.3,
                            decoration: BoxDecoration(
                              color: ColorRes.newsbgtextfield,
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                              border: Border.all(
                                  color: ColorRes.newsborder, width: 1),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width * 1.15,
                                  child: TextField(
                                    controller: dashboardController.editStateC,
                                    style: TextStyle(
                                      fontFamily: "sfPro",
                                      color: Colors.black.withOpacity(0.8),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                        top: height * 0.03,
                                        left: width * 0.05,
                                        bottom: height * 0.03,
                                      ),
                                      hintStyle: const TextStyle(
                                        fontFamily: "sfPro",
                                        color: ColorRes.newsText,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hintText: 'Add which state....',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    child: Image.asset(
                                  AssetRes.edit,
                                  height: 20,
                                  width: 20,
                                  color: Colors.black.withOpacity(0.8),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Container(
                            width: width * 1.3,
                            decoration: BoxDecoration(
                              color: ColorRes.newsbgtextfield,
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                              border: Border.all(
                                  color: ColorRes.newsborder, width: 1),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width * 1.15,
                                  child: TextField(
                                    controller: dashboardController.editCityC,
                                    style: TextStyle(
                                      fontFamily: "sfPro",
                                      color: Colors.black.withOpacity(0.8),
                                      fontWeight: FontWeight.w500,
                                    ),
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: EdgeInsets.only(
                                        top: height * 0.03,
                                        left: width * 0.05,
                                        bottom: height * 0.03,
                                      ),
                                      hintStyle: const TextStyle(
                                        fontFamily: "sfPro",
                                        color: ColorRes.newsText,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      hintText: 'Add which city...',
                                    ),
                                  ),
                                ),
                                SizedBox(
                                    child: Image.asset(
                                  AssetRes.edit,
                                  height: 20,
                                  width: 20,
                                  color: Colors.black.withOpacity(0.8),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.03,
                          ),
                          Container(
                            height: height * 0.3,
                            width: width * 1.3,
                            decoration: BoxDecoration(
                              color: ColorRes.newsbgtextfield,
                              borderRadius: BorderRadius.circular(
                                5,
                              ),
                              border: Border.all(
                                  color: ColorRes.newsborder, width: 1),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: width * 1.15,
                                      child: TextField(
                                        controller:
                                            dashboardController.editTopicC,
                                        style: TextStyle(
                                          fontFamily: "sfPro",
                                          color: Colors.black.withOpacity(0.8),
                                          fontWeight: FontWeight.w500,
                                        ),
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          contentPadding: EdgeInsets.only(
                                            left: width * 0.08,
                                            bottom: height * 0.023,
                                          ),
                                          hintStyle: const TextStyle(
                                            fontFamily: "sfPro",
                                            color: ColorRes.newsText,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          hintText: 'Add Topic...',
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        child: Image.asset(
                                      AssetRes.edit,
                                      height: 20,
                                      width: 20,
                                      color: Colors.black.withOpacity(0.8),
                                    )),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  padding: const EdgeInsets.all(10),
                                  height: height * 0.15,
                                  width: width * 1.3,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      5,
                                    ),
                                    border: Border.all(
                                        color: ColorRes.newsborder, width: 1),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: width * 0.94,
                                        child: TextField(
                                          maxLines: 10,
                                          controller:
                                              dashboardController.editDesC,
                                          style: TextStyle(
                                            fontFamily: "sfPro",
                                            color:
                                                Colors.black.withOpacity(0.8),
                                            fontWeight: FontWeight.w500,
                                          ),
                                          decoration: InputDecoration(
                                            border: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                              left: width * 0.08,
                                              bottom: height * 0.023,
                                            ),
                                            hintStyle: const TextStyle(
                                              fontFamily: "sfPro",
                                              color: ColorRes.newsText,
                                              fontWeight: FontWeight.w500,
                                            ),
                                            hintText: 'Add description here..',
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                          child: Image.asset(
                                        AssetRes.edit,
                                        height: 20,
                                        width: 20,
                                        color: Colors.black.withOpacity(0.8),
                                      )),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: Get.height * 0.05,
                      ),
                      GestureDetector(
                        onTap: () async {
                          dashboardController.headline =
                              dashboardController.editHeadlineC.text;
                          dashboardController.description =
                              dashboardController.editDesC.text;
                          dashboardController.time =
                              dashboardController.editTimeC.text;
                          dashboardController.topic =
                              dashboardController.editTopicC.text;
                          dashboardController.date =
                              dashboardController.editDateC.text;
                          dashboardController.state =
                              dashboardController.editStateC.text;
                          dashboardController.city =
                              dashboardController.editCityC.text;
                          dashboardController.channel =
                              dashboardController.editChannelC.text;
                          dashboardController.newsImage =
                              dashboardController.imageData;

                          if (from == 'NewsDetail') {
                            final String subcategory =
                                PrefService.getString('subcategory');

                            await dashboardController.Users.doc(
                                    dashboardController.imagedocid)
                                .get()
                                .then((value) {
                              print(value.data());
                              dashboardController.newsData =
                                  value['subcategory'];
                            });
                            await dashboardController.storage
                                .ref(
                                    "NewsImage/${DateTime.now().millisecond}.png")
                                .putData(dashboardController.imageData!)
                                .then(
                              (p0) async {
                                dashboardController.editImg =
                                    await p0.ref.getDownloadURL();
                                print('URL ${dashboardController.editImg}');
                              },
                            );

                            dashboardController.newsData
                                .removeAt(dashboardController.indexOfDropDown!);
                            dashboardController.newsData
                                .insert(dashboardController.indexOfDropDown!, {
                              "Name": subcategory,
                              "Data": {
                                "HeadLine": dashboardController.headline,
                                "ChannelName": dashboardController.channel,
                                "Date": dashboardController.date,
                                "Time": dashboardController.time,
                                "State": dashboardController.state,
                                "City": dashboardController.city,
                                "Topic": dashboardController.topic,
                                "Description": dashboardController.description,
                                "ImageUrl": dashboardController.editImg,
                                "AssetType": dashboardController.assetType,
                              }
                            });

                            print("${dashboardController.newsData}");

                            await dashboardController.Users.doc(
                                    dashboardController.imagedocid)
                                .update({
                              'subcategory': dashboardController.newsData,
                            });
                          }

                          Get.back();
                          dashboardController.update(['dash']);
                          dashboardController.update(['news']);
                          dashboardController.update(['detailscreen']);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: ColorRes.appColor,
                            borderRadius: BorderRadius.circular(
                              5,
                            ),
                          ),
                          width: width * 0.7,
                          height: height * 0.07,
                          alignment: Alignment.center,
                          child: Text(
                            "Done",
                            style: TextStyle(
                                fontSize: height * 0.025,
                                fontWeight: FontWeight.w600,
                                color: Colors.white),
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
  );
}
