class Contest{
  final String contestName;
  final String startTime;
  final String endTime;
  final String siteName;
  final String status;
  final String in24hrs;
  final String duration;
  final String url;

  Contest({required this.contestName,required this.startTime,required this.endTime,
    required this.siteName,required this.in24hrs,required this.duration,
    required this.status,required this.url});

  factory Contest.fromRTDB(Map<String,dynamic> data){
    return Contest(
      contestName : data['name'],
      startTime : data['start_time'],
      endTime : data['end_time'],
      siteName: data['site'],
      in24hrs: data['in_24_hours'],
      duration : data['duration'],
      status : data['status'],
      url : data['url']
    );
  }
}