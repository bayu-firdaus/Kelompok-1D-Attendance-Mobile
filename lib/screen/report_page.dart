import '../database/db_helper.dart';
import '../model/attendance.dart';
import '../utils/strings.dart';
import 'package:flutter/material.dart';

class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  DbHelper dbHelper = DbHelper();
  Future<List<Attendance>> attendances;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    if (mounted) {
      setState(() {
        attendances = dbHelper.getAttendances();
      });
    }
  }

  SingleChildScrollView dataTable(List<Attendance> attendances) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                report_date,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                report_time,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                report_type,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                report_location,
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: attendances
              .map(
                (attendance) => DataRow(cells: [
                  DataCell(
                    Text(
                        attendance.date,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(
                      attendance.time,
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(
                        attendance.type,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                  DataCell(
                    Text(
                        attendance.location,
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              )
              .toList(),
        ),
      ),
    );
  }

  list() {
    return Expanded(
      child: FutureBuilder(
        future: attendances,
        builder: (context, snapshot) {
          if (null == snapshot.data || snapshot.data.length == 0) {
            return Center(child: Text(
                report_no_data,
                style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ));
          }

          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff242559),
      appBar: AppBar(
        title: Text(report_title),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
              list(),
          ],
        ),
      ),
    );
  }
}
