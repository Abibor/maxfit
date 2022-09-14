import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../components/active-workouts.dart';
import '../components/workouts-list.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int sectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    var NavigationBar = CurvedNavigationBar(
      items: <Widget>[
        Icon(Icons.fitness_center),
        Icon(Icons.search)
      ],
      index: 0,
      height: 50,
      color: Colors.white.withOpacity(0.5),
      buttonBackgroundColor: Colors.white,
      backgroundColor: Colors.white.withOpacity(0.5),
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 500),
      onTap: (int index){
        setState(() => sectionIndex = index);
      },
    );

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('MaxFit // ${sectionIndex == 0 ? 'Active Workouts' : 'Find Workouts'}'),
        leading: const Icon(Icons.fitness_center),
      ),
      body: sectionIndex == 0 ? const ActiveWorkouts() : WorkoutsList(),
      bottomNavigationBar:NavigationBar
      /*
      //Простой navigation bar с двумя кнопками снизу
      bottomNavigationBar: BottomNavigationBar(
        items: const<BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.fitness_center),
            label: 'My Workouts'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
              label: 'Find Workouts'
          ),
        ],
        currentIndex: sectionIndex,
        backgroundColor: Colors.white30,
        selectedItemColor: Colors.white,
        onTap: (int index){
          setState(() => sectionIndex = index);
        },
      ),

      */

    );
  }
}

