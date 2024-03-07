import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_workers/utils/debouncer.dart';
import 'package:task_verify_link/local_db/hive_database_helper.dart';
import 'package:task_verify_link/models/links_record_model.dart';
import 'package:task_verify_link/utils/image_path.dart';

class TabViewController extends GetxController {
  int tabIndex = 0;

  final deBounce = Debouncer(delay: const Duration(milliseconds: 500));
  final formKey = GlobalKey<FormState>();

  TextEditingController urlController = TextEditingController();
  TextEditingController customTitleController = TextEditingController();

  List<LinksRecordModel> recodeList = [];
  RxBool isValidUrl = false.obs;

  void changeTabIndex(int index) {
    tabIndex = index;
    update();
  }


  @override
  onInit() {
    super.onInit();
    getData();
  }

  getData() async {
    recodeList = await HiveDatabase.getAllRecords();
    update();
  }

  isValidURL(String url) {
    print("url: $url");
    isValidUrl.value = false;
    // Regular expression to match URL format
    final RegExp urlRegExp = RegExp(
      r'(http|https)://[\w-]+(\.[\w-]+)+([\w.,@?^=%&amp;:/~+#-]*[\w@?^=%&amp;/~+#-])?',
      caseSensitive: false,
      multiLine: false,
    );
    isValidUrl.value = urlRegExp.hasMatch(url);
  }

  getImagePath() {
    if (customTitleController.text.toLowerCase().contains("facebook")) {
      return ImagePath.facebookIcon;
    } else if (customTitleController.text.toLowerCase().contains("instagram")) {
      return ImagePath.instagramIcon;
    } else if (customTitleController.text.toLowerCase().contains("twitter")) {
      return ImagePath.twitterIcon;
    } else {
      return ImagePath.defaultPersonIcon;
    }
  }

  updateRecord(int recordKey) {
    HiveDatabase.updateRecord(recordKey, {
      recordKey : {
        'imagePath': getImagePath(),
        'title': customTitleController.text,
        'url': urlController.text,
      },
    });
    getData();
    Get.back();
  }

  saveLink() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (customTitleController.text.isEmpty) {
        customTitleController.text = Uri.parse(urlController.text).host ?? '';
      }
      HiveDatabase.insertRecord({
        recodeList.length : {
          'imagePath': getImagePath(),
          'title': customTitleController.text,
          'url': urlController.text,
        },
      });
      getData();
      Get.back();
    }
  }
}
