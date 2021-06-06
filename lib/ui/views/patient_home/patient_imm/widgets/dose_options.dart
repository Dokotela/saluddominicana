import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saluddominicana/_internal/constants/constants.dart';
import 'package:saluddominicana/controllers/controllers.dart';
import 'package:saluddominicana/ui/styled_components/styled_components.dart';

Widget doseOptions(String dz, int val) {
  PatientImmController controller = Get.find()!;

  TextButton _textButton(String date) {
    return TextButton(
      child: Text(
        '${date.substring(0, 4)}\n${date.substring(5, 10)}',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: Get.width * .022,
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
        arguments: [dz],
      ),
    );
  }

  return controller.display(dz, val).fold((l) {
    switch (l) {
      case DoseDisplay.open:
        return Container();

      case DoseDisplay.due:
        return Container(
          alignment: Alignment.center,
          child: Icon(
            Icons.access_time,
            color: Colors.orange,
          ),
        );

      case DoseDisplay.completedToday:
        {
          final todaysDate = DateTime.now().toString();
          return Text(
            '${todaysDate.substring(0, 4)}\n${todaysDate.substring(5, 10)}',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: Get.width * .022, color: Colors.red),
          );
        }

      case DoseDisplay.overdue:
        return Container(
            alignment: Alignment.center,
            child: Icon(
              Icons.warning,
              color: Colors.red,
            ));

      case DoseDisplay.na:
        return Container(
          color: Colors.black,
          child: Text('\n\n'),
        );

      default:
        return Container();
    }
  }, (r) => _textButton(r));
}
