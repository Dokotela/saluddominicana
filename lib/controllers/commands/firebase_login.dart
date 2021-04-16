// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';

// class FirebaseLogin extends GetxController {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   FirebaseFirestore firestore = FirebaseFirestore.instance;

//   Future<void> emailLogin() async {
//     try {
//       final userCredential = await auth.signInWithEmailAndPassword(
//           email: 'grey.faulkenberry@mayjuun.org', password: 'hello12345');
//       print(auth.currentUser?.uid);
//       final users = firestore.collection('users');
//       users
//           .doc('grey.faulkenberry@mayjuun.org')
//           .get()
//           .then((value) => print(value.data()));
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         print('Wrong password provided for that user.');
//       }
//     }
//   }

//   Future<void> googleLogin() async {
//     try {
//       final signIn = GoogleSignIn();
//       final account = await signIn.signIn();
//       if (account != null) {
//         final GoogleSignInAuthentication authentication =
//             await account.authentication;
//         final AuthCredential credential = GoogleAuthProvider.credential(
//           accessToken: authentication.accessToken,
//           idToken: authentication.idToken,
//         );
//         final userCred = await auth.signInWithCredential(credential);
//         print(userCred.user);
//       }
//       // final users = firestore.collection('users');
//       // users
//       //     .doc('grey.faulkenberry@mayjuun.org')
//       //     .get()
//       //     .then((value) => print(value.data()));
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'user-not-found') {
//         print('No user found for that email.');
//       } else if (e.code == 'wrong-password') {
//         print('Wrong password provided for that user.');
//       }
//     }
//   }
// }
