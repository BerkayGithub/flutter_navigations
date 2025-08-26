import 'package:flutter/material.dart';

class BluePage extends StatelessWidget {
  const BluePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blue Page"), backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Blue Page", style: TextStyle(fontSize: 24)),
            ElevatedButton(onPressed: () {
              Navigator.of(context).pushNamed("/yellowPage");
            }, style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow.shade600), child: Text("Sarı sayfaya git", style: TextStyle(color: Colors.white)),),
          ],
        ),
      ),
    );
  }

}