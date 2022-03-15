import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String contestName;
  final DateTime contestStartTime;
  final DateTime contestEndTime;
  final String status;
  final String duration;
  final GestureTapCallback onPressed;


  const CustomCard({Key? key,
    required this.contestName,
    required this.onPressed,
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
                TextButton(onPressed: onPressed, child: const Text("View Details")),
                const Spacer(),
                IconButton(onPressed: onPressed, icon: const Icon(Icons.alarm_add)),
              ],
            )
          ],
        )
    );
  }
}
