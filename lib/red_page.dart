import 'dart:math';

import 'package:flutter/material.dart';

class RedPage extends StatelessWidget {
  RedPage({super.key});

  int _rastgeleSayi = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        print("Will pop çalıştı");
        _rastgeleSayi = Random().nextInt(100);
        Navigator.pop(context, _rastgeleSayi);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Red Page"), backgroundColor: Colors.red
        ),
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Red Page", style: TextStyle(fontSize: 24)),
                ElevatedButton(
                    onPressed: () {
                      _rastgeleSayi = Random().nextInt(100);
                      print("Üretilen sayı $_rastgeleSayi");
                      Navigator.of(context).pop(_rastgeleSayi);
                    }, child: Text("Geri Dön")),
                ElevatedButton(onPressed: () {
                  if(Navigator.of(context).canPop()){
                    print("Navigator can pop");
                  }else{
                    print("Navigator can not pop");
                  }
                }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade600), child: Text("Can Pop", style: TextStyle(color: Colors.white)),),
                ElevatedButton(onPressed: () {
                  Navigator.of(context).pushNamed("/yellowPage");
                }, style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow.shade600), child: Text("Go to yellow", style: TextStyle(color: Colors.white)),),

              ]
          ),
        ),
      ),
    );
  }
}