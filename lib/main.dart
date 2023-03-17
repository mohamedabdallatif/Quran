
import 'package:flutter/material.dart';
import 'package:quran/constants.dart';
import 'package:quran/home_page.dart';
import 'package:quran/qibla_page.dart';
import 'package:quran/qiblah_compass.dart';
 void main(List<String> args) {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const QuranApp());
}

class QuranApp extends StatefulWidget {
  const QuranApp({super.key});

  @override
  State<QuranApp> createState() => _QuranAppState();
}

class _QuranAppState extends State<QuranApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async{ 
      await readjson();
      await getSettings();
      await getView();
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
return MaterialApp(
  debugShowCheckedModeBanner: false,
      title: 'Quran',
      theme: ThemeData(
        primarySwatch: Colors.teal
      ),
     routes: {
      'qebla_page':(context) => const QiblaPage()
     },
      
     
      home: const HomePage(),
      );
  }
}