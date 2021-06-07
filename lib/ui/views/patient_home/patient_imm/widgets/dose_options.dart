import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saluddominicana/_internal/constants/constants.dart';
import 'package:saluddominicana/controllers/controllers.dart';
import 'package:saluddominicana/ui/styled_components/styled_components.dart';

Widget doseOptions(String dz, int val) {
  PatientImmController controller = Get.find()!;

  TextButton _textButton(String? date, Icon? icon) {
    return TextButton(
      child: date == null
          ? icon == null
              ? Text('')
              : icon
          : Text(
              '${date.substring(0, 4)}\n${date.substring(5, 10)}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: Get.width * Get.height * .00003,
                  color: date.substring(0, 10) ==
                          DateTime.now().toString().substring(0, 10)
                      ? Colors.yellow
                      : Colors.green),
            ),
      onPressed: () => showMyDatePicker(
        initialDate: controller.display(dz, val).fold(
              (l) => DateTime.now(),
              (r) => DateTime.parse(r),
            ),
        function: controller.addNew,
        arguments: [dz, date != null && date != '', date],
      ),
    );
  }

  return controller.display(dz, val).fold((l) {
    switch (l) {
      case DoseDisplay.open:
        return _textButton(null, null);
      case DoseDisplay.due:
        return _textButton(null, Icon(Icons.access_time, color: Colors.orange));
      case DoseDisplay.completedToday:
        return _textButton(DateTime.now().toString(), null);
      case DoseDisplay.overdue:
        return _textButton(null, Icon(Icons.warning, color: Colors.red));
      case DoseDisplay.na:
        return Container(color: Colors.black, child: Text('\n\n'));
      default:
        return Container();
    }
  }, (r) => _textButton(r, null));
}
