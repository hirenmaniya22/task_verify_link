import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:task_verify_link/pages/tab_page/view/widget/domain_bottomsheet_widget.dart';
import 'package:task_verify_link/utils/app_color.dart';
import 'package:task_verify_link/utils/app_textstyle.dart';

import '../controller/tab_controller.dart';
import 'widget/link_item_widget.dart';

class TabView extends GetView<TabViewController> {
  const TabView({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TabViewController>(
      builder: (c) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            title: const Padding(
              padding: EdgeInsets.only(left: 4.0),
              child: Text(
                'Verify link',
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              controller.urlController.clear();
              controller.customTitleController.clear();
              controller.isValidUrl.value = false;
              Get.bottomSheet(
                  isScrollControlled: true,
                  enableDrag: true,
                  backgroundColor: Colors.white,
                  const DomainBottomSheetWidget());
            },
            backgroundColor: primaryColor,
            child: const Icon(Icons.add, color: Colors.white),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: primaryColor),
                      borderRadius: BorderRadius.circular(8)),
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () => controller.changeTabIndex(0),
                          child: AnimatedContainer(
                            alignment: Alignment.center,
                            duration: const Duration(milliseconds: 500),
                            decoration: BoxDecoration(
                                color: controller.tabIndex == 0
                                    ? primaryColor
                                    : null,
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5))),
                            child: Text(
                              'Empty',
                              style: TextStyle(
                                color: controller.tabIndex == 0
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => controller.changeTabIndex(1),
                          child: AnimatedContainer(
                            alignment: Alignment.center,
                            duration: const Duration(milliseconds: 500),
                            decoration: BoxDecoration(
                                color: controller.tabIndex == 1
                                    ? primaryColor
                                    : null,
                                borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(5),
                                    topRight: Radius.circular(5))),
                            child: Text(
                              'Links',
                              style: TextStyle(
                                color: controller.tabIndex == 1
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                IndexedStack(
                  index: controller.tabIndex,
                  children: [
                    Center(
                      child: Text(
                        'Empty Screen',
                        style: AppTextStyle.medium14(Colors.black),
                      ),
                    ),
                    controller.recodeList.isEmpty
                        ? Center(
                            child: Text(
                              "No record added.",
                              style: AppTextStyle.medium14(Colors.black),
                            ),
                          )
                        : ListView.builder(
                            shrinkWrap: true,
                            itemCount: controller.recodeList.length,
                            itemBuilder: (context, index) {
                              return LinkItemWidget(
                                recodeList: controller.recodeList[index],
                                index: index,
                              );
                            },
                          ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
