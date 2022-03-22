import 'package:flutter/material.dart';

import '../screens/in_app_screens/contest_page.dart';

class CustomTile extends StatelessWidget {
  final String contestName;
  final DateTime contestStartTime;
  final DateTime contestEndTime;
  final String status;
  final String duration;
  // final GestureTapCallback onPressed;


  const CustomTile({Key? key,
    required this.contestName,
    // required this.onPressed,
    required this.contestStartTime,
    required this.contestEndTime,
    required this.status,
    required this.duration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Column(
          children: [
            Row(
              children:  <Widget>[
                const Expanded(
                  child: FittedBox(
                    fit: BoxFit.contain, // otherwise the logo will be tiny
                    child: FlutterLogo(),
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.topRight,
                  child: Text(status),
                ),
              ],
            ),
            Expanded(
              child: Text(contestName, textAlign: TextAlign.center),
            ),
            Text("Starting: "+ contestStartTime.toString()),
            Text("Duration: "+ duration),
            Row(
              children: [
                TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder:(context)=>const ContestPage()));
                }, child: const Text("View Details")),
                const Spacer(),
                IconButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder:(context)=>const ContestPage()));
                }, icon: const Icon(Icons.alarm_add)),
              ],
            )
          ],
        )
    );
  }
}
