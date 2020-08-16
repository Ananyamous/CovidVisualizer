import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';



class SafeWidget  {
  int  random = 0;
  String safeImagePath = "";
  ImageProvider safeImageProvider = null;
  Widget display;

  SafeWidget(int rnd, String imgPath) {
    print('Creating Safe Widget ' + imgPath );
    random = rnd;
    safeImagePath = imgPath;
    safeImageProvider = FileImage(File(safeImagePath));
    display =   new Expanded(
      child: Container(
          color: Colors.green,
          height: 100,
          child: Column(
              children:[
                Text("")
//                Text("Random Number" + random.toString())
                ,
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: safeImageProvider,
                        fit: BoxFit.cover,
                      )
                  ),
                ),
              ]
          )
      ),
    );

  }
}
