import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saluddominicana/controllers/controllers.dart';

import '../../../../controllers/local/patient_home/patient_imm_controller.dart';
import '../../../localization.dart';
import 'widgets/dose_options.dart';

class PatientImmPage extends StatelessWidget {
  final controller = Get.put(PatientImmController())!;

  TableRow _getRow(String text, String dz) {
    controller.agNotDue();
    var size = Get.height * Get.width * .00012;
    return TableRow(
      children: [
        Container(height: size, child: Text(text, textAlign: TextAlign.center)),
        Container(height: size, child: doseOptions(dz, 0)),
        Container(height: size, child: doseOptions(dz, 1)),
        Container(height: size, child: doseOptions(dz, 2)),
        Container(height: size, child: doseOptions(dz, 3)),
        Container(height: size, child: doseOptions(dz, 4)),
        Container(height: size, child: doseOptions(dz, 5)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context)!;

    return Obx(
      () => !controller.isReady()
          ? Text('loading')
          : Column(
              children: [
                Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  columnWidths: const {0: FractionColumnWidth(0.3)},
                  border: TableBorder.all(width: 0.5, color: Colors.black),
                  children: [
                    const TableRow(children: [
                      Text('Dosis', textAlign: TextAlign.center),
                      Text('RN', textAlign: TextAlign.center),
                      Text('1ra', textAlign: TextAlign.center),
                      Text('2da', textAlign: TextAlign.center),
                      Text('3ra', textAlign: TextAlign.center),
                      Text('1er\nRef', textAlign: TextAlign.center),
                      Text('2da\nRef', textAlign: TextAlign.center),
                    ]),
                    _getRow('Anti-BCG', 'Tuberculosis'),
                    _getRow('Anti-Hepatitis B', 'HepB'),
                    _getRow('Anti-Rotavirus', 'Rotavirus'),
                    _getRow('Anti-Polio', 'Polio'),
                    _getRow('Pentavalente\n(DPT/HB/Hib)', 'Pentavalente'),
                    _getRow('Anti-Neumococo', 'Pneumococcal'),
                    _getRow('Influenza', 'Influenza'),
                    _getRow('SRP', 'MMR'),
                    _getRow('DPT', 'DTP'),
                    _getRow('SR', 'MR'),
                  ],
                ),
              ],
            ),
    );
  }
}
