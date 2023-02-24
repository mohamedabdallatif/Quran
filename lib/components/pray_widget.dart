import 'package:flutter/material.dart';

Widget prayShape(snapshot,String name,type){
 return Column(
  children: [
    Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(40, 0, 40, 0),
                  ),
                  
                  child: Row(
                   textDirection: TextDirection.rtl,
                    children: [
                       Text(type,
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
  ],
 );
}