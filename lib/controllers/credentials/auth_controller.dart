import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  Rx<User?> user = Rx<User?>(null);
  RxBool isLoading = false.obs;
  RxBool isUserLoggedIn = false.obs;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    user.bindStream(auth.authStateChanges());
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      isLoading.value = true;
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) {
        isUserLoggedIn.value = true;
      });
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isUserLoggedIn.value = false;
      debugPrint("Error during email/password login: $e");
      Get.snackbar(
        'Login Failed!',
        e.toString(),
        animationDuration: const Duration(milliseconds: 500),
        backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      await auth.signInWithCredential(credential).then((value) {
        isUserLoggedIn.value = true;
      });
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      isUserLoggedIn.value = false;
      debugPrint("Error during Google login: $e");
      Get.snackbar(
        'Login Google Failed!',
        e.toString(),
        animationDuration: const Duration(milliseconds: 500),
        backgroundColor: const Color.fromRGBO(255, 0, 0, 1),
        colorText: const Color(0xFFFFFFFF),
      );
    }
  }

  Future<void> signOut() async {
    await auth.signOut().then((value) => isUserLoggedIn.value = false);
  }
}
