# flutter_navigations

A new Flutter project.

## Navigator
The Navigator widget displays screens as a stack using the correct transition animations for the target platform. To navigate to a new screen, access the Navigator through the route's BuildContext and call imperative methods such as push() or pop()

Because Navigator keeps a stack of Route(In Flutter, screens and pages are called routes) objects (representing the history stack), The push() method also takes a Route object. The MaterialPageRoute(CupertinoPageRoute for iOS) object is a subclass of Route that specifies the transition animations for Material Design.

To switch to a new route, use the Navigator.push() method. The push() method adds a Route to the stack of routes managed by the Navigator.

main.dart

      ElevatedButton(
        onPressed: () async {
          Navigator.push<int>(context, CupertinoPageRoute(builder: (context) => RedPage()));
        }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade300), child: Text("Kırmızı sayfaya git iOS", style: TextStyle(color: Colors.white),)),
      ElevatedButton(onPressed: () async {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) => RedPage()));
      }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade600), child: Text("Kırmızı sayfaya git Android", style: TextStyle(color: Colors.white)),),

How do you close the second route and return to the first? By using the Navigator.pop() method. The pop() method removes the current Route from the stack of routes managed by the Navigator.

### How to return data from screen

redPage.dart

    ElevatedButton(
      onPressed: () {
      Navigator.of(context).pop();
    }, child: Text("Geri Dön")),

In some cases, you might want to return data from a new screen. For example, say you push a new screen that returns a random number to a user. You can do this with the Navigator.pop() method.

main.dart

    int? gelenSayi = await Navigator.push<int>(context, CupertinoPageRoute(builder: (context) => RedPage()));
    print("Ana sayfadaki sayı $gelenSayi");

redPage.dart

    _rastgeleSayi = Random().nextInt(100);
    print("Üretilen sayı $_rastgeleSayi");
    Navigator.of(context).pop(_rastgeleSayi);

### maybePop()

maybePop() tries to pop the current route only if it’s allowed to. If it does pop it also returns true value.
If there are no pages to pop (like you're already on the first screen), it simply does nothing and returns false.

main.dart

    ElevatedButton(onPressed: () {
      Navigator.of(context).maybePop();
    }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade600), child: Text("Maybe Pop", style: TextStyle(color: Colors.white)),),

### canPop()

canPop() method tries to see if the current route can pop or not. If route can pop it returns true if not then returns false.

main.dart

    if(Navigator.of(context).canPop()){
      print("Navigator can pop");
    }else{
      print("Navigator can not pop");
    }

### pushReplacement()

It removes (pops) the current route and pushes a new one in its place.

So your navigation stack goes from:
[PageA, PageB] → pushReplacement(PageC) → [PageA, PageC]

PageB is gone. Like… really gone.
Back button won’t bring you back to it.

When do people use this?

🔐 After login → replace login screen with home screen

🧭 Onboarding → don’t let user go back to the intro pages

🔄 Redirect flows

🧼 Cleaning the back stack so user can’t back-navigate into places they shouldn’t

main.dart

    ElevatedButton(onPressed: (){
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => GreenPage())
      );
    },style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade600), child: Text("Yeşil sayfaya git",style: TextStyle(color: Colors.white))),
    

### pushNamed()

It pushes a new route based on a route name you registered in MaterialApp.

main.dart

    ElevatedButton(onPressed: () {
      Navigator.of(context).pushNamed("/redPage");
    }, style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade600), child: Text("Push named deneme", style: TextStyle(color: Colors.white)),),
    ElevatedButton(onPressed: () {
      Navigator.of(context).pushNamed("/yellowPage");
    }, style: ElevatedButton.styleFrom(backgroundColor: Colors.yellow.shade600), child: Text("Sarı sayfaya git", style: TextStyle(color: Colors.white)),),

In order to use pushNamed function, first we need to register the routes

main.dart

      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          routes: {
            '/' : (context) => AnaSayfa(),
            '/redPage' : (context) => RedPage(),
            '/yellowPage' : (context) => YellowPage(),
          }
        );
      }
    }

### onGenerateRoute

We can also use an onGenerateRoute setup for routing

route_generator.dart

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

main.dart

    @override
    Widget build(BuildContext context) {
      return MaterialApp(
        onGenerateRoute: RouteGenerator.routeGenerator,
      );
    }

### Sending argument using pushNamed

We can also send arguments to a route using pushNamed

main.dart

    ElevatedButton(onPressed: () {
      Navigator.of(context).pushNamed("/ogrenciListesi", arguments: 60);
    }, style: ElevatedButton.styleFrom(backgroundColor: Colors.black), child: Text("Öğrenci listesi", style: TextStyle(color: Colors.white)),),

ogrenci_listesi.dart

    int elemanSayisi = ModalRoute.of(context)!.settings.arguments as int;

    var secilen = tumOgrenciler[index];
    Navigator.pushNamed(context, "/ogrenciDetay", arguments: secilen);

route_generator.dart

    case '/ogrenciDetay':
      return _routeOlustur(OgrenciDetay(secilenOgrenci: settings.arguments as Ogrenci), settings);

ogrenci_detay.dart

    child: Column(
      children: [
        Text("${secilenOgrenci.id}"),
        Text(secilenOgrenci.isim),
        Text(secilenOgrenci.soyisim),
      ],
    ),

