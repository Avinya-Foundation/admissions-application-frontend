import 'package:ShoolManagementSystem/src/data/prospect.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_html/flutter_html.dart';

class SubscribedThankyouScreen extends StatefulWidget {
  static const String route = 'subscribed_thankyou';
  final Prospect? prospect;

  const SubscribedThankyouScreen({super.key, this.prospect});
  @override
  _SubscribedThankyouScreenState createState() =>
      _SubscribedThankyouScreenState();
}

class _SubscribedThankyouScreenState extends State<SubscribedThankyouScreen> {
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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Avinya Acadamy - Student Admissions'),
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
                    child: Html(
                      data:
                          """
                <div>
                <h2>Avinya Academy - Prospective Student Subscription</h2>
                <p>
                
                You have successfully subscribed to our prospective student list. 
                We will contact you shortly.
                <br/><br/>
                Thank you for your interest in Avinya Academy. 
                </p>
                </div>
                """,
                      onLinkTap: (url, _, __, ___) async {
                        if (await canLaunchUrl(Uri.parse(url!))) {
                          await launchUrl(Uri.parse(url));
                        } else {
                          throw 'Could not launch $url';
                        }
                      },
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
