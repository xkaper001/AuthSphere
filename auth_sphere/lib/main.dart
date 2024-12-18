import 'package:auth_sphere/monitor_page.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import 'welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: Colors.white,
      theme: ThemeData.dark(),
      home: const WebAnalyzer(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WebAnalyzer extends StatefulWidget {
  const WebAnalyzer({super.key});

  @override
  WebAnalyzerState createState() => WebAnalyzerState();
}

class WebAnalyzerState extends State<WebAnalyzer> {

  late WebSocketChannel _channel;
  final PageController pageController = PageController();
  final siteToMonitor = "";
  
  final TextEditingController demoSiteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final vh = MediaQuery.of(context).size.height;
    final vw = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            top: 0,
            left: 0,
            height: vh * 0.5,
            child: Image.asset(
              'assets/tl.png',
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            height: vh * 0.5,
            child: Image.asset('assets/tr.png'),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            height: vh * 0.5,
            child: Image.asset('assets/bl.png'),
          ),
          Positioned(
            right: 0,
            bottom: 0,
            height: vh * 0.5,
            child: Image.asset('assets/br.png'),
          ),
          Center(
              child: SizedBox(
            width: vw * 0.5,
            height: vh * 0.6,
            child: PageView(
              controller: pageController,
              physics: const BouncingScrollPhysics(),
              children: [
                WelcomePage(pageController: pageController),
                EnterWebsite(
                  siteToMonitor: siteToMonitor,
                  pageController: pageController,
                ),
                const MonitorPage(),
              ],
            ),
          )),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _channel.sink.close();
    super.dispose();
  }
}

class EnterWebsite extends StatelessWidget {
  final String siteToMonitor;
  final PageController pageController;
  const EnterWebsite(
      {super.key,
      required this.pageController, required this.siteToMonitor});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 150),
          child: TextField(
            controller: textController,
            decoration: const InputDecoration(
              labelText: 'Enter the Website to monitor',
              labelStyle: TextStyle(color: Colors.white),
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 48,
        ),
        FilledButton(
          onPressed: () {
            pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          },
          style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(Colors.white),
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
          child: const Text(
            "Monitor",
            style: TextStyle(color: Colors.black, fontSize: 24),
          ),
        )
      ],
    );
  }
}