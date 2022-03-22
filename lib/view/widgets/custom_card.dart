import 'package:flutter/material.dart';
import 'package:code_aware/model/fireStoreService.dart';

class CustomCard extends StatefulWidget{
  final String siteName;
  final String contestName;
  final String contestStartTime;
  final String contestEndTime;
  final String in24hrs;
  final String status;
  final String duration;

  const CustomCard({Key? key,
    required this.siteName,
    required this.contestName,
    required this.contestStartTime,
    required this.contestEndTime,
    required this.in24hrs,
    required this.status,
    required this.duration,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => MyCustomCard();

}

class MyCustomCard extends State<CustomCard> {

  IconData favIcon = Icons.favorite_border_outlined;
  IconData notifyIcon = Icons.notifications_active_outlined;

  String getStart(String start){
    String res = start.substring(0,10);
    return res;
  }

  String getTime(String time){
    String res;
    DateTime dateTime;
    if(time.contains("UTC")){
      String res = time.substring(0,19);
      dateTime = DateTime.parse(res);
      var utcTime = DateTime.utc(dateTime.year,dateTime.month,dateTime.day,
        dateTime.hour,dateTime.minute,dateTime.second,);
      dateTime = utcTime.toLocal();
    }else{
      res = time.substring(0,19);
      dateTime = DateTime.parse(res);
      dateTime = dateTime.toLocal();
    }
    res = dateTime.toString().substring(11,16);
    return res;
  }

  String getDuration(String duration){
    if(duration.contains(".")){
      int idx = duration.indexOf(".");
      duration = duration.substring(0,idx);
    }
    String res = '';
    int n = int.parse(duration);
    int day = n ~/ (24 * 3600);
    n = n % (24 * 3600);
    int hour = n~/3600;
    n %= 3600;
    int minutes = n~/60;
    if(day==0 && hour==0 && minutes!=0){
      res = minutes.toString() + " minutes";
    }else{
      if(day==0 && hour!=0 && minutes!=0){
        res = hour.toString() + " hours " + minutes.toString() + " minutes";
      }else{
        if(day!=0 && hour!=0 && minutes!=0){
          res = day.toString() + " days " + hour.toString() + " hours " +
              minutes.toString() + " minutes";
        }else{
          if(day==0 && hour!=0 && minutes==0){
            res = hour.toString() + " hours";
          }else{
            if(day!=0 && hour==0 && minutes==0){
              res = day.toString() + " days";
            }else{
              if(day!=0 && hour!=0 && minutes==0){
                res = day.toString() + " days " + hour.toString() + " hours";
              }else{
                if(day!=0 && hour==0 && minutes!=0){
                  res = day.toString() + " days " + minutes.toString() + " minutes";
                }
              }
            }
          }
        }
      }
    }
    return res;
  }

  String getStatus(String status, String in24hrs){
    String res = '';
    if(status=="BEFORE" && in24hrs=="Yes"){
      res = "About to Start";
    }

    if(status=="BEFORE" && in24hrs=="No"){
      res = "Upcoming";
    }

    if(status=="CODING"){
      res = "Live";
    }
    return res;
  }

  Widget showIcon(String site){
    String path = "assets/icons/"+site.toLowerCase().replaceAll(" ", "")+"Icon.png";
    return Image.asset(path,width: 0);
  }

  String getTitle(String name){
    int idx = name.indexOf('(');
    if(idx==-1){
      return name;
    }
    return name.substring(0,idx);
  }

  String getSubtitle(String name){
    int idx = name.indexOf('(');
    if(idx==-1){
      return "";
    }
    return name.substring(idx+1,name.length-1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      margin: const EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Text(getStatus(widget.status, widget.in24hrs),
            style: TextStyle(
              color: (getStatus(widget.status, widget.in24hrs))=="Live" ? Colors.green :
              getStatus(widget.status, widget.in24hrs)=="Upcoming" ?
              Colors.blueAccent : Colors.yellow,
              ),
            )
          ),
          Row(
            children:  <Widget>[
              Expanded(
                child: showIcon(widget.siteName),
              ),
              const SizedBox(width: 15,height: 1,),
              Expanded(
                flex: 4,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Text(getTitle(widget.contestName),
                      textAlign: TextAlign.left,
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(fontSize: 18),),
                    Text(getSubtitle(widget.contestName),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.fade,
                      style: const TextStyle(fontSize: 14),),
                  ],
                )
              ),
            ],
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(" Start       : "+ (getStart(widget.contestStartTime)),textAlign: TextAlign.left,
            style: TextStyle(),),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(" Time       : "+ (getTime(widget.contestStartTime)),textAlign: TextAlign.left,),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(" Duration : "+ getDuration(widget.duration),textAlign: TextAlign.left,),
          ),
          const SizedBox(height: 10,)
          // Row(
          //   children: [
          //     const Spacer(),
          //     IconButton(onPressed: (){
          //       setState(() {
          //         favIcon = Icons.favorite;
          //       });
          //       },
          //       icon: Icon(favIcon),
          //       alignment: Alignment.bottomRight,
          //       padding: const EdgeInsets.all(5),
          //     ),
          //     IconButton(onPressed: (){
          //       setState(() {
          //         notifyIcon = Icons.notifications_active;
          //       });
          //     },
          //       icon: Icon(notifyIcon),
          //       alignment: Alignment.bottomRight,
          //       padding: const EdgeInsets.all(5),
          //     )
          //   ],
          // )
        ],
      )
    );
  }
}
