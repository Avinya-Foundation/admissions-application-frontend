import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  static String apiUrl = 'http://localhost:8080';
  static String admissionsApplicationBffApiUrl = 'http://localhost:9090';
  static String admissionsApplicationBffApiKey = '';
  static String choreoSTSEndpoint = "https://sts.choreo.dev/oauth2/token";
  static String choreoSTSClientID = "Mhss_8Q4iuJ83Tt2Mtazju8MltYa";
  static var apiTokens = null;
  static String applicationName = 'Avinya Acadamy Student Admissions Portal';
  static String applicationVersion = '0.1.0';

  //AppConfig({required this.apiUrl});

  static Future<AppConfig> forEnvironment(String env) async {
    // load the json file
    String contents = "{}";
    try {
      contents = await rootBundle.loadString(
        'assets/config/$env.json',
      );
    } catch (e) {
      print(e);
    }

    // decode our json
    final json = jsonDecode(contents);
    apiUrl = json['sms_api_url'];
    admissionsApplicationBffApiUrl = json['admissionsApplicationBffApiUrl'];
    admissionsApplicationBffApiKey = json['admissionsApplicationBffApiKey'];

    // convert our JSON into an instance of our AppConfig class
    return AppConfig();
  }

  String getApiUrl() {
    return apiUrl;
  }
}
