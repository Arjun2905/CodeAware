import 'package:code_aware/view/widgets/custom_textform.dart';
import 'package:flutter/material.dart';
import '../../../controller/theme_model.dart';
import '../../../model/rating/platform_rating.dart';

class PlatformIdScreen extends StatefulWidget {
  String dropdownValue = 'None Selected';
  var items = [
    'None Selected',
    'CodeChef',
    'CodeForces',
    'AtCoder',
  ];
  late ThemeModel themeNotifier;
  PlatformIdScreen(ThemeModel themeModel) {
    this.themeNotifier = themeModel;
  }
  @override
  State<StatefulWidget> createState() => MyPlatformIdScreen();
}

class MyPlatformIdScreen extends State<PlatformIdScreen> {
  final TextEditingController platformUserIdController =
      TextEditingController();
  String platformUserId = "";
  String platformId = "";
  Map<String, String> platformData = {
    'CodeChef': "",
    'CodeForces': "",
    'AtCoder': "",
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: widget.themeNotifier.isDark
            ? ThemeData.dark().backgroundColor
            : Colors.white,
        body: ListView(
            // shrinkWrap: true,
            children: <Widget>[
              DropdownButton(
                value: widget.dropdownValue,
                dropdownColor: widget.themeNotifier.isDark
                    ? ThemeData.dark().backgroundColor
                    : Colors.white,
                icon: Icon(
                  Icons.keyboard_arrow_down,
                  color: widget.themeNotifier.isDark
                      ? Colors.white
                      : Colors.black, //change your color here
                ),
                items: widget.items.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(
                      items,
                      style: TextStyle(
                          color: widget.themeNotifier.isDark
                              ? Colors.white
                              : Colors.black),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.dropdownValue = newValue!;
                    platformId = newValue;
                  });
                },
              ),
              CustomTextForm(
                  prefixIcon: Icon(Icons.account_box_rounded),
                  color:
                      widget.themeNotifier.isDark ? Colors.white : Colors.black,
                  label: "Platform User Id",
                  hintText: "userId",
                  obscuretext: false,
                  onSaved: (value) {
                    // setState(() {
                    platformUserId = value.toString();
                    // });
                  },
                  controller: platformUserIdController,
                  textInputAction: TextInputType.text),
              Wrap(
                alignment: WrapAlignment.spaceAround,
                children: <Widget>[
                  // use Spacer
                  TextButton(
                      style: TextButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        primary: widget.themeNotifier.isDark
                            ? Colors.white
                            : Colors.black,
                        textStyle: TextStyle(fontSize: 16),
                      ),
                      onPressed: () {
                        print(platformId);
                        print(platformUserIdController.text);
                        showRating(
                            platformId, platformUserIdController.text, context);
                      },
                      child: Text(
                        'Add',
                        style: TextStyle(
                          color: widget.themeNotifier.isDark
                              ? Color.fromARGB(255, 11, 135, 147)
                              : Color.fromARGB(255, 45, 28, 71),
                        ),
                      )),
                  TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.all(16.0),
                      primary: widget.themeNotifier.isDark
                          ? Colors.white
                          : Colors.black,
                      textStyle: const TextStyle(fontSize: 16),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                        color: widget.themeNotifier.isDark
                            ? Color.fromARGB(255, 11, 135, 147)
                            : Color.fromARGB(255, 45, 28, 71),
                      ),
                    ),
                  ),
                ],
              )
            ]));
  }
}
