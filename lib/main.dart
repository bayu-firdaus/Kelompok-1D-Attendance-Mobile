import './screen/scan_qr_page.dart';
import './utils/strings.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: main_title,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Color(0xffe11586),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ScanQrPage(),
    );
  }
}
