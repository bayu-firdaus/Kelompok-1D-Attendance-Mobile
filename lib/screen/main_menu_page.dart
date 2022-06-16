import 'package:android_intent/android_intent.dart';
import '../screen/about_page.dart';
import '../screen/attendance_page.dart';
import '../screen/login_page.dart';
import '../screen/report_page.dart';
import '../screen/setting_page.dart';
import '../utils/single_menu.dart';
import '../utils/strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainMenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Menu();
  }
}

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  @override
  void initState() {
    _getPermission();
    super.initState();
  }

  void _getPermission() async {
    getPermissionAttendance();
    _checkGps();
  }

  void getPermissionAttendance() async {
    await [
      Permission.camera,
      Permission.location,
      Permission.locationWhenInUse,
    ].request();
  }

  // Check the GPS is on
  Future _checkGps() async {
    if (!(await Geolocator().isLocationServiceEnabled())) {
      if (Theme.of(context).platform == TargetPlatform.android) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Tidak bisa mendapatkan lokasi saat ini"),
              content:
                  const Text('Pastikan Anda mengaktifkan GPS dan coba lagi.'),
              actions: <Widget>[
                FlatButton(
                  child: Text('Ok'),
                  onPressed: () async {
                    final AndroidIntent intent = AndroidIntent(
                        action: 'android.settings.LOCATION_SOURCE_SETTINGS');

                    await intent.launch();
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  // Function sign out
  _signOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.remove("status");
      preferences.remove("email");
      preferences.remove("password");
      preferences.remove("id");

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: EdgeInsets.only(bottom: 40.0),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  height: 220.0,
                  color: Color(0xff242559),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage('images/logo.png'),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        main_menu_title,
                        style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SingleMenu(
                      icon: FontAwesomeIcons.check,
                      menuName: main_menu_check_in,
                      color: Color(0xffe11586),
                      action: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AttendancePage(
                            query: 'in',
                            title: main_menu_check_in_title,
                          ),
                        ),
                      ),
                    ),
                    SingleMenu(
                      icon: FontAwesomeIcons.times,
                      menuName: main_menu_check_out,
                      color: Color(0xffe11586),
                      action: () => Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => AttendancePage(
                            query: 'out',
                            title: main_menu_check_out_title,
                          ),
                        ),
                      ),
                    ),
                    SingleMenu(
                      icon: FontAwesomeIcons.qrcode,
                      menuName: main_menu_settings,
                      color: Color(0xffe11586),
                      action: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SettingPage()),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SingleMenu(
                      icon: FontAwesomeIcons.calendarAlt,
                      menuName: main_menu_report,
                      color: Color(0xffe11586),
                      action: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ReportPage()),
                      ),
                    ),
                    SingleMenu(
                      icon: FontAwesomeIcons.info,
                      menuName: main_menu_about,
                      color: Color(0xffe11586),
                      action: () => Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AboutPage()),
                      ),
                    ),
                    SingleMenu(
                      icon: FontAwesomeIcons.signOutAlt,
                      menuName: 'Keluar',
                      color: Color(0xffe11586),
                      action: () => _signOut(),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
