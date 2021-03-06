import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/local/patient_home/patient_home_controller.dart';
import '../../../ui/styled_components/app_bar.dart';
import '../../../ui/styled_components/bottom_navigation_bar.dart';
import '../../../ui/styled_components/info_banner.dart';
import '../../localization.dart';
import '../views.dart';

class PatientHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context)!;
    final PatientHomeController controller = Get.put(PatientHomeController());

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: VigorAppBar(title: labels.pages.patientHome),
      body: Container(
        constraints: const BoxConstraints.expand(),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InfoBannerWidget(
                name: controller.name(),
                id: controller.id(),
                birthDate: controller.birthDate(),
                relativeAge: controller.relativeAge(),
                sex: controller.sex(),
                primaryContact: controller.primaryContact(),
              ),
              PatientImmPage(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: bottomAppBar(),
    );
  }
}
