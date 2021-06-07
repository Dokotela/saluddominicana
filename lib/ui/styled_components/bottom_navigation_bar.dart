import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../localization.dart';
import '../views/views.dart';

BottomNavigationBar bottomAppBar(
    {Function? backFunction, Function? homeFunction}) {
  final labels = AppLocalizations.of(Get.context!)!;
  return BottomNavigationBar(
    selectedFontSize: Get.width * Get.height * 0.000045,
    unselectedFontSize: Get.width * Get.height * 0.000045,
    items: [
      BottomNavigationBarItem(
        icon: Icon(
          Icons.arrow_back,
          color: Get.theme.colorScheme.onPrimary,
          size: Get.width * Get.height * 0.00012,
        ),
        label: labels.actions.back,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Get.theme.colorScheme.onPrimary,
          size: Get.width * Get.height * 0.00012,
        ),
        label: labels.actions.home,
      ),
      BottomNavigationBarItem(
        icon: Icon(
          Icons.exit_to_app,
          color: Get.theme.colorScheme.onPrimary,
          size: Get.width * Get.height * 0.00012,
        ),
        label: labels.actions.logout,
      ),
    ],
    onTap: (index) => index == 0
        ? backFunction == null
            ? Get.back()
            : backFunction()
        : index == 1
            ? homeFunction ?? Get.offAll<Widget>(HomePage())
            : Get.offAll<Widget>(LoginPage()),
  );
}
