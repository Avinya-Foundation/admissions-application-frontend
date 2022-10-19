import 'dart:developer';

import 'package:ShoolManagementSystem/src/data.dart';
// import 'package:ShoolManagementSystem/src/data/library.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:email_validator/email_validator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../routing.dart';

class ApplyScreen extends StatefulWidget {
  static const String route = 'apply';
  // final AddressType addressType;
  const ApplyScreen({super.key});
  @override
  _ApplyScreenState createState() => _ApplyScreenState();
}

class _ApplyScreenState extends State<ApplyScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _full_name_Controller;
  late FocusNode _full_name_FocusNode;
  late TextEditingController _preferred_name_Controller;
  late FocusNode _preferred_name_FocusNode;
  late TextEditingController _email_Controller;
  late FocusNode _email_FocusNode;
  late TextEditingController _phone_Controller;
  late FocusNode _phone_FocusNode;

  MaskTextInputFormatter phoneMaskTextInputFormatter =
      new MaskTextInputFormatter(
          mask: '###-###-####',
          filter: {"#": RegExp(r'[0-9]')},
          type: MaskAutoCompletionType.eager);
  String gender = 'Not Specified';

  @override
  void initState() {
    super.initState();
    _full_name_Controller = TextEditingController();
    _full_name_FocusNode = FocusNode();
    _preferred_name_Controller = TextEditingController();
    _preferred_name_FocusNode = FocusNode();
    _email_Controller = TextEditingController();
    _email_FocusNode = FocusNode();
    _phone_Controller = TextEditingController();
    _phone_FocusNode = FocusNode();
  }

  @override
  void dispose() {
    _full_name_Controller.dispose();
    _full_name_FocusNode.dispose();
    _preferred_name_Controller.dispose();
    _preferred_name_FocusNode.dispose();
    _email_Controller.dispose();
    _email_FocusNode.dispose();
    _phone_Controller.dispose();
    _phone_FocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final routeState = RouteStateScope.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Avinya Acadamy Student Application Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: <Widget>[
              const Text('Fill in the applicant details'),
              TextFormField(
                controller: _full_name_Controller,
                decoration: const InputDecoration(
                    labelText: 'Full name *',
                    hintText: 'Enter your full name',
                    helperText: 'Same as in your NIC or birth certificate'),
                onFieldSubmitted: (_) {
                  _full_name_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              TextFormField(
                controller: _preferred_name_Controller,
                decoration: const InputDecoration(
                    labelText: 'Preferred name *',
                    contentPadding: EdgeInsets.symmetric(vertical: 2),
                    hintText: 'Enter the name you preferr to be called',
                    helperText: 'e.g. John'),
                onFieldSubmitted: (_) {
                  _preferred_name_FocusNode.requestFocus();
                },
                validator: _mandatoryValidator,
              ),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Text('Sex'),
                    SizedBox(height: 10.0),
                    Row(children: [
                      SizedBox(
                        width: 10,
                        child: Radio(
                          value: 'Male',
                          groupValue: gender,
                          activeColor: Colors.orange,
                          onChanged: (value) {
                            //value may be true or false
                            setState(() {
                              gender = value.toString();
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text('Male'),
                      SizedBox(width: 10.0),
                      //]),
                      //Row(children: [
                      SizedBox(
                        width: 10,
                        child: Radio(
                          value: 'Female',
                          groupValue: gender,
                          activeColor: Colors.orange,
                          onChanged: (value) {
                            //value may be true or false
                            setState(() {
                              gender = value.toString();
                            });
                          },
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Text('Female'),
                    ]),
                  ]),
              TextFormField(
                controller: _phone_Controller,
                decoration: InputDecoration(
                  labelText: 'Phone number *',
                  hintText: 'Enter your phone number',
                  helperText: 'e.g 077 123 4567',
                ),
                onFieldSubmitted: (_) {
                  _phone_FocusNode.requestFocus();
                },
                validator: (value) =>
                    _mandatoryValidator(value) ?? _phoneValidator(value),

                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly,
                  phoneMaskTextInputFormatter,
                ], // Only numbers can be entered
              ),
              TextFormField(
                controller: _email_Controller,
                decoration: InputDecoration(
                  labelText: 'Email *',
                  hintText: 'Enter your email address',
                  helperText: 'e.g john@mail.com',
                ),
                onFieldSubmitted: (_) {
                  _email_FocusNode.requestFocus();
                },
                validator: (value) => EmailValidator.validate(value!)
                    ? null
                    : "Please enter a valid email",
              ),
              SizedBox(width: 10.0, height: 10.0),
              ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await addSudentApplicant(context);
                      admissionSystemInstance.setApplicationSubmitted(true);
                      await routeState.go('/authors');
                    }
                  },
                  child: Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }

  String? _mandatoryValidator(String? text) {
    return (text!.isEmpty) ? 'Required' : null;
  }

  String? _phoneValidator(String? text) {
    String? value = phoneMaskTextInputFormatter.getUnmaskedText();
    return (value.length != 10)
        ? 'Phone number must be 10 digits e.g 071 234 5678'
        : null;
  }

  Future<void> addSudentApplicant(BuildContext context) async {
    try {
      if (_formKey.currentState!.validate()) {
        log('addSudentApplicant valid');
        log(_phone_Controller.text);
        log(phoneMaskTextInputFormatter.getUnmaskedText());
        final Person person = Person(
            record_type: 'person',
            full_name: _full_name_Controller.text,
            preferred_name: _preferred_name_Controller.text,
            sex: gender,
            phone: int.parse(phoneMaskTextInputFormatter.getUnmaskedText()),
            email: _email_Controller.text);
        log(person.toJson().toString());
        final createPersonResponse = await createPerson(person);
        log(createPersonResponse.body.toString());
        //Navigator.of(context).pop(true);

      } else {
        log('addSudentApplicant invalid');
      }
    } on Exception {
      await showDialog(
        context: context,
        builder: (_) => AlertDialog(
          content: const Text('Failed to submit the student application form'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            )
          ],
        ),
      );
    }
  }
}
