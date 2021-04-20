import 'dart:math';

import 'package:fhir/r4.dart';
import 'package:fhir_at_rest/r4.dart';
import 'package:fhir_db/r4.dart';
import 'package:get/get.dart';
import 'package:saluddominicana/controllers/controllers.dart';

import 'i_fhir_db.dart';

class FhirServer {
  FhirServer() {
    serverUrl = _loginCommand.gcsUrl;
  }
  final LoginCommand _loginCommand = Get.find();
  late final FhirUri serverUrl;

  Future syncWithServer() async {
    await uploadAllResources();

    // final patientBundles = await _getPatients(headers);
    // await saveToDb(patientBundles);

    // final vaccineBundles = await _getImmunizations(headers);
    // await saveToDb(vaccineBundles);
  }

  Future uploadAllResources() async {
    final allResources = await ResourceDao().getAll(null);
    final resourceBundle = Bundle(
      type: BundleType.transaction,
      entry: [],
    );
    for (final resource in allResources) {
      resourceBundle.entry!.add(
        BundleEntry(
          fullUrl: FhirUri(
              '${_loginCommand.gcsUrl}/${resource.resourceTypeString()}/${resource.id}'),
          resource: resource,
          request: BundleRequest(
            method: BundleRequestMethod.post,
            url: FhirUri('${resource.resourceTypeString()}/${resource.id}'),
          ),
        ),
      );
    }
    final request =
        FhirRequest.transaction(base: serverUrl.value!, bundle: resourceBundle);
    final response =
        await request.request(headers: await _loginCommand.authHeaders());
    if (response is OperationOutcome) {
      print(response.toJson());
    }
    final newRez = FhirRequest.read(
      base: serverUrl.value!,
      type: R4ResourceType.Patient,
      id: Id('ca604ed7-43da-4f81-84d3-d2e31d672858'),
    );
    final newRes =
        await newRez.request(headers: await _loginCommand.authHeaders());
    print(newRes?.toJson());
    final updateRes = (newRes as Patient).copyWith(gender: PatientGender.male);
    final updateReq =
        FhirRequest.update(base: serverUrl.value!, resource: updateRes);
    final finalRes =
        await updateReq.request(headers: await _loginCommand.authHeaders());
    print(finalRes?.toJson());
  }

  int random(int numb) {
    final _rand = Random();
    return _rand.nextInt(numb);
  }

  Future saveToDb(List<Bundle> bundleList) async {
    final iFhirDb = IFhirDb();
    for (final bundle in bundleList) {
      for (final entry in bundle.entry ?? []) {
        iFhirDb.save(entry.resource);
      }
    }
  }

//   Future<Map<String, String>> _getAuthorizationToken() async {
//     final headers = {'Content-type': 'application/json'};
//     const identifier = 'web-app';
//     const secret = 'verysecret';

//     final response = await post(
//         Uri.parse(
//             '$server/auth/token?client_id=$identifier&grant_type=client_credentials&client_secret=$secret'),
//         headers: headers);
//     if (response.statusCode == 200) {
//       final parsedbody = json.decode(response.body);
//       final token = parsedbody['token_type'] + ' ' + parsedbody['access_token'];
//       headers.putIfAbsent('Authorization', () => token);
//     }
//     return headers;
//   }

//   Future<List<Bundle>> _getPatients(Map<String, String> headers) async {
//     final bundleList = <Bundle>[];
//     bundleList.add(await getBundle('$server/fhir/Patient', headers));
//     while (
//         bundleList.last.link?.indexWhere((link) => link.relation == 'next') !=
//             -1) {
//       final newSearchUrl = bundleList.last.link
//           ?.firstWhere((link) => link.relation == 'next')
//           .url
//           .toString();
//       bundleList.add(await getBundle('$server/fhir$newSearchUrl', headers));
//     }
//     return bundleList;
//   }

//   Future<List<Bundle>> _getImmunizations(Map<String, String> headers) async {
//     final bundleList = <Bundle>[];
//     bundleList.add(await getBundle('$server/fhir/Immunization', headers));
//     while (bundleList.last.link?.indexWhere(
//           (link) => link.relation == 'next',
//         ) !=
//         -1) {
//       final newSearchUrl = bundleList.last.link
//           ?.firstWhere((link) => link.relation == 'next')
//           .url
//           .toString();
//       bundleList.add(await getBundle('$server/fhir$newSearchUrl', headers));
//     }
//     return bundleList;
//   }

//   Future<Bundle> getBundle(String url, Map<String, String> headers) async {
//     print(url);
//     final result = await get(Uri.parse(url), headers: headers);
//     return Bundle.fromJson(json.decode(result.body));
//   }
}
