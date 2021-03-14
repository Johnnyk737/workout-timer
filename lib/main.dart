import 'package:flutter/material.dart';
import 'package:workout_timer/pages/home.dart';
import 'package:workout_timer/pages/history.dart';
import 'package:workout_timer/pages/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Workout Timer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _bottomNavIndex = 0;
  
  void pageChanged(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    // Removes the keyboard from screen on initial build
    // SystemChannels.textInput.invokeMethod('TextInput.hide');

    final pageController = PageController(
      initialPage: 0,
      keepPage: true,
    );

    final pageView = PageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      onPageChanged: (index) {
        pageChanged(index);
      },
      children: <Widget>[
        Home(title: 'Workout Timer'),
        History(),
        Settings()
      ],
    );

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: pageView,
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'Previous Workouts'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings'
          ),
        ],
        currentIndex: _bottomNavIndex,
        
        onTap: (index) => {
          // this.setState(() {
          //   _bottomNavIndex = index;
          // }),
          // pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease)
          
          // Turning this off for now
          null
        }
      ),
    );
  }
}
