// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_inappwebview/flutter_inappwebview.dart';

// var teste = false;
// final Uri _url = Uri.parse(
//     'https://login-teste-rkb7ne92.tcepb.tc.br/oauth/authorize?response_type=code&client_id=sisrhAppCracha&redirect_uri=carteirafuncional:/oauth2');

// class MyInAppBrowser extends InAppBrowser {
//   @override
//   Future onBrowserCreated() async {
//     print("Browser Created!");
//   }

//   @override
//   Future onLoadStart(url) async {
//     teste = true;
//     print("Started $url");
//     if (url != null) {
//       print(url.queryParameters);
//     }
//   }

//   @override
//   Future onLoadStop(url) async {
//     print("Stopped $url");
//   }

//   @override
//   void onLoadError(url, code, message) {
//     print("Can't load $url.. Error: $message");
//   }

//   @override
//   void onProgressChanged(progress) {
//     print("Progress: $progress");
//   }

//   @override
//   void onExit() {
//     print("Browser closed!");
//   }
// }

// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   if (Platform.isAndroid) {
//     await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);
//   }

//   runApp(
//     MaterialApp(
//       home: MyApp(),
//       debugShowCheckedModeBanner: false,
//     ),
//   );
// }

// class MyApp extends StatefulWidget {
//   final MyInAppBrowser browser = new MyInAppBrowser();

//   @override
//   _MyAppState createState() => new _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   var options = InAppBrowserClassOptions(
//       crossPlatform: InAppBrowserOptions(hideUrlBar: false),
//       inAppWebViewGroupOptions: InAppWebViewGroupOptions(
//           crossPlatform: InAppWebViewOptions(javaScriptEnabled: true)));

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Oauth Teste'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//             onPressed: () {
//               widget.browser.openUrlRequest(
//                   urlRequest: URLRequest(url: _url), options: options);
//             },
//             child: Text("Login Cerberus")),
//       ),
//     );
//   }
// }

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
