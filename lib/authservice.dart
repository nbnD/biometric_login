import 'dart:developer';

import 'package:local_auth/local_auth.dart';

class AuthService {
  static Future<bool> authenticateUser() async {

    //for status of authentication
    bool isAuthenticated = false;

    //initialize the LocalAuthentication plugin
    final LocalAuthentication auth = LocalAuthentication();

bool isBioSupported=false;

    bool canCheckBiometrics = false;



    try {
    //check if device supports biometrics authentication.

      isBioSupported=await auth.isDeviceSupported();


      //to check if user activated biometrics
      canCheckBiometrics = await auth.canCheckBiometrics;
    } catch (e) {
      print("error biome trics $e");
    }

    // enumerate biometric technologies
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } catch (e) {
      print("error enumerate biometrics $e");
    }

    print("following biometrics are available");
    if (availableBiometrics.isNotEmpty) {
      availableBiometrics.forEach((ab) {
        print("\ttech: $ab");
      });
    } else {
      print("no biometrics are available");
    }

    // authenticate with biometrics
    
    bool authenticated = false;

if(isBioSupported&&canCheckBiometrics){
try {
      isAuthenticated = await auth.authenticate(
        localizedReason: 'Complete the biometrics to continue',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: false,
          stickyAuth: true,
        ),
      );
    } catch (e) {
      print("error using biometric auth: $e");
    }
}
    

    return isAuthenticated;
  }
}
