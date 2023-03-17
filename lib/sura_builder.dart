import 'package:flutter/material.dart';
import 'package:quran/constants.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

 ItemScrollController itemScrollController =ItemScrollController();
 ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

class SuraBuilder extends StatefulWidget {
final sura;
final arabic;
final suraName;
int ayah;
   SuraBuilder({super.key, this.sura, this.arabic, this.suraName,required this.ayah});

  @override
  State<SuraBuilder> createState() => _SuraBuilderState();
}

class _SuraBuilderState extends State<SuraBuilder> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) =>jumpToAyah());
    super.initState();
  }
  jumpToAyah(){
  if(fabIsClicked){
    itemScrollController.scrollTo(index: widget.ayah,
     duration: const Duration(seconds: 2)
     ,curve: Curves.easeInOutCubic);
  }
  fabIsClicked=false;
}
  
  Row verseBuilder(int index,pre){
   return Row(
    children: [
      Expanded(
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              widget.arabic[index+pre]['aya_text'],
              textDirection: TextDirection.rtl ,
              style: TextStyle(
                fontSize:arabicFontSize ,
                fontFamily: arabicFont,
                color: const Color.fromARGB(196, 0, 0, 0)
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
              ],
            )
          ],
        )
         )
    ],
   );
  }
 
 SafeArea SingleSuraBuilder(LengthOfSura){
  String fullSura='';
  int previosVerses=0;
  if(widget.sura+1!=1){
    for(int i=widget.sura-1;i>=0;i--){
      previosVerses=previosVerses+noOfVerses[i];
    }
  }
  if(!view){
    for(int i=0;i<LengthOfSura;i++){
      fullSura +=(widget.arabic[i+previosVerses]['aya_text']);
    }
  }
  return SafeArea(
    child: Container(
      color: const Color.fromARGB(255, 253, 251, 240),
      child: view
      ? ScrollablePositionedList.builder(
        itemScrollController: itemScrollController,
        itemPositionsListener: itemPositionsListener,
        itemCount:LengthOfSura ,
         itemBuilder: (BuildContext context,index){
          return Column(
            children: [
              (index!=0) || (widget.sura==0) || (widget.sura==8)
              ? const Text('')
              :const ReturnBasmala(),
              Container(
                color: index %2 !=0
                ? const Color.fromARGB(255, 253, 251, 240)
                :const Color.fromARGB(255, 253, 247, 230),
              child: PopupMenuButton(
                child:Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: verseBuilder(index, previosVerses),
                ) ,
                itemBuilder: (BuildContext context)=> [ 
                  PopupMenuItem(
                    onTap:()=> saveBookMark(widget.sura+1,index),
                    child:Row(
                      children: const [
                         Icon(
                          Icons.bookmark_add,
                          color: Color.fromARGB(255, 56, 115, 59),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text('BookMark')
                      ],
                    ) ,

                  ),
                  PopupMenuItem(
                    onTap: (){},
                    child:Row(
                      children: const [
                         Icon(Icons.share,color:Color.fromARGB(255, 56, 115, 59) ,),
                         SizedBox(width: 10,),
                         Text('Share')
                      ],
                    )
                     ,)
                ],
              ),
              )
            ],
          );
          

         }
         )
      : ListView(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment:CrossAxisAlignment.center ,
                  children: [
                    widget.sura+1!=1 && widget.sura+1!=9
                    ? const ReturnBasmala()
                    : const Text(''),
                     Padding(padding: const EdgeInsets.all(8.0)
                   , child: Text(
                    fullSura,
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: mushafFontSize,
                      fontFamily: arabicFont,
                      color: const Color.fromARGB(196, 44, 44, 44)
                    ),
                   ),
                   ),
                   

                  ],
                  )
                )
            ],
          )
        ],
      )
    )
    );
 }

 
  @override
  Widget build(BuildContext context) {
    int LengthOfSura=noOfVerses[widget.sura];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          leading: Tooltip(
            message: 'Mushaf mode',
            child: TextButton(
              child:const Icon(
                Icons.chrome_reader_mode,
                color: Colors.white,
              ) ,
              onPressed:() {
                setState(() {
                view=!view;
                saveView();
              });
              }
            ),
          ),
          centerTitle: true,
          title:  Text(widget.suraName,
          textAlign: TextAlign.center,
          style:const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontFamily: 'quran',
            shadows: [
              Shadow(
                offset: Offset(1,1),
                blurRadius: 2.0,
                color: Color.fromARGB(255, 0, 0, 0)
              )
            ]
          ),
          
          ),
          backgroundColor: const Color.fromARGB(255, 56, 115, 59),

        ),
        body: SingleSuraBuilder(LengthOfSura),
      ),
    );
  }
  
}
class ReturnBasmala extends StatelessWidget {
  const ReturnBasmala({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: const [
        Center(
          child: Text('بسم الله الرحمن الرحيم',
          style: TextStyle(
            fontFamily: 'me_quran'
            ,fontSize: 30
          ),
          textDirection: TextDirection.rtl,
          ),
          
        )
      ],
    );
  }
}
