import 'package:flutter/material.dart';
import '../domain/workout.dart';

class WorkoutsList extends StatefulWidget {

  @override
  _WorkoutsListState createState() => _WorkoutsListState();
}

class _WorkoutsListState extends State<WorkoutsList> {

  @override
  void initState(){
    clearFilter();
    super.initState();
  }

  final workouts = <Workout>[
    Workout(title: 'Test1', author: 'Max1', description: 'Test Workout1', level: 'Beginner'),
    Workout(title: 'Test2', author: 'Max2', description: 'Test Workout2', level: 'Intermediate'),
    Workout(title: 'Test3', author: 'Max3', description: 'Test Workout3', level: 'Advanced'),
    Workout(title: 'Test4', author: 'Max4', description: 'Test Workout4', level: 'Beginner'),
    Workout(title: 'Test5', author: 'Max5', description: 'Test Workout5', level: 'Intermediate'),
  ];

  var filterOnlyMyWorkouts = false;
  var filterTitle = '';
  var filterTitleController = TextEditingController();
  var filterLevel = 'Any Lever';

  var filterText = '';
  var filterHeight = 0.0;

  List<Workout> filter() {
    setState(() {
      filterText = filterOnlyMyWorkouts ? 'My Workouts' : 'All Workouts';
      filterText += '/$filterLevel';
      if (filterTitle.isNotEmpty) filterText += '/$filterTitle';
      filterHeight = 0;
    });

    var list = workouts;
    return list;
  }

  List<Workout> clearFilter() {
    setState(() {
      filterText = 'All workouts/Any Level';
      filterOnlyMyWorkouts = false;
      filterTitle = '';
      filterLevel = 'Any Level';
      filterTitleController.clear();
      filterHeight = 0;
    });

    var list = workouts;
    return list;
  }

  @override
  Widget build(BuildContext context) {
    var workoutsList = Expanded(
      child: ListView.builder(
          itemCount: workouts.length,
          itemBuilder: (context, i) {
            return Card(
              elevation: 2.0,
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Container(
                decoration:
                const BoxDecoration(color: Color.fromRGBO(50, 65, 85, 0.9)),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                  leading: Container(
                    padding: const EdgeInsets.only(right: 12),
                    decoration: const BoxDecoration(
                        border: Border(
                            right:
                            BorderSide(width: 1, color: Colors.white24))),
                    child: const Icon(Icons.fitness_center,
                        color: Colors.white),
                  ),
                  title: Text(workouts[i].title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                  trailing: const Icon(Icons.keyboard_arrow_right,
                      color: Colors.white),
                  subtitle: subtitle(context, workouts[i]),
                ),
              ),
            );
          }),
    );

    var filterInfo = Container(
      margin: const EdgeInsets.only(top: 3, left: 7, right: 7, bottom: 5),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.5)),
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: Colors.white,
          onPrimary: Theme.of(context).primaryColor, // foreground
        ),
        child: Row(
          children: <Widget>[
            const Icon(Icons.filter_list),
            Text(
              filterText,
              style: const TextStyle(),
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
        onPressed: (){
          setState(() {
            filterHeight = (filterHeight == 0.0 ? 280.0 : 0.0);
          });
        },
      ),
    );

    var levelMenuItems = <String>[
      'Any Level',
      'Beginner',
      'Intermediate',
      'Advanced'
    ].map((String value){
      return DropdownMenuItem<String>(
        value: value,
        child: Text(value),
      );
    }).toList();

    var filterForm = AnimatedContainer(
      margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 7),
      duration: const Duration(milliseconds: 400),
      curve: Curves.fastOutSlowIn,
      height: filterHeight,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Only My Workouts', style: TextStyle(color: Colors.black),),
                value: filterOnlyMyWorkouts,
                onChanged: (bool val) =>
                    setState(() => filterOnlyMyWorkouts = val)),
              DropdownButtonFormField<String>(
                decoration: const InputDecoration(labelText: 'Level'),
                items: levelMenuItems,
                value: filterLevel,
                onChanged: (String? value) => setState(() => filterLevel = value!),
              ),
              TextFormField(
                controller: filterTitleController,
                decoration: const InputDecoration(labelText: 'Title'),
                onChanged: (String? value) => setState(() {
                  filterTitle = value!;
                }),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Theme.of(context).primaryColor,
                        onPrimary: Colors.white, // foreground
                      ),
                      onPressed: (){
                        filter();
                      },
                      //color: Theme.of(context).primaryColor,
                      child: const Text("Apply", style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 1,
                    child: ElevatedButton(
                      onPressed: (){
                        clearFilter();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.red,
                        onPrimary: Colors.white, // foreground
                      ),
                      child: const Text("Clear", style: TextStyle(color: Colors.white)),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );

    return Column(
      children: <Widget>[
        filterInfo,
        filterForm,
        workoutsList,
      ],
    );
  }

  Widget subtitle(BuildContext context, Workout workout){
    var color = Colors.grey;
    double indicatorLevel = 0;

    switch(workout.level){
      case 'Beginner':
        color = Colors.green;
        indicatorLevel = 0.33;
        break;
      case 'Intermediate':
        color = Colors.yellow;
        indicatorLevel = 0.66;
        break;
      case 'Advanced':
        color = Colors.red;
        indicatorLevel = 1;
        break;
    }

    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: LinearProgressIndicator(
            backgroundColor: Colors.white,
            value: indicatorLevel,
            valueColor: AlwaysStoppedAnimation(color),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
            flex:3,
            child: Text(workout.level, style: const TextStyle(color: Colors.white))
        )
      ],
    );
  }
}




