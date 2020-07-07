import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hivetodo/models/task_model.dart';
class BottomSheetContent extends StatefulWidget {
  @override
  _BottomSheetContentState createState() => _BottomSheetContentState();
}

class _BottomSheetContentState extends State<BottomSheetContent> {
  String _name;
  bool _istrue=false;
  void addContact(Task contact) {
    final contactsBox = Hive.box('notes');
    contactsBox.add(contact);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)
          ),
        ),
        padding: EdgeInsets.only( left:30, right: 30, bottom: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            Text('Add Task', textAlign: TextAlign.center, style: TextStyle(
              color: Colors.lightBlueAccent,
              fontSize: 35,
              fontWeight: FontWeight.w500
            ),),
            TextField(
              autofocus: true,
              textAlign: TextAlign.center,
              onChanged: (text){
                _name = text;
              },
              style: TextStyle(
                fontSize: 20,
                color: Colors.black54
              ),

            ),
            SizedBox(
              height: 10,
            ),
            FlatButton(
              shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),color: Colors.lightBlueAccent,onPressed: (){
               // _formKey.currentState.save();
              final newContact = Task(name: _name, isdone: _istrue);
              addContact(newContact);
              Navigator.pop(context);
            }, child: Text('Add', style: TextStyle(color: Colors.white, fontSize: 18),),),
          ],
        ),
      ),
    );
  }
}
