import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage({super.key});

  @override
  State<WebViewPage> createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  late WebViewController controller;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
  ..setJavaScriptMode(JavaScriptMode.unrestricted)
  ..loadRequest(Uri.parse("https://github.com/erfkarimi/jungle"))
  ..setNavigationDelegate(
    NavigationDelegate(
      onPageFinished: (_){
        setState(() {
          loading = false;
        });
      }
    )
  );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: buildBody(),
    );
  }

  AppBar buildAppBar(){
    return AppBar(
      title: const Text("About"),
    );
  }

  Widget buildBody(){
    return Stack(
      children: [
        WebViewWidget(
          controller: controller),
          if(loading) const Center(
            child: CircularProgressIndicator(),
          )
      ],
    );
  }
}