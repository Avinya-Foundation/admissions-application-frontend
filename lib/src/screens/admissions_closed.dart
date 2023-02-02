import 'package:ShoolManagementSystem/src/data/prospect.dart';
import 'package:flutter/material.dart';

// import '../routing.dart';

class AdmissionsClosedScreen extends StatefulWidget {
  static const String route = 'admissions_closed';
  final Prospect? prospect;

  const AdmissionsClosedScreen({super.key, this.prospect});
  @override
  _AdmissionsClosedScreenState createState() => _AdmissionsClosedScreenState();
}

class _AdmissionsClosedScreenState extends State<AdmissionsClosedScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final routeState = RouteStateScope.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Avinya Academy - Student Admissions'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: SingleChildScrollView(
                    child: Container(
                      child: Wrap(children: [
                        Column(
                          children: [
                            Text(
                              "Avinya Academy - Admissions Closed for 2023 intake",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 20.0),
                            Text(""" 
  Thank you for your interest in our Academy. Applications for the January 2023 intake for the Avinya Academy Bandaragama are closed. 
  We are now dedicating some time to focus on our first cohort of students and will open applications for the January 2024 intake towards the latter part of this year. 
  We will share regular updates on our website and on our social media pages."""),
                            // SizedBox(height: 10.0),
                            // Text(
                            //     "Thank you for your interest in Avinya Academy."),
                            SizedBox(height: 10.0),
                          ],
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                        ),
                      ]),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
