import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class DashboardController extends GetxController {
  // Darshil category sub category

  VideoPlayerController? VideoCntrl;
  VideoPlayerController? DetailVideo;

  List delete = ['Yes', 'No'];

  var newsId;
  bool isVideo = false;
  bool isLoading = false;

  bool islogout = false;
  List subCategories = [];
  var docId;
  var categoryData;
  int? subIndex;
  var imagedocid;
  String? url;

  int? delete1;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  //Add news
  CollectionReference Users =
      FirebaseFirestore.instance.collection('categories');
  FirebaseStorage storage = FirebaseStorage.instance;

  var id;

  // Show news

  int? showNewsIndex;

  // News category

  int? indexOfDropDown;

  List newsData = [];
  bool obSecure = true;
  TextEditingController categoryController = TextEditingController();
  TextEditingController subCategoryController = TextEditingController();
  TextEditingController editCategoryController = TextEditingController();
  TextEditingController addHeadLineController = TextEditingController();
  TextEditingController channelController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController desController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController editHeadlineC = TextEditingController();
  TextEditingController editChannelC = TextEditingController();
  TextEditingController editDateC = TextEditingController();
  TextEditingController editTimeC = TextEditingController();
  TextEditingController editCityC = TextEditingController();
  TextEditingController editStateC = TextEditingController();
  TextEditingController editTopicC = TextEditingController();
  TextEditingController editDesC = TextEditingController();

  bool isCategory = true;
  bool isNews = false;
  bool isLogout = false;
  bool isTapCategory = false;
  bool isNewsAdded = false;
  bool isNewsCategory = true;
  bool isNewsDetail = false;
  bool subCNews = false;

  int selectedIndex = 0;

  List categoryList = ["1", "2"];
  int idindex = 0;
  String? editImg = '';
  String? assetType = '';
  String? headline = '';
  String? channel = '';
  String? date = '';
  String? time = '';
  String? state = '';
  String? city = '';
  String? topic = '';
  String? description = '';

  PlatformFile? imageFile;
  var image;
  List<Uint8List> imagesPath = [];
  var type;
  Uint8List? imageData;
  Uint8List? newsImage;
  FilePickerResult? result;

  List? dropValue = List.generate(26, (index) => 'Male');

  List<dynamic> dropItems = [];

  dropOnChange(String? value, int? index) {
    dropValue![index!] = value!;
    isNewsDetail = true;
    update(["dash"]);
    update(["news"]);
  }

  bool loadImg = false;
  Future<void> pickImage(var dialogue) async {
    try {
      loadImg = true;
      dialogue.call(() {});
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: ['jpg', 'png', 'webp', 'jpeg', 'mp4'],
      );

      if (result == null) return;

      image = result?.files.toString();
      imageData = result!.files.first.bytes;
      type = result!.files.first.extension;
      imageFile = result!.files.first;
      result!.files.forEach((element) {
        if (element.extension == 'jpg' ||
            element.extension == 'png' ||
            element.extension == 'jpeg' ||
            element.extension == 'webp' ||
            element.extension == 'mp4') {
          imagesPath.add(element.bytes!);
          loadImg = false;
          dialogue.call(() {});
        }
      });
      update(['dash']);
    } catch (e) {
      print("Eror----> $e");
    }
  }
}
