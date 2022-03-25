import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:code_aware/model/fireStoreService.dart';

class ContestPage extends StatefulWidget{
  final String start;
  final String time;
  final String duration;
  final String status;
  final String url;
  final String icon;
  final String name;

  const ContestPage({Key? key, required this.start, required this.time,
    required this.duration, required this.status, required this.url,
    required this.icon, required this.name,}) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyContestPage();
}

class MyContestPage extends State<ContestPage>{
  User? user = FirebaseAuth.instance.currentUser;
  IconData favIcon = Icons.favorite_border_outlined;
  IconData notifyIcon = Icons.notifications_active_outlined;

  Widget actionMenu(){
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: const Color.fromARGB(174, 255, 255, 255),
        boxShadow: const [BoxShadow(color: Color.fromARGB(62, 0, 0, 0),)]
      ),
      height: MediaQuery.of(context).size.height*0.45,
      width: MediaQuery.of(context).size.width*0.15,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(onPressed: () async{
            if(await launch(widget.url)){
            }else{
              throw "Could not launch : " + widget.url;
            }
          }, icon: const Icon(Icons.pin_invoke_sharp)),
          IconButton(onPressed: (){
            setState(() {
              Map<String,dynamic> contest = {
                'contestName' : widget.name,
                'site' : widget.url,
                'start' : widget.start,
                'time' : widget.time,
                'duration' : widget.duration,
              };
              if(favIcon==Icons.favorite_border_outlined){
                favIcon = Icons.favorite;
              }else{
                favIcon = Icons.favorite_border_outlined;
              }
              FireStoreServices().addFavourites(user?.uid, contest);
            });
          }, icon: Icon(favIcon,color: const Color.fromARGB(255, 180, 52, 93),)),
          IconButton(onPressed: (){
            setState(() {
              if(notifyIcon==Icons.notifications_active_outlined){
                notifyIcon = Icons.notifications_active;
              }else{
                notifyIcon = Icons.notifications_active_outlined;
              }
            });
          }, icon: Icon(notifyIcon,color: const Color.fromARGB(255, 45, 28, 71),))
        ],
      ),
    );
  }

  Widget detailCard(){
    return Card(
      elevation: 10,
      shadowColor: const Color.fromARGB(255, 255, 255, 255),
      margin: const EdgeInsets.fromLTRB(5,15,5,10),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height*0.5,
        width: MediaQuery.of(context).size.width*0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(widget.name,style: const TextStyle(fontWeight: FontWeight.bold,
            color:Color.fromARGB(255, 45, 28, 71),fontSize: 16)
          ),
          const Text("Start : ",style: TextStyle(fontWeight: FontWeight.bold,
            color:Color.fromARGB(255, 0, 0, 0),),
          ),
          Text("      " + widget.start,style: const TextStyle(fontWeight: FontWeight.w400,
            color:Color.fromARGB(204, 45, 45, 45),)
          ),
          const Text("Time : ",style: TextStyle(fontWeight: FontWeight.bold,
            color:Color.fromARGB(255, 0, 0, 0),),
          ),
          Text("      " + widget.time,style: const TextStyle(fontWeight: FontWeight.w400,
            color:Color.fromARGB(204, 45, 45, 45),)
          ),
          const Text("Duration : ",style: TextStyle(fontWeight: FontWeight.bold,
            color:Color.fromARGB(255, 0, 0, 0),),
          ),
          Text("      " + widget.duration,style: const TextStyle(fontWeight: FontWeight.w400,
            color:Color.fromARGB(204, 45, 45, 45),)
          ),
          const Text("Status : ",style: TextStyle(fontWeight: FontWeight.bold,
            color:Color.fromARGB(255, 0, 0, 0),),
          ),
          Text("      " + widget.status,style: const TextStyle(fontWeight: FontWeight.w400,
            color:Color.fromARGB(204, 45, 45, 45),)
          ),
        ],
      ),
    )
    );
  }

  Widget introSection(){
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
        const SizedBox(height: 10,),
        Text((widget.name.length>15) ? widget.name.substring(0,15)+"..." :
        widget.name, style: const TextStyle(fontFamily: "Comfortaa",
            fontSize: 18,
            color:Color.fromARGB(255, 45, 28, 71),),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text((widget.name.length>15) ?
      widget.name.substring(0,15)+"..." : widget.name),
      backgroundColor: Colors.white,
      titleTextStyle: const TextStyle(color: Color.fromARGB(255, 45, 28, 71)),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Container(
      decoration: const BoxDecoration(color: Color.fromARGB(80, 255, 255, 255)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            introSection(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                detailCard(),
                actionMenu(),
              ],
            )
          ],
          )
      )
    );
  }
}