import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:task_verify_link/pages/tab_page/controller/tab_controller.dart';
import 'package:task_verify_link/utils/app_color.dart';
import 'package:task_verify_link/utils/app_textstyle.dart';

class DomainBottomSheetWidget extends StatelessWidget {
  const DomainBottomSheetWidget({super.key,this.updateIndex});

  final int? updateIndex;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * .75,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: primaryColor.withOpacity(.4),
          blurRadius: 10,
          spreadRadius: 5,
          offset: const Offset(0, 3),
        )
      ], color: Colors.white, borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: GetBuilder<TabViewController>(builder: (c) {
        return Form(
          key: c.formKey,
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
                child: Text(
                  "Title : ${c.customTitleController.text}",
                  style: AppTextStyle.semiBold20(Colors.black),
                ),
              ),
              Divider(
                color: primaryColor.withOpacity(.5),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0, left: 16),
                child: Text(
                  "Enter website URL:",
                  style: AppTextStyle.medium12(Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Obx(
                  () => TextFormField(
                    controller: c.urlController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    maxLength: 25,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: primaryColor),
                          gapPadding: 0),
                      suffixIcon: c.isValidUrl.value
                          ? const Icon(
                              Icons.check_circle,
                              color: primaryColor,
                            )
                          : null,
                    ),
                    onChanged: (value) {
                      c.deBounce.call(() {
                        c.isValidURL(value);
                      });
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter URL";
                      } else if (!c.isValidUrl.value) {
                        return "Please enter valid URL";
                      }
                      return null;
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16,top: 4),
                child: Text(
                  "Custom title (optional):",
                  style: AppTextStyle.medium12(Colors.black),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextFormField(
                  controller: c.customTitleController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 10),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5),
                          borderSide: const BorderSide(color: primaryColor),
                          gapPadding: 0)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: () {
                      if(updateIndex != null) {
                        c.updateRecord(updateIndex!);
                      } else {
                        if (c.recodeList.length >= 3) {
                          Get.snackbar("Alert", "You can't add more than 3 links",
                              backgroundColor: Colors.red, colorText: Colors.white);
                        } else {
                          c.saveLink();
                        }
                      }
                    },
                    child: Container(
                      height: 40,
                      width: 153,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(8)),
                      child: Text("Save",
                          style: AppTextStyle.semiBold16(Colors.white)),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
