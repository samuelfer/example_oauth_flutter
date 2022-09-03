import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _status = '';

  @override
  void initState() {
    super.initState();
    // authenticate();
  }

  void authenticate() async {
    print('Chegando no authenticate ...');
    final url =
        Uri.https('login-teste-rkb7ne92.tcepb.tc.br', '/oauth/authorize', {
      'response_type': 'code',
      'client_id': 'sisrhAppCracha',
      'redirect_uri': 'carteirafuncional:/oauth2',
    });

    try {
      final result = await FlutterWebAuth.authenticate(
          url: url.toString(), callbackUrlScheme: "carteirafuncional");
      setState(() {
        _status = 'Got result: $result';
      });
    } on PlatformException catch (e) {
      setState(() {
        _status = 'Got error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Carteira Funcional'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Status: $_status\n'),
              const SizedBox(height: 80),
              ElevatedButton(
                child: Text('Login'),
                onPressed: () {
                  this.authenticate();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
