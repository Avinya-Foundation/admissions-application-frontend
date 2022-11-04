import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:openid_client/openid_client_browser.dart';
import 'package:url_launcher/url_launcher.dart';

class Credentials {
  final String username;
  final String password;

  Credentials(this.username, this.password);
}

class SignInScreen extends StatefulWidget {
  final ValueChanged<Credentials> onSignIn;

  const SignInScreen({
    required this.onSignIn,
    super.key,
  });

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  // final _usernameController = TextEditingController();
  // final _passwordController = TextEditingController();

  // @override
  // Widget build(BuildContext context) => Scaffold(
  //       body: Center(
  //         child: Card(
  //           child: Container(
  //             constraints: BoxConstraints.loose(const Size(600, 600)),
  //             padding: const EdgeInsets.all(8),
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 Text('Sign in', style: Theme.of(context).textTheme.headline4),
  //                 TextField(
  //                   decoration: const InputDecoration(labelText: 'Username'),
  //                   controller: _usernameController,
  //                 ),
  //                 TextField(
  //                   decoration: const InputDecoration(labelText: 'Password'),
  //                   obscureText: true,
  //                   controller: _passwordController,
  //                 ),
  //                 Padding(
  //                   padding: const EdgeInsets.all(16),
  //                   child: TextButton(
  //                     onPressed: () async {
  //                       widget.onSignIn(Credentials(
  //                           _usernameController.value.text,
  //                           _passwordController.value.text));
  //                     },
  //                     child: const Text('Sign in'),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ),
  //     );
  final String _clientId = '5aWvzhsDFmvgHqxeV_f43yJ92xca';
  //final String _redirectUrl = 'http://localhost:52004/';
  static const String _issuerUrl =
      //'https://api.asgardeo.io/t/avinyafoundation/oauth2/authorize';
      'https://api.asgardeo.io/t/avinyafoundation/oauth2/token';

  // final String _discoveryUrl =
  //     'https://api.asgardeo.io/t/avinyafoundation/oauth2/token/.well-known/openid-configuration';

  final List<String> _scopes = <String>['openid', 'profile', 'email'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign in"),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                child: SingleChildScrollView(
                  child: Html(
                    data: """
                <div>
                <h1>Avinya Acadamy Student Admissions</h1>
                <p>To proceed to the next steps of the appliation proess, 
                please sign in with your Gmail address.</p>
                Once you sing in, you will be dorected to the rest of the pplication 
                application froms.</p>
                <p>If you have alread completed the application forms, you can sign in 
                to view the application dashboard wheer you will see the status of your application.</p>
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
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(Colors.yellowAccent),
                  shadowColor: MaterialStateProperty.all(Colors.lightBlue),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/google.png',
                      fit: BoxFit.contain,
                      width: 30,
                    ),
                    Text(
                      "Login with Google",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                onPressed: () async {
                  await authenticate(Uri.parse(_issuerUrl), _clientId, _scopes);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  authenticate(Uri uri, String clientId, List<String> scopes) async {
    // create the client
    var issuer = await Issuer.discover(uri);
    var client = new Client(issuer, clientId);

    // create an authenticator
    var authenticator = new Authenticator(client, scopes: scopes);

    // starts the authentication
    authenticator.authorize();
  }
}
