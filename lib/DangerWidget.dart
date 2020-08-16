import 'package:Weapon_Detect/SendEmail.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';



class DangerWidget  {
  int  random = 0;
  String dangerImagePath = "";
  ImageProvider dangerImageProvider = null;
  Widget display;
  static Position currentPosition;
  static String googleMapsUrl;

  DangerWidget(int rnd, String imgPath) {
    print('Creating Danger Widget ' + imgPath );
    random = rnd;
    dangerImagePath = imgPath;
    dangerImageProvider = FileImage(File(dangerImagePath));
    //Position _currentPosition;
    //var googleMapsUrl = null;

    SendEmail.sendEmail(
        toEmail: 'gottum_m@hotmail.com'
        , bccEmail: 'murali.online@hotmail.com'
        , subject: 'Alert: Weapon Detected'
        , body: 'A weapon has been detected '
        '<br/>Picture in the attachment'
        '<br/>Location: <a href="${googleMapsUrl}">Map Link</a>'
        '<br/><iframe src="${googleMapsUrl}" height="300" width="800"></iframe>'
        , atchPath: imgPath
      );
    display =   new Expanded(
      child: Container(
          color: Colors.red,
          height: 100,
          child: Column(
              children:[
                Text("")
//                Text("Random Number = " + random.toString())
                ,
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        image: dangerImageProvider,
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
