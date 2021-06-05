import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../localization.dart';
import 'layout.dart';

class NamesInputWidget extends StatelessWidget {
  const NamesInputWidget({
    required this.familyName,
    required this.givenName,
    required this.familyNameError,
    required this.givenNameError,
  });

  final TextEditingController familyName;
  final TextEditingController givenName;
  final String familyNameError;
  final String givenNameError;

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context)!;

    return Column(
      children: <Widget>[
        /// error is blank at first, only is shown after the registration
        /// button is pushed, names must be at least 2 characters
        Layout([
          TextFormField(
            controller: familyName,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: labels.name.familyName,
              labelStyle:
                  Get.textTheme.bodyText1!.copyWith(fontSize: Get.width * .05),
            ),
            style: Get.textTheme.headline6!.copyWith(fontSize: Get.width * .05),
            showCursor: true,
            cursorColor: Colors.black,
          )
        ]),
        Text(
          familyNameError,
          style: Get.theme.textTheme.caption!
              .copyWith(color: Get.theme.colorScheme.error),
        ),

        /// error is blank at first, only is shown after the registration
        /// button is pushed, names must be at least 2 characters
        Layout(
          [
            TextFormField(
              controller: givenName,
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: labels.name.givenNames,
                labelStyle: Get.textTheme.bodyText1!
                    .copyWith(fontSize: Get.width * .05),
                // errorText: givenNameError == '' ? null : givenNameError,
              ),
              style:
                  Get.textTheme.headline6!.copyWith(fontSize: Get.width * .05),
              showCursor: true,
              cursorColor: Colors.black,
            ),
          ],
        ),
        Text(
          givenNameError,
          style: Get.theme.textTheme.caption!
              .copyWith(color: Get.theme.colorScheme.error),
        ),
      ],
    );
  }
}
