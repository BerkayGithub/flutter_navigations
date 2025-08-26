import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_navigations/blue_page.dart';
import 'package:flutter_navigations/main.dart';
import 'package:flutter_navigations/ogrenci_detay.dart';
import 'package:flutter_navigations/ogrenci_listesi.dart';
import 'package:flutter_navigations/yellow_page.dart';

class RouteGenerator{

  static Route<dynamic>? _routeOlustur(Widget page, RouteSettings settings){
    if(defaultTargetPlatform == TargetPlatform.iOS){
      return CupertinoPageRoute(
          settings:settings,
          builder: (context) => page);
    }else{
      return MaterialPageRoute(
          settings: settings,
          builder: (context) => page);
    }
  }

  static Route<dynamic>? routeGenerator(RouteSettings settings){

    switch(settings.name){
      case '/':
        return _routeOlustur(AnaSayfa(), settings);

      case '/yellowPage':
        return _routeOlustur(YellowPage(), settings);

      case '/bluePage':
        return _routeOlustur(BluePage(), settings);

      case '/ogrenciListesi':
        return _routeOlustur(OgrenciListesi(), settings);

      case '/ogrenciDetay':
        return _routeOlustur(OgrenciDetay(secilenOgrenci: settings.arguments as Ogrenci), settings);

      default :
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            appBar: AppBar(title: Text("Error")),
            body: Center(child: Text("404"))
          ),
        );
    }

  }
}