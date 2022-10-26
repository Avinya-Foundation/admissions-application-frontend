import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  static String apiUrl = 'http://localhost:8080';
  static String admissionsApplicationBffApiUrl =
      'https://3a907137-52a3-4196-9e0d-22d054ea5789-prod.e1-us-east-azure.choreoapis.dev/gkwb/application-bff-api/0.3.0';
  static String admissionsApplicationBffApiKey =
      'eyJraWQiOiJnYXRld2F5X2NlcnRpZmljYXRlX2FsaWFzIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiI3ODNmMmNiMi01ZWQyLTQ4OTMtYjA1NC0yMTc5NGNlYzhmOTBAY2FyYm9uLnN1cGVyIiwiaXNzIjoiaHR0cHM6XC9cL3N0cy5jaG9yZW8uZGV2OjQ0M1wvb2F1dGgyXC90b2tlbiIsImtleXR5cGUiOiJQUk9EVUNUSU9OIiwic3Vic2NyaWJlZEFQSXMiOlt7InN1YnNjcmliZXJUZW5hbnREb21haW4iOm51bGwsIm5hbWUiOiJBcHBsaWNhdGlvbiBCRkYgQVBJIiwiY29udGV4dCI6IlwvM2E5MDcxMzctNTJhMy00MTk2LTllMGQtMjJkMDU0ZWE1Nzg5XC9na3diXC9hcHBsaWNhdGlvbi1iZmYtYXBpXC8wLjMuMCIsInB1Ymxpc2hlciI6ImNob3Jlb19wcm9kX2FwaW1fYWRtaW4iLCJ2ZXJzaW9uIjoiMC4zLjAiLCJzdWJzY3JpcHRpb25UaWVyIjpudWxsfV0sImV4cCI6MTY2Njc5ODQwMCwidG9rZW5fdHlwZSI6IkludGVybmFsS2V5IiwiaWF0IjoxNjY2NzM4NDAwLCJqdGkiOiJiNDIzOWVlZi0wNzZhLTRmYzgtODI5MC1kY2UyM2UzOGEwNzQifQ.QEd9hZHmTUE0deZYWGv2SoVgsLLQA2rq2LSkO3MT8CAK57l5_7X0Exbw9vDIur0C9u8C-C0Aeedc1i1vQ5NzH8vapaSGGa8kgz3-uB7biKeHJoRCcqO8gAjsU6OjAnM7FPFIOND5FAlisvOimqlqua_6RPp9An6OVfA48rfLhAWl6PB4cLxSfQL1jx6iPMlV_o57NkuNuf8g3LgsSZT2j1XxsYqv_3r6iCrFXtnn88JdFvQwY1xHoJstIbH8UVhE-B_UBwNohBcadjZMu-UAlBVKwP1L-NkmJbcf46vDuY4YZoBDcB2HJiDpW8Q1fr3-6QG6bMKxpTZW405GM_Ur4wu1F86I2z8R8umZQORHpHWCMwC04rY6yYTQ4pC3p2Iam-OKypfwjOir0x27NuWy1rCa8vYZ61CASNZdkn4emHgYFlh03fNCDF_yvbvOziXyjiIK_kJqoxV7804L344w3m2kHcfJiiT_dRNlTLDGIZ92bxeCfdpYzvuc5ZioGEP0MyJ6Xxi4f958Mr08XlDxVIXf52e3FnC0WMGVKXf928yD4IlCb1g62l7CX95dtR0JJkBEPBrrpv7iZ2bh2G625CFEJMAW3CP-cIjOLdBlsVq-z1CF4Qek_Vxbfm0GjZZS51tg4jn7-j2HZp5rTW-vBDkYRMM12tQ7c9qJOoHZ7xE';
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
