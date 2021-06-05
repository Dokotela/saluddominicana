import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:saluddominicana/ui/views/new_patient/widgets/layout.dart';

class DropDownSelection extends StatelessWidget {
  const DropDownSelection({
    required this.title,
    required this.selectionList,
    required this.display,
    required this.selectNew,
    required this.error,
  });

  final String title;
  final List<String> selectionList;
  final String display;
  final Function selectNew;
  final String error;

  @override
  Widget build(BuildContext context) {
    var newList = selectionList.toList();
    newList.insert(0, '');
    return Column(
      children: [
        Layout(
          [
            Text(
              title,
              style: Get.theme.textTheme.bodyText1!
                  .copyWith(fontSize: Get.width * .04),
            ),
            Container(
              alignment: Alignment.center,
              child: DropdownButton<String>(
                value: display,
                icon: Icon(Icons.keyboard_arrow_down),
                items: newList.map(
                  (String selection) {
                    return DropdownMenuItem<String>(
                      value: selection,
                      child: Text(selection),
                    );
                  },
                ).toList(),
                onChanged: (newVal) =>
                    newVal != null && newVal != '' ? selectNew(newVal) : null,
              ),
            ),
          ],
        ),
        Text(
          error,
          style: Get.theme.textTheme.caption!
              .copyWith(color: Get.theme.colorScheme.error),
        ),
      ],
    );
  }
}
