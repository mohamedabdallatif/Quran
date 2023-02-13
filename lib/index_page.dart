import 'package:flutter/material.dart';
import 'package:quran/arabic_sura_number.dart';
import 'package:quran/constants.dart';
import 'package:quran/mydrawer.dart';
import 'package:quran/sura_builder.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Go to bookmarked',
        backgroundColor: Colors.teal,
        onPressed: ()async{
          fabIsClicked=true;
          if(await readBookMark()==true){
            Navigator.push(context, 
            MaterialPageRoute(builder: (context)=>SuraBuilder(
              arabic: quran[0],
              sura: bookMarkedSura - 1,
              suraName: arabicName[bookMarkedSura-1]['name'],
              ayah: bookMarkedAyah,

            )));
          }
        },
        child: const Icon(Icons.bookmark),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Quran',
        style: TextStyle(
          fontSize: 35,
          fontWeight: FontWeight.bold,
          shadows: [
            Shadow(
              offset: Offset(1,1),
              blurRadius: 2,
              color: Color.fromARGB(255, 0, 0, 0)
            )
          ]
        ),
        ),
        backgroundColor: const Color.fromARGB(255, 56, 115, 59),
      ),
      body: FutureBuilder(
        future: readjson(),
        builder: (context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            return const Center(child: CircularProgressIndicator(),);
          }
          else if(snapshot.connectionState==ConnectionState.done){
            if(snapshot.hasError){
              return const Text('Error ');
            }
            else if(snapshot.hasData){
              return indexCreator(snapshot.data,context);

            }
            else{
              return const Text('Empty Data');
            }
          }
          else{
            return Text('State: ${snapshot.connectionState}');
          }
        },
      ),
    );
  }
  Container indexCreator(quran,context){
    return Container(
      color: const Color.fromARGB(255, 221, 250, 236),
      child: ListView(
        children: [
          for(int i=0;i<114;i++)
            Container(
              color: i%2==0
              ? const Color.fromARGB(255, 253, 247, 230)
              :const Color.fromARGB(255, 253, 251, 240),
              child: TextButton(
                child: Row(
                  children: [
                    ArabicSuraNumber(i: i),
                    const SizedBox(
                      width: 5,
                    ),
                     Padding(padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [],
                    ),
                    ),
                    const Expanded(child: SizedBox()),
                    Text(arabicName[i]['name'],
                    style: const TextStyle(
                      fontFamily: 'quran',
                      fontSize: 30,
                      color: Colors.black87,
                      shadows: [
                        Shadow(
                          offset: Offset(0.5, 0.5),
                          blurRadius:1 ,
                          color: Color.fromARGB(255, 130, 130, 130)
                        )
                      ]
                    ),
                    textDirection: TextDirection.rtl,
                    ),
                    
                  ],
                ),
                onPressed: (){
                  fabIsClicked=false;
                  Navigator.push(context,
                  MaterialPageRoute(
                    builder: (context)=>SuraBuilder(
                      arabic: quran[0],
                      sura:i,     
                      suraName: arabicName[i]['name'],
                      ayah: 0,
                    )
                     )
                     );
                },
              ),
            )
          
        ],
      ),
    );
  }
}