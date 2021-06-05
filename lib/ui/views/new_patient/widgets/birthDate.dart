import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saluddominicana/ui/views/new_patient/widgets/layout.dart';

import '../../../../ui/styled_components/styled_components.dart';
import '../../../localization.dart';

class BirthDateWidget extends StatelessWidget {
  const BirthDateWidget({
    required this.birthDate,
    required this.chooseBirthDate,
    required this.displayBirthDate,
    required this.dispBirthDateError,
  });

  final DateTime birthDate;
  final Function chooseBirthDate;
  final String displayBirthDate;
  final String dispBirthDateError;

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context)!;

    return Column(
      children: [
        Layout(
          [
            Text(
              '${labels.dateOfBirth.title}',
              style: Get.theme.textTheme.bodyText1!
                  .copyWith(fontSize: Get.width * .04),
            ),
            TextButton(
              onPressed: () => showMyDatePicker(
                  initialDate: birthDate == DateTime(1900, 1, 1)
                      ? DateTime.now()
                      : birthDate,
                  function: chooseBirthDate),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                      displayBirthDate == ''
                          ? DateTime.now().toString().substring(0, 10)
                          : displayBirthDate,
                      style: Get.theme.textTheme.bodyText1),
                  Icon(Icons.keyboard_arrow_down, color: Colors.black),
                ],
              ),
            ),
          ],
        ),
        Text(
          dispBirthDateError,
          style: Get.theme.textTheme.caption!
              .copyWith(color: Get.theme.colorScheme.error),
        ),
      ],
    );
  }
}
