import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:code_aware/view/screens/in_app_screens/profile.dart';
import 'package:code_aware/model/rtdb/rtdb.dart';
import 'package:code_aware/view/widgets/custom_card.dart';
import 'package:provider/provider.dart';

import '../../../controller/theme_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyHomeScreen();
}

class MyHomeScreen extends State<HomeScreen> {
  final database = FirebaseDatabase.instance.ref();
  Icon viewIcon = const Icon(Icons.horizontal_split_sharp);
  Icon leftIcon = const Icon(Icons.border_vertical_sharp);
  int _selectedIndex = 0;

  Widget buildNavigationBar(ThemeModel themeNotifier) {
    return GNav(
      backgroundColor:
          themeNotifier.isDark ? ThemeData.dark().primaryColor : Colors.white,
      padding: const EdgeInsets.all(18),
      tabMargin: const EdgeInsets.fromLTRB(5, 0, 2, 5),
      gap: 5,
      tabs: [
        GButton(
          icon: Icons.home_outlined,
          text: "Home",
          active: true,
          curve: Curves.easeOut,
          iconColor: themeNotifier.isDark ? Colors.white : Colors.black,
          iconActiveColor:
              themeNotifier.isDark ? Colors.indigoAccent : Colors.indigo,
        ),
        GButton(
          icon: Icons.account_circle_outlined,
          text: "Profile",
          curve: Curves.easeOut,
          iconColor: themeNotifier.isDark ? Colors.white : Colors.black,
          iconActiveColor:
              themeNotifier.isDark ? Colors.indigoAccent : Colors.indigo,
        )
      ],
      activeColor: themeNotifier.isDark
          ? Colors.indigoAccent
          : Color.fromARGB(255, 63, 1, 118),
      selectedIndex: _selectedIndex,
      onTabChange: (index) {
        setState(() {
          _selectedIndex = index;
          print(_selectedIndex);
        });
      },
    );
  }

  Widget homeView() {
    return futureWidgets();
  }

  Widget futureWidgets() {
    return FirebaseAnimatedList(
        defaultChild: const Center(
            child: CircularProgressIndicator(
          color: Colors.indigo,
        )),
        query: database.child('contestData').orderByKey(),
        itemBuilder: (context, snapshot, animation, index) {
          final parent = Contest.fromRTDB(
              Map<String, dynamic>.from(snapshot.value as Map));
          return CustomCard(
            contestName: parent.contestName,
            contestStartTime: parent.startTime,
            contestEndTime: parent.endTime,
            status: parent.status,
            duration: parent.duration,
            siteName: parent.siteName,
            in24hrs: parent.in24hrs,
            url: parent.url,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeModel(),
      child: Consumer<ThemeModel>(
          builder: (context, ThemeModel themeNotifier, child) {
        return Scaffold(
          backgroundColor: themeNotifier.isDark
              ? ThemeData.dark().backgroundColor
              : Colors.white,
          body: (_selectedIndex == 0)
              ? homeView()
              : ProfilePage(themeNotifier).build(context),
          bottomNavigationBar: buildNavigationBar(themeNotifier),
        );
      }),
    );
  }
}
