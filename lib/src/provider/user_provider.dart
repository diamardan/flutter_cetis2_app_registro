import 'dart:async';

import 'package:cetis2_app_registro/src/data/AuthenticationService.dart';
import 'package:cetis2_app_registro/src/models/user_model.dart';
import 'package:cetis2_app_registro/src/data/RegistrationService.dart';
import 'package:flutter/widgets.dart';
//import 'package:cetis32_app_registro/src/utils/log_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class UserProvider with ChangeNotifier {
  Registration _reg;
  bool _loggingIn = false;

  Registration get getRegistration => _reg;

  bool get isLoggingIn => _loggingIn;

  initUSer() {
    Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    _prefs.then((prefs) {
      if (prefs.getBool('first_run') == false) {
        print("si tengo first_run y es ${prefs.getBool('first_run')}");
        if (prefs.containsKey("registration_id")) {
          String id = prefs.getString("registration_id");
          String access = prefs.getString("auth_method");
          print("id:" + id);

          RegistrationService().get(id).then((registration) {
            registration.accessMethod = access;
            if (registration != null) setRegistration(registration);
          });
        }
      } else {
        FlutterSecureStorage secStorage = FlutterSecureStorage();
        secStorage.deleteAll();
        AuthenticationService().signOut();
        print("no tengo first_run y es ${prefs.getBool('first_run')}");
        prefs.setBool('first_run', false);
      }
    });
  }

  setRegistration(Registration reg) {
    _reg = reg;
    notifyListeners();
  }

  setLogging(value) {
    _loggingIn = value;
    notifyListeners();
  }
}
