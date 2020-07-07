import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivetodo/models/task_model.dart';

import 'bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  final contactsBox = Hive.box('notes');
  bool check;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.add,
            size: 30.0,
          ),
          onPressed: () {
            showModalBottomSheet(
                context: context,
                builder: (context) {
                  return BottomSheetContent();
                });
          }),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            child: Padding(
              padding:
                  EdgeInsets.only(top: 60, left: 30, right: 30, bottom: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 30.0,
                    child: Icon(
                      Icons.list,
                      color: Colors.lightBlueAccent,
                      size: 30.0,
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Text(
                    'To-Do',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 50.0,
                        fontWeight: FontWeight.w700),
                  ),
                  WatchBoxBuilder(
                    box: Hive.box('notes'), builder: (context, contactsBox) {
                      return  Text(
                        ' ${contactsBox.length} tasks',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      );
                  }
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
                padding: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                ),
                child:WatchBoxBuilder(box: Hive.box('notes'), builder: (context, contactsBox) {
                  return ListView.separated(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      final contact = contactsBox.get(index) as Task;
                      return ListTile(
                        title: Text(contact.name, style: TextStyle(
                          decoration: contact.isdone?TextDecoration.lineThrough:null,
                        ),),
                        trailing: Checkbox(activeColor: Colors.lightBlueAccent,value:contact.isdone, onChanged: (value){
                          check = value;
                          contactsBox.putAt(
                            index,
                            Task(name: contact.name, isdone: check),
                          );
                        }),
                      );
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return Divider();
                    },
                    itemCount: contactsBox.length,
                  );
                })),
          ),
        ],
      ),
    );
  }
}
