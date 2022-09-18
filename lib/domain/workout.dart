class Workout{
  String title;
  String author;
  String description;
  String level;

  Workout({required this.title, required this.author, required this.description, required this.level});
}

class WorkoutSchedule{
  List<WorkoutWeek> weeks;

  WorkoutSchedule({required this.weeks});

  WorkoutSchedule copy(){
    var copiedWeeks = weeks.map((w) => w.copy()).toList();
    return WorkoutSchedule(weeks: copiedWeeks);
  }
}

class WorkoutWeek{
  String notes;
  List<WorkoutWeekDay> days;

  WorkoutWeek({required this.days, required this.notes});

  WorkoutWeek copy(){
    var copiedDays = days.map((w) => w.copy()).toList();

    return WorkoutWeek(days: copiedDays, notes: notes);
  }

  int get daysWithDrills => days.where((d) => d.isSet).length;
}

class WorkoutWeekDay{
  String notes;
  List<WorkoutDrillsBlock> drillBlocks;

  bool get isSet => drillBlocks.isNotEmpty;
  int get notRestDrillBlocksCount => isSet ? drillBlocks.where((b) => b is! WorkoutRestDrillBlock).length : 0;

  WorkoutWeekDay({required this.drillBlocks, required this.notes});

  WorkoutWeekDay copy(){
    var copiedBlocks = drillBlocks.map((w) => w.copy()).toList();
    return WorkoutWeekDay(notes: notes, drillBlocks: copiedBlocks);
  }
}

class WorkoutDrill {
  String title;
  String weight;
  int sets;
  int reps;

  WorkoutDrill({required this.title, required this.weight, required this.sets, required this.reps});

  WorkoutDrill copy(){
    return WorkoutDrill(title: title, weight: weight, sets: sets, reps: reps);
  }
}

enum WorkoutDrillType{
  SINGLE,
  MULTISET,
  AMRAP,
  ForTime,
  EMOM,
  REST
  //TABATA
}

abstract class WorkoutDrillsBlock{
  WorkoutDrillType type;
  List<WorkoutDrill> drills;

  WorkoutDrillsBlock({required this.type, required this.drills});

  void changeDrillsCount(int count) {
    var diff = count - drills.length;

    if(diff == 0) return;

    if(diff > 0){
      for(int i = 0; i<diff; i++){
        drills.add(WorkoutDrill(weight: '', reps: 0, title: '', sets: 0));
      }
    }else{
      drills = drills.sublist(0, drills.length+diff);
    }
  }

  WorkoutDrillsBlock copy();

  List<WorkoutDrill> copyDrills(){
    return drills.map((w) => w.copy()).toList();
  }
}

class WorkoutSingleDrillBlock extends WorkoutDrillsBlock
{
  WorkoutSingleDrillBlock(WorkoutDrill drill)
      : super(type: WorkoutDrillType.SINGLE, drills:[drill]);

  @override
  WorkoutSingleDrillBlock copy(){
    return WorkoutSingleDrillBlock(copyDrills()[0]);
  }
}

class WorkoutMultisetDrillBlock extends WorkoutDrillsBlock
{
  WorkoutMultisetDrillBlock(List<WorkoutDrill> drill)
      : super(type: WorkoutDrillType.MULTISET, drills:drill);

  @override
  WorkoutMultisetDrillBlock copy(){
    return WorkoutMultisetDrillBlock(copyDrills());
  }
}

class WorkoutAmrapDrillBlock extends WorkoutDrillsBlock
{
  int minutes;

  WorkoutAmrapDrillBlock({required this.minutes, required List<WorkoutDrill> drills})
      : super(type: WorkoutDrillType.AMRAP, drills:drills);

  @override
  WorkoutAmrapDrillBlock copy(){
    return WorkoutAmrapDrillBlock(minutes: minutes , drills: copyDrills());
  }
}

class WorkoutForTimeDrillBlock extends WorkoutDrillsBlock
{
  int timeCapMin;
  int rounds;
  int restBetweenRoundsMin;

  WorkoutForTimeDrillBlock({required this.timeCapMin, required this.rounds, required this.restBetweenRoundsMin, required List<WorkoutDrill> drills})
      : super(type: WorkoutDrillType.ForTime, drills:drills);

  @override
  WorkoutForTimeDrillBlock copy(){
    return WorkoutForTimeDrillBlock(timeCapMin: timeCapMin, rounds: rounds, restBetweenRoundsMin: restBetweenRoundsMin, drills: copyDrills());
  }
}

class WorkoutEmomDrillBlock extends WorkoutDrillsBlock
{
  int timeCapMin;
  int intervalMin;

  WorkoutEmomDrillBlock({required this.timeCapMin, required this.intervalMin, required List<WorkoutDrill> drills})
      : super(type: WorkoutDrillType.EMOM, drills:drills);

  @override
  WorkoutEmomDrillBlock copy(){
    return WorkoutEmomDrillBlock(timeCapMin: timeCapMin, intervalMin: intervalMin, drills: copyDrills());
  }
}

class WorkoutRestDrillBlock extends WorkoutDrillsBlock
{
  int timeMin;

  WorkoutRestDrillBlock({required this.timeMin })
      : super(type: WorkoutDrillType.REST, drills:[]);

  @override
  WorkoutRestDrillBlock copy(){
    return WorkoutRestDrillBlock(timeMin: timeMin);
  }
}