import 'package:attendancewithfingerprint/utils/strings.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242559),
      appBar: AppBar(
        title: Text(about_title)
      ),
      body: Container(
        margin: EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image(
              image: AssetImage('images/logo.png'),
            ),
            SizedBox(
              height: 10.0,
            ),
            Center(
              child: Text(
                about_app_name,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              about_developer,
              style: TextStyle(fontSize: 15.0, color: Colors.grey),
            ),
            Text(
              about_url,
              style: TextStyle(fontSize: 13.0, color: Colors.grey),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              about_desc,
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
