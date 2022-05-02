import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../controller/theme_model.dart';
import '../../../model/notification/notification_service.dart';

class ContestPage extends StatefulWidget {
  final String start;
  final String time;
  final String duration;
  final String status;
  final String url;
  final String icon;
  final String name;

  const ContestPage({
    Key? key,
    required this.start,
    required this.time,
    required this.duration,
    required this.status,
    required this.url,
    required this.icon,
    required this.name,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyContestPage();
}

class MyContestPage extends State<ContestPage> {
  User? user = FirebaseAuth.instance.currentUser;
  IconData favIcon = Icons.favorite_border_outlined;
  IconData notifyIcon = Icons.notifications_active_outlined;

  int time = 0;
  Future<dynamic> notify() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text(
              "Choose time",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 45, 28, 71)),
            ),
            children: [
              SimpleDialogOption(
                onPressed: () {
                  time = 15;
                  print(widget.start + " " + widget.time + ":00");
                  NotificationService().scheduledNotification(
                      widget.start + " " + widget.time + ":00", time);
                  Navigator.pop(context);
                },
                child: const Text('15 minutes before'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  time = 30;
                  NotificationService().scheduledNotification(
                      widget.start + " " + widget.time + ":00", time);
                  Navigator.pop(context);
                },
                child: const Text('30 minutes before'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  time = 45;
                  NotificationService().scheduledNotification(
                      widget.start + " " + widget.time + ":00", time);
                  Navigator.pop(context);
                },
                child: const Text('45 minutes before'),
              ),
              SimpleDialogOption(
                onPressed: () {
                  time = 60;
                  NotificationService().scheduledNotification(
                      widget.start + " " + widget.time + ":00", time);
                  Navigator.pop(context);
                },
                child: const Text('60 minutes before'),
              ),
            ],
          );
        });
  }

  Widget actionMenu(ThemeModel themeNotifier) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: const Color.fromARGB(174, 255, 255, 255),
          boxShadow: const [
            BoxShadow(
              color: Color.fromARGB(62, 0, 0, 0),
            )
          ]),
      height: MediaQuery.of(context).size.height * 0.45,
      width: MediaQuery.of(context).size.width * 0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
              onPressed: () async {
                if (await launch(widget.url)) {
                } else {
                  throw "Could not launch : " + widget.url;
                }
              },
              icon: const Icon(Icons.pin_invoke_sharp),
              color: themeNotifier.isDark
                  ? Colors.white
                  : Color.fromARGB(255, 55, 35, 92)),
          IconButton(
              onPressed: () {
                if (widget.status == "Live") {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return const SimpleDialog(
                          title: Text("Contest is already live."),
                        );
                      });
                } else {
                  notify();
                }
                setState(() {
                  if (notifyIcon == Icons.notifications_active_outlined) {
                    notifyIcon = Icons.notifications_active;
                  } else {
                    notifyIcon = Icons.notifications_active_outlined;
                  }
                });
              },
              icon: Icon(
                notifyIcon,
                color: const Color.fromARGB(255, 45, 28, 71),
              ))
        ],
      ),
    );
  }

  Widget detailCard(ThemeModel themeNotifier) {
    return Card(
        elevation: 10,
        shadowColor: const Color.fromARGB(255, 255, 255, 255),
        margin: const EdgeInsets.fromLTRB(5, 15, 5, 10),
        color: themeNotifier.isDark
            ? ThemeData.dark().backgroundColor
            : Colors.white,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(widget.name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: themeNotifier.isDark
                          ? Color.fromARGB(255, 0, 255, 255)
                          : Color.fromARGB(255, 45, 28, 71),
                      fontSize: 16)),
              Text(
                "Start : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeNotifier.isDark
                      ? Color.fromARGB(255, 255, 255, 255)
                      : Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Text("      " + widget.start,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: themeNotifier.isDark
                        ? Color.fromARGB(255, 255, 255, 255)
                        : Color.fromARGB(255, 0, 0, 0),
                  )),
              Text(
                "Time : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeNotifier.isDark
                      ? Color.fromARGB(255, 255, 255, 255)
                      : Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Text("      " + widget.time,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: themeNotifier.isDark
                        ? Color.fromARGB(255, 255, 255, 255)
                        : Color.fromARGB(255, 0, 0, 0),
                  )),
              Text(
                "Duration : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeNotifier.isDark
                      ? Color.fromARGB(255, 255, 255, 255)
                      : Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Text("      " + widget.duration,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: themeNotifier.isDark
                        ? Color.fromARGB(255, 255, 255, 255)
                        : Color.fromARGB(255, 0, 0, 0),
                  )),
              Text(
                "Status : ",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: themeNotifier.isDark
                      ? Color.fromARGB(255, 255, 255, 255)
                      : Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              Text("      " + widget.status,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: themeNotifier.isDark
                        ? Color.fromARGB(255, 255, 255, 255)
                        : Color.fromARGB(255, 0, 0, 0),
                  )),
            ],
          ),
        ));
  }

  Widget introSection(ThemeModel themeNotifier) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(widget.icon),
            backgroundColor: Colors.transparent,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          (widget.name.length > 15)
              ? widget.name.substring(0, 15) + "..."
              : widget.name,
          style: TextStyle(
            fontFamily: "Comfortaa",
            fontSize: 18,
            color: themeNotifier.isDark
                ? Color.fromARGB(255, 0, 255, 255)
                : Color.fromARGB(255, 45, 28, 71),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
          builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
            appBar: AppBar(
              title: Text((widget.name.length > 15)
                  ? widget.name.substring(0, 15) + "..."
                  : widget.name),
              backgroundColor: themeNotifier.isDark
                  ? ThemeData.dark().backgroundColor
                  : Colors.white,
              titleTextStyle: TextStyle(
                  color: themeNotifier.isDark
                      ? Color.fromARGB(255, 0, 255, 255)
                      : Color.fromARGB(255, 45, 28, 71)),
              iconTheme: IconThemeData(
                  color: themeNotifier.isDark ? Colors.white : Colors.black),
            ),
            body: Container(
                decoration: BoxDecoration(
                    color: themeNotifier.isDark
                        ? ThemeData.dark().backgroundColor
                        : Colors.white),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    introSection(themeNotifier),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        detailCard(themeNotifier),
                        actionMenu(themeNotifier),
                      ],
                    )
                  ],
                )));
      }),
    );
  }
}
