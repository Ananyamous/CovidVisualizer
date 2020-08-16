import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:Weapon_Detect/DangerWidget.dart';
import 'package:Weapon_Detect/SafeWidget.dart';
import 'package:Weapon_Detect/Location.dart';
//import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tflite/tflite.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';



var random = 0;
String emptyText = "";
String tempDir = "";
var recognitions;
var fileList = [];
var locations = [
  new Location(1, "Richmond VA", 37.5407, -77.4360, "Covid Data of Virginia. "
      "Confirmed COVID cases - 106,000 "
      "Deaths - 2381"
      "One Month Predicted Deaths - 2752 "
      "One Month Predicted Cases - 135,910")
  , new Location(2, "Albany NY", 42.6526, -73.7562, "Covid Data of New York. "
      "Confirmed COVID cases - 430,000 "
      "Deaths - 32,414 "
      "One Month Predicted Deaths - 33,020 "
      "One Month Predicted Cases - 450,010")
  , new Location(3, "Sydney, Australia", -33.8688, 151.2093, "Covid Data of Australia. "
      "Confirmed COVID cases - 23,050 "
      "Deaths - 379 "
      "One Month Predicted Deaths - 499 "
      "One Month Predicted Cases - 31,795")
  , new Location(4, "London, United Kingdom", 51.5074, -0.1278, "Covid Data of United Kingdom. "
      "Confirmed COVID Cases - 317,000 "
      "Deaths - 41,361 "
      "One Month Predicted Deaths - 42,861 "
      "One Month Predicted Cases - 394,070")
  , new Location(5, "Jakarta, Indonesia", -6.2088, 106.8456, "Covid Data of Indonesia. "
      "Confirmed COVID Cases - 137,000 "
      "Deaths - 6,071 "
      "One Month Predicted Deaths - 6,251 "
      "One Month Predicted Cases - 207,350")
];

Widget _displayWidget = Expanded(
  child: Container(
//      color: Colors.amber,
      height: 100,
      child: Text("")
  ),
);


class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {

//  CameraController controller;
  List cameras;
  int selectedCameraIdx;
  String imagePath;
  String res;
  final Map<String, Marker> _markers ={};

  @override
  void initState() {
    super.initState();

    /*
   availableCameras().then((availableCameras) {

     cameras = availableCameras;
     if (cameras.length > 0) {
       setState(() {
         // 2
         selectedCameraIdx = 0;
       });

       _initCameraController(cameras[selectedCameraIdx]).then((void v) {});
     }else{
       print("No camera available");
     }
   }).catchError((err) {
     // 3
     print('Error: $err.code\nError Message: $err.message');
   });
    */

//    getTempDir();

    /*
    {
      final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

      geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
          .then((Position position) {
        DangerWidget.currentPosition = position;
        print(position);
        print(position.latitude);
        print(position.longitude);
        DangerWidget.googleMapsUrl = "https://www.google.com/maps/place/@"
            + position.latitude.toString()+","
            + position.longitude.toString() +",17z";
      }).catchError((e) {
        print(e);
      });
    }
    */

//    loadTfLite();

    Timer.periodic(Duration(seconds: 60), (timer) {
//      deleteFiles();
    });

    /*
   Timer.periodic(Duration(seconds: 10), (timer) {
     _detectWeapon();
   });
    */

    for(final loc in locations) {
      final marker = Marker (
        markerId: MarkerId(loc.name),
        position: LatLng(loc.lat, loc.long),
        infoWindow: InfoWindow (
          title: loc.name,
          snippet: loc.covidData
        )
      );
      _markers[loc.name] = marker;
    }
  }

  /*
  Future loadTfLite() async {

    res = await Tflite.loadModel(
        model: "assets/model.tflite",
        labels: "assets/labels.txt",
        numThreads: 1 // defaults to 1
    );

//    await Tflite.close();
  }
   */

