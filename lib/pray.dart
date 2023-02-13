import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
class PrayTimesPage extends StatefulWidget {
  const PrayTimesPage({super.key});


  @override
  State<PrayTimesPage> createState() => _PrayTimesPageState();
}

class _PrayTimesPageState extends State<PrayTimesPage> {
    late Future<PrayData> futureData;
      var dropdownvalue ='cairo';


Future<PrayData> fetchData() async {
  final response = await http
      .get(Uri.parse('https://dailyprayer.abdulrcs.repl.co/api/'+dropdownvalue));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return PrayData.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load Data');
  }
}
  @override
  void initState() {
    futureData=fetchData();
    super.initState();
  }
  var cities=[
    'cairo',
    'alex',
    'aswan'
  ];
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
      body: FutureBuilder(
      future: futureData,
      builder: (context,snapshot){
        if (snapshot.hasData){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                Row(
                     textDirection: TextDirection.rtl,
                  children: [
                    const Text('اختر المدينة',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                    ),
                   const SizedBox(
                      width: 10,
                    ),
                    DropdownButton(
                      value: dropdownvalue ,
                      items: cities.map((String cities) {
                        return DropdownMenuItem(
                          value: cities,
                          child: Text(cities));
                      }).toList(),
                       onChanged:(String? newVal){
                        setState(() {
                          dropdownvalue =newVal!;
                        });
                       } )
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(40, 0, 40, 0),
                  ),
                  
                  child: Row(
                   textDirection: TextDirection.rtl,
                    children: [
                       Text(snapshot.data!.fajr,
                      style: const TextStyle(
                        color: Colors.teal,
                        fontSize: 30
                      ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text('الفجر',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 30,
                      ),
                      ),
                     
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                  Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(40, 0, 40, 0),
                  ),
                  
                  child: Row(
                   textDirection: TextDirection.rtl,
                    children: [
                       Text(snapshot.data!.sunrise,
                      style: const TextStyle(
                        color: Colors.teal,
                        fontSize: 30
                      ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text('شروق الشمس',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 30,
                      ),
                      ),
                     
                    ],
                  ),
                ),
            const SizedBox(
              height: 20,
            ),
             Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(40, 0, 40, 0),
                  ),
                  
                  child: Row(
                   textDirection: TextDirection.rtl,
                    children: [
                       Text(snapshot.data!.dhuhr,
                      style: const TextStyle(
                        color: Colors.teal,
                        fontSize: 30
                      ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text('الظهر',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 30,
                      ),
                      ),
                     
                    ],
                  ),
                ),
            const SizedBox(
              height: 20,
            ),
            
           Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(40, 0, 40, 0),
                  ),
                  
                  child: Row(
                   textDirection: TextDirection.rtl,
                    children: [
                       Text(snapshot.data!.asr,
                      style: const TextStyle(
                        color: Colors.teal,
                        fontSize: 30
                      ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text('العصر',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 30,
                      ),
                      ),
                     
                    ],
                  ),
                ),
        const SizedBox(
          height: 20,
         ),
             Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(40, 0, 40, 0),
                  ),
                  
                  child: Row(
                   textDirection: TextDirection.rtl,
                    children: [
                       Text(snapshot.data!.maghrib,
                      style: const TextStyle(
                        color: Colors.teal,
                        fontSize: 30
                      ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text('المغرب',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 30,
                      ),
                      ),
                     
                    ],
                  ),
                ),
           const SizedBox(
            height: 20,
           ) ,
           Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(40, 0, 40, 0),
                  ),
                  
                  child: Row(
                   textDirection: TextDirection.rtl,
                    children: [
                       Text(snapshot.data!.ishaa,
                      style: const TextStyle(
                        color: Colors.teal,
                        fontSize: 30
                      ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const Text('العشاء',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: 30,
                      ),
                      ),
                     
                    ],
                  ),
                ), 
              ],
            ),
          );
        }
        else if (snapshot.hasError){
          return Text('${snapshot.error}');
        }
            return  Center(child: const CircularProgressIndicator(),) ;
      }
      ),
    );
    
  }
  
}
class PrayData {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib; 
  final String ishaa;


  const PrayData({
    required this.fajr,
    required this.sunrise,
    required this.dhuhr,
    required this.asr,
    required this.maghrib,
    required this.ishaa,
  });

  factory PrayData.fromJson(Map<String, dynamic> json) {
    return PrayData(
      fajr: json['today']['Fajr'],
      sunrise: json['today']['Sunrise'],
      dhuhr: json['today']['Dhuhr'],
      asr: json['today']['Asr'],
      maghrib: json['today']['Maghrib'],
      ishaa: json['today']["Isha'a"]
    );
  }
}


