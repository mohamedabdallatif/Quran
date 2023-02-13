import 'package:flutter/material.dart';
import 'package:quran/constants.dart';
import 'package:quran/settings.dart';
import 'package:url_launcher/url_launcher.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
           DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.white
            ),
            child: Column(
              children: [
                Image.asset('assets/images/quran.png',height: 80,),
                const Text('Al Quran',style: TextStyle(fontSize: 20),)
              ],
            ),
             ),
              ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings(),));
              },
             ),
             ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: (){
              //  Share.share('''Quran App\nshare it from my github''');
                Navigator.pop(context);
              },
             ),
             ListTile(
              leading: const Icon(
                Icons.rate_review
              ),
              title: const Text('Rate'),
              onTap: () async {
                if(!await launchUrl(quranAppUrl,
                mode: LaunchMode.externalApplication)){
                  throw 'could not launch $quranAppUrl';
                }
              },
             )
        ],
      ),
    );
  }
}