import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/model/palette/palette.dart';
import 'package:jungle/view_model/db_counter_state/db_counter_state.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import 'package:provider/provider.dart';
import '../../../../model/todo_model/todo_model.dart';
part 'edit_completed_todo.dart';

class CompletedTodo extends StatefulWidget{
  const CompletedTodo({super.key});
  @override
  CompletedTodoState createState()=> CompletedTodoState();
}
class CompletedTodoState extends State<CompletedTodo>{
  final Box<TodoModel> completedTodoBox = Hive.box<TodoModel>("completed");
  final Box<TodoModel> todoBox = Hive.box<TodoModel>("todo");
  
  @override 
  Widget build(context){
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    return Scaffold(
      body: buildBody(appUiStyle)
    );
  }


    Widget buildBody(AppUiStyle appUiStyle){
    return ValueListenableBuilder(
      valueListenable: completedTodoBox.listenable(), 
      builder: (context,completedTodoBox, __){
        if(completedTodoBox.isEmpty){
          return showNoCompletedTodo(appUiStyle);
        } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: appUiStyle.setAppBarTheme(),
                    border: Border.all(
                      color: Colors.black
                    )
                  ),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: completedTodoBox.length,
                  itemBuilder: (context, int index){
                    index = completedTodoBox.length - 1 - index;
                    return completedTodoButton(index, appUiStyle);
                  }
                  ),
              ),
            );
        }
      }
      );
  }

  Widget completedTodoButton(int index, AppUiStyle appUiStyle){
    final completedTodo = completedTodoBox.getAt(index) as TodoModel;
    return MaterialButton(
      onPressed: (){
        showEditBottomSheet(context,completedTodoBox, appUiStyle, index);
      },
      onLongPress: ()=> deleteDoneTodoOnLongPressDialog(context, index, appUiStyle),
      height: 50,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child:Row(
          children: [
            Consumer<DbCounterState>(
              builder: (context, dbCounterState, _) {
                return IconButton(
                  onPressed: (){
                    setState(() {
                      completedTodoBox.deleteAt(index);
                      todoBox.add(completedTodo);
                      dbCounterState.updateCompletedCounter(completedTodoBox.length);
                      dbCounterState.updateTodoCounter(todoBox.length);
                      dbCounterState.saveDbCounterState();
                    });
                  },
                  icon: Icon(
                    Icons.check,
                    color: Palette.ultramarineBlue,
                    ),
                );
              }
            ),
            Text(
              completedTodoBox.getAt(index)!.title,
              style: TextStyle(
                color: appUiStyle.setTextTheme(),
                decoration: TextDecoration.lineThrough
              ),
        ),
          ],
        ),
    );
  }

  Widget showNoCompletedTodo(AppUiStyle appUiStyle){
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
              color: appUiStyle.setTextTheme()
            ),
          )
        ],
      ),
    );
  }

  void deleteDoneTodoOnLongPressDialog(
    BuildContext context, 
    int index,
    AppUiStyle appUiStyle) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Deletion",
                style: TextStyle(color: appUiStyle.setTextTheme())),
            backgroundColor: appUiStyle.setBackgroundTheme(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Text("Are you sure ?",
                style: TextStyle(color: appUiStyle.setTextTheme())),
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