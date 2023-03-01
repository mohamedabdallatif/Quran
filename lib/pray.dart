
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pray_times/pray_times.dart';
import 'package:quran/components/pray_widget.dart';
class PrayTimesPage extends StatefulWidget {
  const PrayTimesPage({super.key});


  @override
  State<PrayTimesPage> createState() => _PrayTimesPageState();
}
late List<String> prayerTimes;
late List<String> prayerNames;
class _PrayTimesPageState extends State<PrayTimesPage> {
  getMyLocation()async{
double latitude =await GetLocation().getLocation(1);
  double longitude =await GetLocation().getLocation(0);
  double timezone = 2;
  
  PrayerTimes prayers =  PrayerTimes();
  prayers.setTimeFormat(prayers.Time24);
  prayers.setCalcMethod(prayers.MWL);
  prayers.setAsrJuristic(prayers.Shafii);
  prayers.setAdjustHighLats(prayers.AngleBased);
  var offsets = [0, 0, 0, 0, 0, 0, 0];
  prayers.tune(offsets);

  final date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
   prayerTimes =
  prayers.getPrayerTimes(date, latitude, longitude, timezone);
  prayerNames = prayers.getTimeNames();

  for (int i = 0; i < prayerTimes.length; i++) {
    print("${prayerNames[i]} - ${prayerTimes[i]}");
  }
}
@override
  void initState() {
    checkGPSEnable();
    checkGPSPermission();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('مواعيد الصلاة' 
       , style: TextStyle(
        fontSize: 20
       ),
          ),
      ),
      body:FutureBuilder (
        future: getMyLocation(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator());
          }
          return Column(
            children: [
          for (int i = 0; i < prayerTimes.length; i++)
           prayShape(prayerNames[i],prayerTimes[i])
        ],
        );
         },
        
      ) 
      
    );
    
  }
  
}

checkGPSEnable()async{
  bool servicestatus = await Geolocator.isLocationServiceEnabled();

if(servicestatus){
   print("GPS service is enabled");
}else{
   print("GPS service is disabled.");
}
}
checkGPSPermission()async{
LocationPermission permission = await Geolocator.checkPermission();

if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
        print('Location permissions are denied');
    }else if(permission == LocationPermission.deniedForever){
        print("'Location permissions are permanently denied");
    }else{
        print("GPS Location service is granted");
    }
}else{
    print("GPS Location permission granted.");
}
}
class GetLocation{
 
  getLocation(m)async{
  double long=0.0,lat=0.0;
   var  position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   long = position.longitude;
   lat = position.latitude;
   if(m==0){
    return long;
   }
   else if(m==1){
    return lat;
   }
}
}

