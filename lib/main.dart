import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_navigations/green_page.dart';
import 'package:flutter_navigations/red_page.dart';
import 'package:flutter_navigations/route_generator.dart';
import 'package:flutter_navigations/yellow_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      /*routes: {
        '/' : (context) => AnaSayfa(),
        '/redPage' : (context) => RedPage(),
        '/yellowPage' : (context) => YellowPage(),
      },
      onUnknownRoute: (settings) => MaterialPageRoute(builder: (context)=>Scaffold(
        appBar: AppBar(title: Text("Error"),),
        body: Center(child: Text("404")),
      )),*/
      onGenerateRoute: RouteGenerator.routeGenerator,
    );
  }
}

class AnaSayfa extends StatelessWidget {
  const AnaSayfa({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Navigasyon İşlemleri")),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
                onPressed: () async {
                  int? gelenSayi = await Navigator.push<int>(context, CupertinoPageRoute(builder: (context) => RedPage()));
                  print("Ana sayfadaki sayı $gelenSayi");
                }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade300), child: Text("Kırmızı sayfaya git iOS", style: TextStyle(color: Colors.white),)),
            ElevatedButton(onPressed: () async {
              int gelenSayi2 = await Navigator.of(context).push(MaterialPageRoute(builder: (context) => RedPage()));
              print("Ana sayfadaki sayı $gelenSayi2");
            }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade600), child: Text("Kırmızı sayfaya git Android", style: TextStyle(color: Colors.white)),),
            ElevatedButton(onPressed: () {
              Navigator.of(context).maybePop();
            }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade600), child: Text("Maybe Pop", style: TextStyle(color: Colors.white)),),
            ElevatedButton(onPressed: () {
              if(Navigator.of(context).canPop()){
                print("Navigator can pop");
              }else{
                print("Navigator can not pop");
              }
            }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade600), child: Text("Can Pop", style: TextStyle(color: Colors.white)),),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => GreenPage())
              );
            },style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600), child: Text("Yeşil sayfaya git",style: TextStyle(color: Colors.white))),
            ElevatedButton(onPressed: () {
              Navigator.of(context).pushNamed("/redPage");
            }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade600), child: Text("Push named deneme", style: TextStyle(color: Colors.white)),),
            ElevatedButton(onPressed: () {
              Navigator.of(context).pushNamed("/yellowPage");
            }, style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow.shade600), child: Text("Sarı sayfaya git", style: TextStyle(color: Colors.white)),),
            ElevatedButton(onPressed: () {
              Navigator.of(context).pushNamed("/ogrenciListesi", arguments: 60);
            }, style: ElevatedButton.styleFrom(backgroundColor: Colors.black), child: Text("Öğrenci listesi", style: TextStyle(color: Colors.white)),),
            ElevatedButton(onPressed: () {
              Navigator.of(context).pushNamed("/bluePage");
            }, style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade600), child: Text("Mavi sayfaya git", style: TextStyle(color: Colors.white)),),

          ],
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
