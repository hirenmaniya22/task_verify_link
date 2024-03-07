import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_verify_link/models/links_record_model.dart';
import 'package:task_verify_link/pages/tab_page/controller/tab_controller.dart';
import 'package:task_verify_link/utils/app_color.dart';
import 'package:task_verify_link/utils/app_textstyle.dart';

import 'domain_bottomsheet_widget.dart';

class LinkItemWidget extends StatelessWidget {
  LinkItemWidget({super.key, required this.recodeList, required this.index});

  final LinksRecordModel recodeList;
  final int index;
  final controller = Get.find<TabViewController>();

  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: primaryColor,
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: ListTile(
        leading: Image.asset(
          recodeList.imagePath,
          height: 40,
          width: 40,
        ),
        title: Text(recodeList.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.medium18(Colors.black)),
        subtitle: Text(recodeList.url,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.regular14(Colors.black)),
        trailing: InkWell(
            onTap: () {
              controller.urlController.text = recodeList.url;
              controller.customTitleController.text = recodeList.title;
              controller.isValidUrl.value = true;
              Get.bottomSheet(
                  isScrollControlled: true,
                  enableDrag: true,
                  backgroundColor: Colors.white,
                  DomainBottomSheetWidget(
                    updateIndex: index,
                  ));
            },
            child: const Icon(Icons.edit,size: 22,)),
      ),
    );
  }
}