  GoogleMapController mapController;
  final LatLng _center = const LatLng(39.8383, -98.5795);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      /*
     body: Center(
       child: Column(
         children: <Widget>[
           RaisedButton(
             //enabled: enableButton,
             onPressed:_detectWeapon,
             child: Text('Check the pic', style: TextStyle(fontSize: 40)),
           ),
           //Gap between button and display
           Expanded(
             child: Container(
//                color: Colors.amber,
               height: 50,
               child: _cameraPreviewWidget(),
             )
           ),
           //displayWidget
           _displayWidget
         ],
       ),
     ),*/
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _center,
          zoom: 2.0,
        ),
        markers: _markers.values.toSet(),
      ),
    );
  }

  /*
  bool working = false;
  void _detectWeapon()  {
    if(working) {
      return;
    }
    setState(() {
      working = true;
      var path;
      recognitions = [];
      try {
        path = join(tempDir, '${DateTime.now()}.png');
        takePic(path);
        //Sleep until pic is taken, saved and analyzed
        sleep(const Duration(seconds: 2));
      } catch (e) {
        print(e);
      }
      random = (new Random()).nextInt(100);
      working = false;

    });
  }

   */

  /*
  Future _initCameraController(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }

    // 3
    controller = CameraController(cameraDescription, ResolutionPreset.high);

    // If the controller is updated then update the UI.
    // 4
    controller.addListener(() {
      // 5
      if (mounted) {
        setState(() {});
      }

      if (controller.value.hasError) {
        print('Camera error ${controller.value.errorDescription}');
      }
    });

    // 6
    try {
      await controller.initialize();
    } on CameraException catch (e) {
      /*
     _showCameraException(e);
      */
      print('Camera error: ' + e.description);
    }

    if (mounted) {
      setState(() {});
    }
  }
  */

  /*
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller.value.isInitialized) {
      return const Text(
        'Loading',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.w900,
        ),
      );
    }

    return AspectRatio(
      aspectRatio: controller.value.aspectRatio,
      child: CameraPreview(controller),
    );
  }
  */

  /*
  Future getTempDir() async {
    tempDir = (await getTemporaryDirectory()).path;
  }
   */

  /*
  Future takePic(path) async {
    await controller.takePicture(path).catchError((e) {
      print(e);
    });
    recognizeImage(path).catchError((e) {
      print(e);
    });

  }
  */

  /*
  Future recognizeImage(String path) async {
    var anchors = [0.57273,0.677385,1.87446,2.06253,3.33843,5.47434,7.88282,3.52778,9.77052,9.16828];
    recognitions = await Tflite.detectObjectOnImage(
        path: path,   // required
        model: "YOLO",
        imageMean: 0.0,
        imageStd: 255.0,
        threshold: 0.3,       // defaults to 0.1
        numResultsPerClass: 2,// defaults to 5
        anchors: anchors,     // defaults to [0.57273,0.677385,1.87446,2.06253,3.33843,5.47434,7.88282,3.52778,9.77052,9.16828]
        blockSize: 32,        // defaults to 32
        numBoxesPerBlock: 5,  // defaults to 5
        asynch: true
    );
//    await Tflite.close();
//    print("Recognitions = ${recognitions}");
    setState(() {
      //print(recognitions);
      if(recognitions.length>0) {
        try {
          var i=0;
          for (i=0; i<recognitions.length; i++) {
            print("Recognition = ${recognitions[i]}");
            List<String> parts = recognitions[i].toString().split(", ");
            var detectedClass;
            var confidenceInClass;
            for(var j=0; j<parts.length; j++) {
//              print(parts[j]);
              if(parts[j].contains("detectedClass")) {
                parts[j] = parts[j].substring("detectedClass: ".length).trim();
//                print(parts[j]);
                parts[j] = parts[j].replaceFirst("}", "");
//                print(parts[j]);
                detectedClass = parts[j];
              }
              if(parts[j].contains("confidenceInClass")) {
                parts[j] = parts[j].substring("confidenceInClass: ".length).trim();
//                print(parts[j]);
                parts[j] = parts[j].replaceFirst("}", "");
//                print(parts[j]);
                confidenceInClass = double.parse(parts[j].trim());
              }
              print("${detectedClass} ${confidenceInClass}");
            }
            if(detectedClass=='Weapon' && confidenceInClass>0.75) {
              _displayWidget = (new DangerWidget(random, path)).display;
              break;
            }
          }
          if(i>=recognitions.length) { //Not a single good recognition
            _displayWidget = (new SafeWidget(random, path)).display;
          }
        } catch(e) {
          print('Exception while processing recognitions ${e}');
          _displayWidget = (new SafeWidget(random, path)).display;
        }
      } else {
        _displayWidget = (new SafeWidget(random, path)).display;
      }
      fileList.add(path);

    });
    //Image processed, delete it
    //deleteFile(path);
  }
   */

  Future deleteFiles() async {
    try {
      sleep(const Duration(seconds: 60));
      var length = fileList.length;
      for (var i=0; i<length; i++) {
        final file = new File(fileList[i]);
        if(await file.exists()) {
          file.delete(recursive: false);
        }
      }
      for (var i=length-1; i>=0; i--) {
        fileList.removeAt(i);
      }
    } catch (e) {

    }
  }

}

