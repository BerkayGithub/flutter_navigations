import 'package:flutter/material.dart';

class YellowPage extends StatelessWidget {
  const YellowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Yellow Page"), backgroundColor: Colors.yellow,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Yellow Page", style: TextStyle(fontSize: 24)),
            ElevatedButton(onPressed: () {
              Navigator.of(context).popUntil((route) => route.settings.name == '/bluePage');//popuntil fonksiyonu belirtilen sayfaya dönene kadar stack'deki sayfaları pop eder(yani sayfalarda geri gider)
            }, style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow.shade600), child: Text("Mavi sayfaya geri dön", style: TextStyle(color: Colors.white)),),

          ],
        ),
      ),
    );
  }

}