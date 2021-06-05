import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/controllers.dart';
import '../../../../controllers/local/new_patient/new_patient_controller.dart';
import '../../../../ui/styled_components/styled_components.dart';
import '../../../../ui/views/new_patient/widgets/layout.dart';
import '../../../localization.dart';
import '../../../styled_components/app_bar.dart';
import '../../../styled_components/bottom_navigation_bar.dart';
import '../widgets/birthDate.dart';
import '../widgets/drop_down_selection.dart';
import '../widgets/names.dart';

class NewPatientPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context)!;
    final controller = Get.put(NewPatientController());
    ResponsiveCommand screenSize = Get.find();
    SizedBox _sizedBox(double size) =>
        SizedBox(height: screenSize.height * size);

    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: VigorAppBar(
            title: controller.newPatient
                ? labels.pages.newPatient
                : labels.pages.patientInformation),
        body: SafeArea(
          minimum: EdgeInsets.all(5),
          child: Container(
            child: Center(
              child: Container(
                width: Get.width * .8,
                child: Obx(
                  () => Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /// reusable widget for entering first and last names, is
                      /// passed 2 text controllers, and the error messages for each
                      NamesInputWidget(
                        familyName: controller.familyName,
                        givenName: controller.givenName,
                        familyNameError: controller.familyNameError,
                        givenNameError: controller.givenNameError,
                      ),

                      /// reusable widget for entering gender at birth, is passed a
                      /// boolean (true = female, false = male), and then the
                      /// controller function to change it
                      DropDownSelection(
                        title: labels.gender.title,
                        selectionList: controller.genderTypes,
                        display: controller.gender,
                        selectNew: controller.setGender,
                        error: controller.genderError,
                      ),

                      /// reusable widget for entering birthdate, arguments are
                      /// controller function to choose birthdate, the current
                      /// birthdate, the birthdate as a String, and then an error
                      /// message
                      BirthDateWidget(
                        birthDate: controller.birthDate,
                        chooseBirthDate: controller.chooseBirthDate,
                        displayBirthDate: controller.displayBirthDate,
                        dispBirthDateError: controller.birthDateError,
                      ),

                      Layout(
                        [
                          Text(
                            'Contacto Primario',
                            style: Get.theme.textTheme.bodyText1!
                                .copyWith(fontSize: Get.width * .04),
                          ),
                          TextButton(
                            onPressed: () => controller.editContacts(),
                            child: Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.primaryFamilyMember,
                                    style: Get.theme.textTheme.bodyText1!
                                        .copyWith(fontSize: Get.width * .05),
                                    textAlign: TextAlign.end,
                                  ),
                                  Icon(Icons.keyboard_arrow_down,
                                      color: Colors.black),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),

                      _sizedBox(.02),

                      /// reusable widget for selecting neighborhood, includes the
                      /// list of neighborhoods, which one to display, the event
                      /// to change it, and the error message
                      DropDownSelection(
                        title: labels.address.neighborhood.title,
                        selectionList: controller.barriosList,
                        display: controller.barrio,
                        selectNew: controller.selectBarrio,
                        error: controller.barrioError,
                      ),

                      /// button to register patient
                      ThinActionButton(
                        buttonText: labels.actions.save,
                        onPressed: () async {
                          print('save button');
                          final saveAttempt = await controller.save();
                          saveAttempt.fold(
                            (l) => Get.snackbar('Error', l.error),
                            (r) => controller.completeRegistration(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: bottomAppBar(),
      ),
    );
  }
}
