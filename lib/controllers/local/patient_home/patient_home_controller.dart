import 'package:fhir/r4.dart';
import 'package:get/get.dart';

import '../../../_internal/utils/relative_age.dart';
import '../../../models/data/patient_model.dart';
import '../../../routes/routes.dart';

class PatientHomeController extends GetxController {
  /// PROPERTIES
  final _patient = PatientModel().obs;

  /// INIT
  @override
  void onInit() {
    _patient.value = Get.arguments;
    super.onInit();
  }

  /// GETTER FUNCTIONS
  String name() => _patient.value.name();
  String id() => _patient.value.id();
  String sex() => _patient.value.sex();
  String birthDate() => _patient.value.birthDate();
  String relativeAge() => sharedRelativeAge(_patient.value.birthDate());
  PatientModel actualPatient() => _patient.value;
  PatientContact? primaryContact() => _patient.value.patient.contact == null
      ? null
      : _patient.value.patient.contact!.isEmpty
          ? null
          : _patient.value.patient.contact![0];

  /// SETTER FUNCTIONS

  /// EVENTS
  void editPatient() =>
      Get.toNamed(AppRoutes.NEW_PATIENT, arguments: _patient.value);

  Future? immPage() => Get.toNamed(AppRoutes.PATIENT_IMM_PAGE);
}
