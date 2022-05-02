import 'package:code_aware/controller/theme_model.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  late ThemeModel themeNotifier;
  AboutUs(ThemeModel themeModel) {
    this.themeNotifier = themeModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeNotifier.isDark
          ? ThemeData.dark().backgroundColor
          : Colors.white,
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: themeNotifier.isDark ? Colors.white : Colors.black,
          ),
          backgroundColor: themeNotifier.isDark
              ? ThemeData.dark().backgroundColor
              : Colors.white,
          title: Text(
            "About Us",
            style: TextStyle(
                color: themeNotifier.isDark ? Colors.white : Colors.black),
          )),
      body: MyStatefulWidget(themeNotifier),
    );
  }
}

class Item {
  Item({
    required this.expandedValue,
    required this.headerValue,
    this.isExpanded = false,
  });

  String expandedValue;
  String headerValue;
  bool isExpanded;
}

List<Item> generateItems() {
  List<Item> list = [];
  Item item = Item(
      expandedValue: '''CodeAware 
    A personalized application to get aware of every contest and hackathons from multiple platforms.''',
      headerValue: 'INTRODUCTION');
  Item item1 = Item(
      expandedValue:
          '''1)View contests and hackathons  in chronological order and platform-wise.
2)Get to know about all contests and hackathons.
3)You can find your ratings too.
4)Differentiate between the live, today and upcoming contests and hackathons.
5)All time zones are supported.
6)Set reminders to the contests and hackathons.
7)Can visit the contest(or hackathon) page directly from the app.

        ''',
      headerValue: 'FEATURES');
  Item item2 = Item(expandedValue: '''
    ->firebase_icons
    ->firebase_auth
    ->google_sign_in
    ->cloud_firestore
    ->firebase_database
    ->firebase_messaging
    ->flutter_local_notification
    ->animated_splash_screen
    ->page_transition
    ->introduction_screen
    ->google_nav_bar
    ->image_picker
    ->url_launcher
    
    
    ''', headerValue: 'LIBARIES AND PACKAGES');
  Item item3 = Item(
      expandedValue:
          '''WE USEING FREE RESOURCES FOR THE DEVEPLOMENT PURPOSE THEIR ARE AS FOLLOWING
    FOR IMAGE
    =>https://www.freepik.com
    =>https://www.vecteezy.com
    FOR ICONS
    =>https://iconset.io/
     ''',
      headerValue: 'ATTRIBUTION');
  list.add(item);
  list.add(item1);
  list.add(item2);
  list.add(item3);
  return list;
}

class MyStatefulWidget extends StatefulWidget {
  late ThemeModel themeNotifier;
  MyStatefulWidget(ThemeModel themeModel) {
    this.themeNotifier = themeModel;
  }

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  final List<Item> _data = generateItems();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: widget.themeNotifier.isDark
            ? ThemeData.dark().backgroundColor
            : Colors.white,
        child: _buildPanel(),
      ),
    );
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        return ExpansionPanel(
          backgroundColor: widget.themeNotifier.isDark
              ? ThemeData.dark().backgroundColor
              : Colors.white,
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(
                item.headerValue,
                style: TextStyle(
                    color: widget.themeNotifier.isDark
                        ? Colors.white
                        : Colors.black),
              ),
            );
          },
          body: ListTile(
            title: Text(
              item.expandedValue,
              style: TextStyle(
                color:
                    widget.themeNotifier.isDark ? Colors.white : Colors.black,
              ),
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}
