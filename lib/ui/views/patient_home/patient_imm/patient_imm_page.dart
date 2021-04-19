import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:saluddominicana/controllers/controllers.dart';
import 'package:saluddominicana/ui/styled_components/styled_components.dart';

import '../../../../controllers/local/patient_home/patient_imm_controller.dart';
import '../../../../ui/styled_components/app_bar.dart';
import '../../../../ui/styled_components/bottom_navigation_bar.dart';
import '../../../localization.dart';
import 'widgets/dose_options.dart';

class PatientImmPage extends StatelessWidget {
  final controller = Get.put(PatientImmController())!;
  final screenSize = Get.put(ResponsiveCommand())!;

  DataColumn _heading(String title, SizingInformation sizingInformation) =>
      DataColumn(
        label: Container(
          width: Get.width * .1,
          child: Text(
            title,
            textAlign: TextAlign.center,
            style: Get.textTheme.headline6!
                .copyWith(fontSize: screenSize.columnHeader(sizingInformation)),
          ),
        ),
      );

  DataCell doseCell(String dz, int val, SizingInformation sizingInformation) =>
      DataCell(TextButton(
        child: doseOptions(controller.display(dz, val), sizingInformation),
        onPressed: () => showMyDatePicker(
          initialDate: controller.display(dz, val).fold(
                (l) => DateTime.now(),
                (r) => DateTime.parse(r),
              ),
          function: controller.addNew,
          arguments: [dz],
        ),
      ));

  DataRow _getRow(String text, String dz, BuildContext context,
      SizingInformation sizingInformation) {
    controller.agNotDue();
    return DataRow(
      cells: [
        DataCell(
          Container(
            alignment: Alignment.center,
            width: Get.width * .3,
            child: Column(
              children: [
                Expanded(
                  child: Text(
                    text,
                    textAlign: TextAlign.center,
                    style: Get.textTheme.headline6!.copyWith(
                        fontSize: screenSize.rowHeader(sizingInformation),
                        color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
        doseCell(dz, 0, sizingInformation),
        doseCell(dz, 1, sizingInformation),
        doseCell(dz, 2, sizingInformation),
        doseCell(dz, 3, sizingInformation),
        doseCell(dz, 4, sizingInformation),
        doseCell(dz, 5, sizingInformation),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context)!;

    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Container(
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: VigorAppBar(title: labels.medical.immunizations),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4.0),
                MinInfoBanner(
                  name: controller.name(),
                  birthDate: controller.birthDate(),
                ),
                SizedBox(height: Get.height * .03),
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      Container(
                        child: FittedBox(
                          child: Obx(
                            () => controller.isReady()
                                ? DataTable(
                                    showCheckboxColumn: false,
                                    horizontalMargin: 6,
                                    columnSpacing: 2,
                                    dividerThickness: 2,
                                    dataRowHeight: Get.height * .075,
                                    showBottomBorder: true,
                                    columns: [
                                      DataColumn(
                                        label: Container(
                                          width: Get.width * .3,
                                          child: Text(
                                            'Dosis',
                                            textAlign: TextAlign.center,
                                            style: Get.textTheme.headline6!
                                                .copyWith(
                                                    fontSize: Get.width * .05),
                                          ),
                                        ),
                                      ),
                                      _heading('RN', sizingInformation),
                                      _heading('1ra', sizingInformation),
                                      _heading('2da', sizingInformation),
                                      _heading('3ra', sizingInformation),
                                      _heading('1er\nRef', sizingInformation),
                                      _heading('2da\nRef', sizingInformation),
                                    ],
                                    rows: [
                                      _getRow(
                                        'Anti-BCG',
                                        'Tuberculosis',
                                        context,
                                        sizingInformation,
                                      ),
                                      _getRow(
                                        'Anti-Hepatitis B',
                                        'HepB',
                                        context,
                                        sizingInformation,
                                      ),
                                      _getRow(
                                        'Anti-Rotavirus',
                                        'Rotavirus',
                                        context,
                                        sizingInformation,
                                      ),
                                      _getRow(
                                        'Anti-Polio',
                                        'Polio',
                                        context,
                                        sizingInformation,
                                      ),
                                      _getRow(
                                        'Pentavalente\n(DPT/HB/Hib)',
                                        'Pentavalente',
                                        context,
                                        sizingInformation,
                                      ),
                                      _getRow(
                                        'Anti-Neumococo',
                                        'Pneumococcal',
                                        context,
                                        sizingInformation,
                                      ),
                                      _getRow(
                                        'Influenza',
                                        'Influenza',
                                        context,
                                        sizingInformation,
                                      ),
                                      _getRow(
                                        'SRP',
                                        'MMR',
                                        context,
                                        sizingInformation,
                                      ),
                                      _getRow(
                                        'DPT',
                                        'DTP',
                                        context,
                                        sizingInformation,
                                      ),
                                      _getRow(
                                        'SR',
                                        'MR',
                                        context,
                                        sizingInformation,
                                      ),
                                    ],
                                  )
                                : CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.warning,
                          color: Colors.red,
                          size: screenSize.iconSizes(sizingInformation),
                        ),
                        Text('= ${labels.medical.vaccines.due}'),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_rate,
                          color: Colors.yellow,
                          size: screenSize.iconSizes(sizingInformation),
                        ),
                        Text('= ${labels.medical.vaccines.completed}'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          bottomNavigationBar: bottomAppBar(),
        ),
      ),
    );
  }
}
