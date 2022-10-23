import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class Prospect {
  int? id;
  String? created;
  bool? agree_terms_consent;
  bool? active;
  String? record_type;
  bool? receive_information_consent;
  int? phone;
  String? name;
  String? email;

  Prospect({
    this.id,
    this.created,
    this.agree_terms_consent,
    this.active,
    this.record_type,
    this.receive_information_consent,
    this.phone,
    this.name,
    this.email,
  });

  factory Prospect.fromJson(Map<String, dynamic> json) {
    return Prospect(
      id: json['id'],
      created: json['created'],
      agree_terms_consent: json['agree_terms_consent'],
      active: json['active'],
      record_type: json['record_type'],
      receive_information_consent: json['receive_information_consent'],
      phone: json['phone'],
      name: json['name'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (created != null) 'created': created,
        if (agree_terms_consent != null)
          'agree_terms_consent': agree_terms_consent,
        if (active != null) 'active': active,
        if (record_type != null) 'record_type': record_type,
        if (receive_information_consent != null)
          'receive_information_consent': receive_information_consent,
        if (phone != null) 'phone': phone,
        if (name != null) 'name': name,
        if (email != null) 'email': email,
      };
}

Future<http.Response> createProspect(Prospect prospect) async {
  final response = await http.post(
    Uri.parse(AppConfig.admissionsApplicationBffApiUrl + '/prospect'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.admissionsApplicationBffApiKey,
    },
    body: jsonEncode(prospect.toJson()),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to create Prospect.');
  }
}
