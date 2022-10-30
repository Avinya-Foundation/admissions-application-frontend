import 'dart:convert';

import 'package:flutter/services.dart';

class AppConfig {
  static String apiUrl = 'http://localhost:8080';
  static String admissionsApplicationBffApiUrl =
      'https://3a907137-52a3-4196-9e0d-22d054ea5789-prod.e1-us-east-azure.choreoapis.dev/gkwb/application-bff-api/0.3.0';
  static String admissionsApplicationBffApiKey =
      'eyJraWQiOiJnYXRld2F5X2NlcnRpZmljYXRlX2FsaWFzIiwiYWxnIjoiUlMyNTYifQ.eyJzdWIiOiI3ODNmMmNiMi01ZWQyLTQ4OTMtYjA1NC0yMTc5NGNlYzhmOTBAY2FyYm9uLnN1cGVyIiwiaXNzIjoiaHR0cHM6XC9cL3N0cy5jaG9yZW8uZGV2OjQ0M1wvb2F1dGgyXC90b2tlbiIsImtleXR5cGUiOiJQUk9EVUNUSU9OIiwic3Vic2NyaWJlZEFQSXMiOlt7InN1YnNjcmliZXJUZW5hbnREb21haW4iOm51bGwsIm5hbWUiOiJBcHBsaWNhdGlvbiBCRkYgQVBJIiwiY29udGV4dCI6IlwvM2E5MDcxMzctNTJhMy00MTk2LTllMGQtMjJkMDU0ZWE1Nzg5XC9na3diXC9hcHBsaWNhdGlvbi1iZmYtYXBpXC8wLjMuMCIsInB1Ymxpc2hlciI6ImNob3Jlb19wcm9kX2FwaW1fYWRtaW4iLCJ2ZXJzaW9uIjoiMC4zLjAiLCJzdWJzY3JpcHRpb25UaWVyIjpudWxsfV0sImV4cCI6MTY2NzE4MzgwNSwidG9rZW5fdHlwZSI6IkludGVybmFsS2V5IiwiaWF0IjoxNjY3MTIzODA1LCJqdGkiOiJjMDRjZTZjNC05MjgzLTQxMWUtYjI2Zi0zY2M1NjhiODNjOTAifQ.bHMR9JlKBorhNRHTm52PigjrAgF4HevYk0LDCB7Rl5FzbnoWwuEgqKolH_0NGazUq_a8DhlRGhDvIpckrIH6plOT_lnyfmnDcVOzgebzSvUgdGgz0IvPUYCjiHwbn9GSe_nVNA41rMqVRbziwV0Zwai7AylPuveO-yJZRdxNMFPZ3IEM96NgCOAwfNCBq50bs4MZH1kXLIgp0vzkMTVdKp03GpkVoXld0EH095xPM8fKAA3Syn64N_7exS0FsDcewrJ-le9kOJknf77YL5ovOVkW6KkESA-AgBUAcLK1Jupp9VXx4ubce-1xAg0J4aUufqi9xz3cUHK-wyhl4IPrsFX0vDWxEPo5k7ZjX8BnkN8c0rvWWfy09m7FAWNH4v6C5Lsn9katJkquvh7TNWbRnaFwbmrGuDQb18CiVECSIil1MMtJrQNeSuXGyWs7RZt75lW9wrSBAMtjmGrjaIn21H0cDNvmIn8-di51Ujs2DaDMLz3d2EN69n4Ph52uOXxyyrE_GgG4xC5wmmn5lQs-mwDpSfUOWu3gQTY8DCmFoQ_PrucC69ZJUedFwsZpwcYrvT3WUxUsk4oIPOfkJeQRFWG0WEzxbiWxial7w2JMHSN82uIFX4AuTuN2pp2hLUPU-taGZfT8zg1cBAuyemz1gLFy2G3ulAwEjcSS21cWOm0';
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
