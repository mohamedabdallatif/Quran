
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart' hide TextDirection;
import 'package:pray_times/pray_times.dart';
import 'package:quran/components/pray_widget.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:quran/to_arabic.dart';

class PrayTimesPage extends StatefulWidget {
  const PrayTimesPage({super.key});
  @override
  State<PrayTimesPage> createState() => _PrayTimesPageState();
}
late List<String> prayerTimes;
late List<String> prayerNames;
late String formatted;
class _PrayTimesPageState extends State<PrayTimesPage> {
  
  
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
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder (
          future: getMyLocation(),
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator());
            }
            return Column(
              textDirection: TextDirection.rtl,
              children: [
                Row(
                  textDirection: TextDirection.rtl,
                 children: [
                 //     Text(DateTime.now().timeZoneName),
                 Text(formatted,
                 style:const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w300
                 ),)
                ],
                ),
                const SizedBox(height: 10,),
       //     for (int i = 0; i < prayerTimes.length; i++)
             prayShape('الفجر',prayerTimes[0].toArabicNumbers),
             prayShape('شروق الشمس',prayerTimes[1].toArabicNumbers),
             prayShape('الظهر',prayerTimes[2].toArabicNumbers),
             prayShape('العصر',prayerTimes[3].toArabicNumbers),
             prayShape('المغرب',prayerTimes[5].toArabicNumbers),
             prayShape('العشاء',prayerTimes[6].toArabicNumbers)

          ],
          );
           },
          
        ),
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
late double latitude;
late double longitude;
getMyLocation()async{
  var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
   latitude =position.latitude;
    longitude=position.longitude;
 
  double timezone = DateTime.now().timeZoneOffset.inHours.toDouble();

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
  initializeDateFormatting("ar_SA", null).then((_) {
      var now = DateTime.now();
      var formatter = DateFormat.yMMMd('ar_SA');
      formatted = formatter.format(now);
    });
}

 


