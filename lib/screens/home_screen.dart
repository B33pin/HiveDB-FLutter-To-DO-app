import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hivetodo/models/task_model.dart';
import 'bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void dispose() {
    Hive.box('notes').compact();
    Hive.close();
    super.dispose();
  }
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
                child:_buildListView()),
          ),
        ],
      ),
    );
  }
}

Widget _buildListView() {
  return WatchBoxBuilder(
    box: Hive.box('notes'),
    builder: (context, contactsBox) {
      return ListView.separated(
        physics: BouncingScrollPhysics(),
        separatorBuilder: (BuildContext context, int index){
          return Divider();
        },
        itemCount: contactsBox.length,
        itemBuilder: (BuildContext context, int index) {
          final contact = contactsBox.getAt(index) as Task;

          return Slidable(
            actionPane: SlidableDrawerActionPane(),
            actionExtentRatio: 0.25,
            child: ListTile(
              title: Text(contact.name,style: TextStyle(
                decoration: contact.isdone?TextDecoration.lineThrough:null
              ),),
              trailing: Checkbox(activeColor: Colors.lightBlueAccent,value: contact.isdone, onChanged: (tick){
                contactsBox.putAt(index, Task(name: contact.name, isdone: tick));
              }),
            ),
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'Delete',
                color: Colors.red[400],
                icon: Icons.delete,
                onTap: (){
                  contactsBox.deleteAt(index);
                },
              ),
            ],
          );
        },
      );
    },
  );}