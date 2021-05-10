/*
This screen will be displayed when the user wants to add an exercise to 
a workout. They will be asked to enter the exercise name, sets, and reps
  - the exercise will then be displayed in a list view on the workoutview.dart
    page
*/

import 'package:flutter/material.dart';
import 'package:workout_tracking_app/model/exercise.dart';
import 'package:workout_tracking_app/util/dbhelper.dart';
import 'package:intl/intl.dart';

DbHelper helper = DbHelper();

final List<String> choices = const <String>[
  "Save Exercise",
  "Delete Exercise",
  "Back"
];

const mnuSave = "Save Exercise";
const mnuDelete = "Delete Exercise";
const mnuBack = "Back";

class AddExercise extends StatefulWidget {
  final Exercise exercise;

  AddExercise(this.exercise);

  @override
  _AddExerciseState createState() => _AddExerciseState(exercise);
}

class _AddExerciseState extends State<AddExercise> {
  Exercise exercise;

  _AddExerciseState(this.exercise);

  TextEditingController nameController = TextEditingController();
  TextEditingController repsController = TextEditingController();
  TextEditingController setsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = exercise.name;
    repsController.text = exercise.reps.toString();
    setsController.text = exercise.sets.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(exercise.name),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
                onTap: () {
                  delete();
                },
                child: Icon(Icons.delete)),
          )
        ],
      ),
      body: Column(children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(50.0, 30.0, 50.0, 20.0),
          child: Center(
              child: TextField(
            controller: nameController,
            onChanged: (value) => this.updateName(),
            decoration: InputDecoration(
                labelText: "Exercise name",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0))),
          )),
        ),
        Row(children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20.0, 10.0, 10.0, 0.0),
              child: TextField(
                controller: repsController,
                keyboardType: TextInputType.number,
                onChanged: (value) => this.updateReps(),
                decoration: InputDecoration(
                    labelText: "Reps",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 10.0, 20.0, 0.0),
              child: TextField(
                controller: setsController,
                keyboardType: TextInputType.number,
                onChanged: (value) => this.updateSets(),
                decoration: InputDecoration(
                    labelText: "Sets",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
          ),
        ]),
        Center(
          child: ElevatedButton(
              onPressed: () {
                save();
              },
              child: Text("Save Exercise")),
        )
      ]),
    );
  }

  void delete() async {
    int result;
    Navigator.pop(context, true);
    if (exercise.id == null) {
      return;
    }
    result = await helper.deleteExercise(exercise.id);
    if (result != 0) {
      AlertDialog alertDialog = AlertDialog(content: Text("Exercise deleted"));
      showDialog(context: context, builder: (_) => alertDialog);
    }
  }

  void save() {
    if (exercise.id != null) {
      helper.updateExercise(exercise);
    } else {
      helper.insertExercise(exercise);
    }
    Navigator.pop(context, true);
  }

  void updateName() {
    exercise.name = nameController.text;
  }

  void updateReps() {
    exercise.reps = int.parse(repsController.text);
  }

  void updateSets() {
    exercise.sets = int.parse(setsController.text);
  }
}