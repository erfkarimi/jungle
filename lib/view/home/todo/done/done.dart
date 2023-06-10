import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/model/palette/palette.dart';
import 'package:jungle/view_model/set_theme/set_theme.dart';
import 'package:provider/provider.dart';
import '../../../../model/todo_model/todo_model.dart';
part 'edit_done_todo.dart';

class Done extends StatefulWidget{
  const Done({super.key});
  @override
  DoneState createState()=> DoneState();
}
class DoneState extends State<Done>{
  final Box<TodoModel> completedTodoBox = Hive.box<TodoModel>("completed");
  final Box<TodoModel> todoBox = Hive.box<TodoModel>("todo");
  
  @override 
  Widget build(context){
    final SetTheme setTheme = Provider.of<SetTheme>(context);
    return Scaffold(
      backgroundColor: setTheme.setBackgroundTheme(),
      body: buildBody(setTheme)
    );
  }


    Widget buildBody(SetTheme setTheme){
    return ValueListenableBuilder(
      valueListenable: completedTodoBox.listenable(), 
      builder: (context,completedTodoBox, __){
        if(completedTodoBox.isEmpty){
          return showNoCompletedTodo(setTheme);
        } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: setTheme.setAppBarTheme(),
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: completedTodoBox.length,
                  itemBuilder: (context, int index){
                    index = completedTodoBox.length - 1 - index;
                    return completedTodoButton(index, setTheme);
                  }
                  ),
              ),
            );
        }
      }
      );
  }

  Widget completedTodoButton(int index, SetTheme setTheme){
    final completedTodo = completedTodoBox.getAt(index) as TodoModel;
    return MaterialButton(
      onPressed: (){
        showEditBottomSheet(context,completedTodoBox, setTheme, index);
      },
      onLongPress: ()=> deleteDoneTodoOnLongPressDialog(context, index, setTheme),
      height: 50,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child:Row(
          children: [
            IconButton(
              onPressed: (){
                setState(() {
                  completedTodoBox.deleteAt(index);
                  todoBox.add(completedTodo);
                });
              },
              icon: Icon(
                Icons.check,
                color: Palette.ultramarineBlue,
                ),
            ),
            Text(
              completedTodoBox.getAt(index)!.title,
              style: TextStyle(
                color: setTheme.setTextTheme(),
                decoration: TextDecoration.lineThrough
              ),
        ),
          ],
        ),
    );
  }

  Widget showNoCompletedTodo(SetTheme setTheme){
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "asset/image/to-do-list-rafiki.png",
            width: 250,
          ),
          Text(
            "Nothing is here",
            style: TextStyle(
              fontSize: 17,
              color: setTheme.setTextTheme()
            ),
          )
        ],
      ),
    );
  }

  void deleteDoneTodoOnLongPressDialog(
    BuildContext context, 
    int index,
    SetTheme setTheme) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Deletion",
                style: TextStyle(color: setTheme.setTextTheme())),
            backgroundColor: setTheme.setBackgroundTheme(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Text("Are you sure ?",
                style: TextStyle(color: setTheme.setTextTheme())),
            actions: [
              TextButton(
                onPressed: () {
                  completedTodoBox.deleteAt(index);
                  Navigator.of(context).pop();
                },
                child: const Text("Yes"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(color: Colors.red.shade600),
                ),
              )
            ],
          );
        });
  }

  
}