import 'package:flutter/material.dart';
import 'package:quran/index_page.dart';
import 'package:quran/mydrawer.dart';
import 'package:quran/pray.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        drawer: const MyDrawer(),
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            'My Quran',
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Container(
          color: Colors.white,
          padding: const EdgeInsets.only(
            top: 60,
            left: 15,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const IndexPage()));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            image: const DecorationImage(
                                image: AssetImage('assets/images/quran1.png'),
                                scale: 0.5,
                                alignment: Alignment.topCenter),
                            color: Colors.indigo,
                            borderRadius: BorderRadius.circular(20)),
                        width: 150,
                        height: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              'قرآن',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        )
                        ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  TextButton(
                    onPressed: (){
                      Navigator.push(context, 
                      MaterialPageRoute(builder: (context)=>PrayTimesPage()));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(top: 60),
                      decoration: BoxDecoration(
                         image: const DecorationImage(
                          image: AssetImage('assets/images/ramadan.png'),
                          alignment: Alignment.topCenter
                          ),
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(10)
                          ),
                      width: 100,
                      height: 200,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [
                            Text(
                              'مواقيت الصلاة',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                          ],
                        )
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(10)),
                    width: 100,
                    height: 100,
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.black87,
                        borderRadius: BorderRadius.circular(10)),
                    width: 100,
                    height: 100,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
