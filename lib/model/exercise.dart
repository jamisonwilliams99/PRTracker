class Exercise {
  int _id;
  int _workoutId;
  String _name;
  int _reps;
  int _sets;

  Exercise(this._name, this._reps, this._sets);

  Exercise.withId(this._id, this._name, this._reps,
      this._sets); // still need to add workoutId to this

  // getters
  int get id => _id;
  int get workoutId => _workoutId;
  String get name => _name;
  int get reps => _reps;
  int get sets => _sets;

  // setters
  set workoutId(int newWorkoutId) {
    _workoutId = newWorkoutId;
  }

  set name(String newName) {
    _name = newName;
  }

  set reps(int newReps) {
    _reps = newReps;
  }

  set sets(int newSets) {
    _sets = newSets;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["name"] = _name;
    map["reps"] = _reps;
    map["sets"] = _sets;

    if (_id != null) {
      map["id"] = _id;
    }
    if (_workoutId != null) {
      map["workoutId"] = _workoutId;
    }
    return map;
  }

  Exercise.fromObject(dynamic o) {
    this._id = o["id"];
    this._workoutId = o["workoutId"];
    this._name = o["name"];
    this._reps = o["reps"];
    this._sets = o["sets"];
  }
}