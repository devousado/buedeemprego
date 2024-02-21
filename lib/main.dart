import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_cookie_manager/webview_cookie_manager.dart';

void main() {
  runApp(const MyApp());
  late WebviewCookieManager webViewCookieManager;
  webViewCookieManager = WebviewCookieManager();
  webViewCookieManager.removeCookie("https://buedeempregos.blogspot.com");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isloading = false;
  late WebViewController webViewController;

  void clear() async {}

  @override
  void initState() {
    clear();

    webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (url) async {
            setState(
              () {
                isloading = false;
              },
            );
            log("finished");
          },
          onProgress: (progress) {
            log("progresss");
            setState(() {
              isloading = true;
            });
          },
        ),
      )
      ..loadRequest(
        Uri.parse("https://buedeempregos.blogspot.com"),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: isloading
            ? const Center(child: CircularProgressIndicator())
            : WebViewWidget(controller: webViewController),
      ),
    );
  }
}
