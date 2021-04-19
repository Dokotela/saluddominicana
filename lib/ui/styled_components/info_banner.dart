import 'package:fhir/r4/resource_types/base/individuals/individuals.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:saluddominicana/_internal/utils/utils.dart';

import '../localization.dart';

class InfoBannerWidget extends StatelessWidget {
  const InfoBannerWidget({
    required this.name,
    required this.id,
    required this.birthDate,
    required this.relativeAge,
    required this.sex,
    required this.primaryContact,
  });

  final String name;
  final String id;
  final String birthDate;
  final String relativeAge;
  final String sex;
  final PatientContact? primaryContact;

  @override
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context)!;
    const _spacerV = SizedBox(height: 4.0);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            '${labels.name.title}: $name',
            style: Get.textTheme.headline6!.copyWith(fontSize: Get.width / 20),
          ),
          _spacerV,
          Text(
            '${labels.birthDate.title}: $birthDate',
            style: Get.textTheme.headline6!.copyWith(fontSize: Get.width / 20),
          ),
          _spacerV,
          Text(
            '${labels.age.title}: $relativeAge',
            style: Get.textTheme.headline6!.copyWith(fontSize: Get.width / 20),
          ),
          _spacerV,
          Text(
            '${labels.gender.title}: $sex',
            style: Get.textTheme.headline6!.copyWith(fontSize: Get.width / 20),
          ),
          _spacerV,
          Text(
            'ID: $id',
            style: Get.textTheme.headline6!.copyWith(fontSize: Get.width / 20),
          ),
          Text(
            primaryContact?.relationship == null
                ? 'N/A'
                : 'Contacto Primario: ${primaryContact?.relationship?[0].coding?[0].display}',
            style: Get.textTheme.headline6!.copyWith(fontSize: Get.width / 20),
          ),
          Text(
            primaryContact?.relationship == null
                ? 'N/A'
                : 'Nombre de Contacto: ${lastCommaGivenName(primaryContact?.name == null ? null : [
                    primaryContact!.name!
                  ])}',
            style: Get.textTheme.headline6!.copyWith(fontSize: Get.width / 20),
          ),
        ],
      ),
    );
  }
}
