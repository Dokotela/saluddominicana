import 'package:fhir/r4.dart';
import 'package:fhir_auth/r4.dart';
import 'package:get/get.dart';

class LoginCommand extends GetxController {
  static const serverString =
      'https://healthcare.googleapis.com/v1/projects/salud-dominicana/locations/us-east4/datasets/salud-dominicana/fhirStores/salud-dominicana/fhir';
  static const gcsScopes = ['https://www.googleapis.com/auth/cloud-platform'];
  final gcsUrl = FhirUri(serverString);
  final _client = GcsClient(fhirUrl: FhirUri(serverString), scopes: gcsScopes);

  Future<bool> login() async {
    try {
      await _client.login();
    } catch (e, stackTrace) {
      Get.snackbar(e.toString(), stackTrace.toString());
    }
    return _client.isLoggedIn;
  }

  Future<Map<String, String>> authHeaders() async => await _client.authHeaders;
}
