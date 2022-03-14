import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  @override
  Widget build(BuildContext context) {
    // const bluemagneta = const Color(0xff6200EE);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: <Widget>[
            imageProfile(context),
            SizedBox(
              height: 20,
            ),
            Text('USERNAME', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),textAlign: TextAlign.center,),
            ListTile(
              leading: Icon(
                Icons.person,color: Colors.teal[900],
              ),
              title: Text('Account Info', style: TextStyle(fontFamily: 'BalsamiqSans', fontSize: 20.0),),
            ),
            // color: Colors.white,
            // margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
            ListTile(
              leading: Icon(
                Icons.bar_chart_sharp,color: Colors.teal[900],
              ),
              title: Text('Your Ratings', style: TextStyle(fontFamily: 'BalsamiqSans', fontSize: 20.0),),
            ),
            ListTile(
              leading: Icon(
                Icons.grid_on_sharp,color: Colors.teal[900],
              ),
              title: Text('Themes', style: TextStyle(fontFamily: 'BalsamiqSans', fontSize: 20.0),),
            ),
            ListTile(
              leading: Icon(
                Icons.badge_sharp,color: Colors.teal[900],
              ),
              title: Text('Platform ids', style: TextStyle(fontFamily: 'BalsamiqSans', fontSize: 20.0),),
            ),
            ListTile(
              leading: Icon(
                Icons.logout,color: Colors.teal[900],
              ),
              title: Text('Logout', style: TextStyle(fontFamily: 'BalsamiqSans', fontSize: 20.0),),
            )
          ],
        ),
      ),
    );;
  }
}


Widget imageProfile(BuildContext context) {
  return Center(
    child: Stack(
      children: <Widget>[
        CircleAvatar(
          radius: 80.0,
          backgroundImage: AssetImage("assets/profile.png"),
        ),
        Positioned(
          bottom: 20.0,
          right: 20.0,
          child: InkWell(
            onTap: () {
              // showBottomSheet(context: context, builder: (builder)=>(bottomSheet(context)),

            },
            child: Icon(
              Icons.edit,
              color: Colors.black,
              size: 28,
            ),
          ),
        )
      ],
    ),
  );
}

