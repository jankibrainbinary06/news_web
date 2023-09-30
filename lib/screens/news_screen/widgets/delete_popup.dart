import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_web_app/screens/news_screen/widgets/edit_news_popup.dart';

import '../../../utils/assets_res.dart';
import '../../../utils/color_res.dart';

deleteNews(BuildContext context , double width, double height, double textHeight,var sizingInformation,){
  return              showDialog(
    context: context,
    builder: (context) {
      return BackdropFilter(
        filter:
        ImageFilter.blur(
            sigmaX: 2,
            sigmaY: 2),
        child: Dialog(
          backgroundColor:
          Colors
              .transparent,
          child: Container(
            height:
            height * 0.5,
            width: width * 2,
            padding:
            const EdgeInsets
                .symmetric(
              vertical: 10,
              horizontal: 10,
            ),
            decoration:
            BoxDecoration(
              color:
              Colors.white,
              border:
              Border.all(
                color: ColorRes
                    .appColor,
                width: 1,
              ),
              borderRadius:
              BorderRadius
                  .circular(
                5,
              ),
            ),
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
                    GestureDetector(
                      child:
                      Icon(
                        Icons
                            .close,
                        color: Colors
                            .black
                            .withOpacity(0.8),
                        size:
                        20,
                      ),
                      onTap:
                          () {
                        Get.back();
                      },
                    ),
                  ],
                ),
                Stack(
                  alignment:
                  Alignment
                      .center,
                  children: [
                    Container(
                      height:
                      height *
                          0.13,
                      width: height *
                          0.13,
                      decoration:
                      BoxDecoration(
                        color: ColorRes
                            .appColor
                            .withOpacity(0.3),
                        shape: BoxShape
                            .circle,
                      ),
                    ),
                    Image.asset(
                      AssetRes
                          .delete,
                      height:
                      height *
                          0.08,
                      width: height *
                          0.08,
                      fit: BoxFit
                          .fill,
                      color: ColorRes
                          .appColor,
                    ),
                  ],
                ),
                SizedBox(
                  height:
                  Get.height *
                      0.02,
                ),
                Text(
                  'Are you sure want to delete  Category?',
                  style:
                  TextStyle(
                    height: 1.5,
                    color: Colors
                        .black
                        .withOpacity(
                        0.8),
                    fontWeight:
                    FontWeight
                        .w500,
                    fontSize:
                    textHeight *
                        0.04,
                    fontFamily:
                    "sfPro",
                  ),
                  textAlign:
                  TextAlign
                      .center,
                ),
                SizedBox(
                  height:
                  Get.height *
                      0.03,
                ),
                GestureDetector(
                  onTap: () {
dashboardController.isNewsDetail = false;
dashboardController.update(['dash']);
Get.back();
                  },
                  child:
                  Container(
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
                    width *
                        0.7,
                    height:
                    height *
                        0.06,
                    alignment:
                    Alignment
                        .center,
                    child: Text(
                      "Delete",
                      style:
                      TextStyle(
                        fontSize:
                        height *
                            0.025,
                        fontWeight:
                        FontWeight.w600,
                        color: Colors
                            .white,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height:
                  height *
                      0.02,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}