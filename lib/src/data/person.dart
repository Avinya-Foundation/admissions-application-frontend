import 'package:http/http.dart' as http;
import 'dart:convert';

import '../config/app_config.dart';

class Person {
  int? id;
  String? record_type;
  String? preferred_name;
  String? full_name;
  String? notes;
  String? date_of_birth;
  String? sex;
  int? avinya_type_id;
  String? passport_no;
  int? permanent_address_id;
  int? mailing_address_id;
  String? nic_no;
  String? id_no;
  int? phone;
  int? organization_id;
  String? asgardeo_id;
  String? email;

  Person({
    this.id,
    this.record_type,
    this.preferred_name,
    this.full_name,
    this.notes,
    this.date_of_birth,
    this.sex,
    this.avinya_type_id,
    this.passport_no,
    this.permanent_address_id,
    this.mailing_address_id,
    this.nic_no,
    this.id_no,
    this.phone,
    this.organization_id,
    this.asgardeo_id,
    this.email,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      record_type: json['record_type'],
      preferred_name: json['preferred_name'],
      full_name: json['full_name'],
      notes: json['notes'],
      date_of_birth: json['date_of_birth'],
      sex: json['sex'],
      avinya_type_id: json['avinya_type_id'],
      passport_no: json['passport_no'],
      permanent_address_id: json['permanent_address_id'],
      mailing_address_id: json['mailing_address_id'],
      nic_no: json['nic_no'],
      id_no: json['id_no'],
      phone: json['phone'],
      organization_id: json['organization_id'],
      asgardeo_id: json['asgardeo_id'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (record_type != null) 'record_type': record_type,
        if (preferred_name != null) 'preferred_name': preferred_name,
        if (full_name != null) 'full_name': full_name,
        if (notes != null) 'notes': notes,
        if (date_of_birth != null) 'date_of_birth': date_of_birth,
        if (sex != null) 'sex': sex,
        if (avinya_type_id != null) 'avinya_type_id': avinya_type_id,
        if (passport_no != null) 'passport_no': passport_no,
        if (permanent_address_id != null)
          'permanent_address_id': permanent_address_id,
        if (mailing_address_id != null)
          'mailing_address_id': mailing_address_id,
        if (nic_no != null) 'nic_no': nic_no,
        if (id_no != null) 'id_no': id_no,
        if (phone != null) 'phone': phone,
        if (organization_id != null) 'organization_id': organization_id,
        if (asgardeo_id != null) 'asgardeo_id': asgardeo_id,
        if (email != null) 'email': email,
      };
}

Future<List<Person>> fetchPersons() async {
  final response = await http.get(
    Uri.parse(AppConfig.globalDataApiUrl + '/person/persons'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json',
      'API-Key': AppConfig.globalDataApiKey,
    },
  );

  if (response.statusCode == 200) {
    var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
    List<Person> persons =
        await resultsJson.map<Person>((json) => Person.fromJson(json)).toList();
    return persons;
  } else {
    throw Exception('Failed to load Person');
  }
}

Future<Person> fetchPerson(String id) async {
  final response = await http.get(
    Uri.parse(AppConfig.globalDataApiUrl + '/person/persons/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'accept': 'application/json',
      'API-Key': AppConfig.globalDataApiKey,
    },
  );

  if (response.statusCode == 200) {
    var resultsJson = json.decode(response.body).cast<Map<String, dynamic>>();
    Person person =
        await resultsJson.map<Person>((json) => Person.fromJson(json));
    return person;
  } else {
    throw Exception('Failed to load Person');
  }
}

Future<http.Response> createPerson(Person person) async {
  final response = await http.post(
    Uri.parse(AppConfig.globalDataApiUrl + '/person/persons'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.globalDataApiKey,
    },
    body: jsonEncode(person.toJson()),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to create Person.');
  }
}

Future<http.Response> updatePerson(Person person) async {
  final response = await http.put(
    Uri.parse(AppConfig.globalDataApiUrl + '/person/persons'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.globalDataApiKey,
    },
    body: jsonEncode(person.toJson()),
  );
  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to update Person.');
  }
}

Future<http.Response> deletePerson(String id) async {
  final http.Response response = await http.delete(
    Uri.parse(AppConfig.globalDataApiUrl + '/person/persons/$id'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'API-Key': AppConfig.globalDataApiKey,
    },
  );

  if (response.statusCode == 200) {
    return response;
  } else {
    throw Exception('Failed to delete Person.');
  }
}
