import 'package:flutter/cupertino.dart';
import 'package:hive/hive.dart';
part 'task_model.g.dart';
@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  String name;
  @HiveField(1)
  bool isdone;

  Task({@required this.name, @required this.isdone});

}