import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  static String apiUrl = 'http://localhost:8080';
  static String admissionsApplicationBffApiUrl =
      'https://3a907137-52a3-4196-9e0d-22d054ea5789-prod.e1-us-east-azure.choreoapis.dev/gkwb/application-bff-api/0.3.0';
  static String admissionsApplicationBffApiKey =
      'eyJraWQiOiJnYXRld2F5X2NlcnRpZmljYXRlX2FsaWFzIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiI3ODNmMmNiMi01ZWQyLTQ4OTMtYjA1NC0yMTc5NGNlYzhmOTBAY2FyYm9uLnN1cGVyIiwiaXNzIjoiaHR0cHM6XC9cL3N0cy5jaG9yZW8uZGV2OjQ0M1wvb2F1dGgyXC90b2tlbiIsImtleXR5cGUiOiJQUk9EVUNUSU9OIiwic3Vic2NyaWJlZEFQSXMiOlt7InN1YnNjcmliZXJUZW5hbnREb21haW4iOm51bGwsIm5hbWUiOiJBcHBsaWNhdGlvbiBCRkYgQVBJIiwiY29udGV4dCI6IlwvM2E5MDcxMzctNTJhMy00MTk2LTllMGQtMjJkMDU0ZWE1Nzg5XC9na3diXC9hcHBsaWNhdGlvbi1iZmYtYXBpXC8wLjMuMCIsInB1Ymxpc2hlciI6ImNob3Jlb19wcm9kX2FwaW1fYWRtaW4iLCJ2ZXJzaW9uIjoiMC4zLjAiLCJzdWJzY3JpcHRpb25UaWVyIjpudWxsfV0sImV4cCI6MTY2NjkwMjE5OCwidG9rZW5fdHlwZSI6IkludGVybmFsS2V5IiwiaWF0IjoxNjY2ODQyMTk4LCJqdGkiOiI1N2VhMTM3Ny0xZjBhLTQ0MTEtOTNjMy1lNDQ0MDY5NWIxMjIifQ.CwgzQowBjSrBTUxHGtbxpSTua9odRrWqb8u6KrKaL3WUGKM-6dCZWT6zetN4bFp6djw2JnIC5QZZD6loLKyqr6SfBakEHfQ-ZoS-_xkFp8lCC2SXOhXiUFWEuBNMbi3UFRgHB9cWt51E0QWHyc060nGZ-riePLmjweFICxhdPonWeVaGIPCFmpDRD97dDWQmehJDmeOe8Et08QbF7Q8tHyjXZFS377frxMDgeCNU6i-oaRYyTLnvNu8623hS23MISxK8wzU6QdFolCdBc4NbGpv9ccNW5ULMe-JLmqTelAuaKZgyBWNdtrlkVzR4mwasMVzuUnooh0IWek1whvXKGdkIDGom1uREqOis-r4skwU0fM9buoh-OVPotag2dad1O-fp7u0eDUU4YxkpVmCk1lUP4x4DfYVXNwbptweVQb4sLk07skj8uH8mgP4w2qmhMQtrVFjTo2wwJxCJiKA3kDKu99Vcz6u4YYjRGBSZuAC-j1bAbrwkqhn_jF6WJ84Rz9qg2VK9hBqJdPIJtEiF24rqsuqC4pF31Lg37S0I7Be9c1hJsPqDsqVI8XlbD5KLhV1qsRG_ao41Vz40KcT4PbTfLKwBgI7WXm1uEMzqK-IABgXLkQZ6LuWeKYLtUPe7XFzOldo5hDlqZ9-JR5zsTFlZ9CZBf4JGh_SrCqSNRzs';
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
