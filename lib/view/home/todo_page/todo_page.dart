import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jungle/view_model/db_counter_state/db_counter_state.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import 'package:provider/provider.dart';
import '../../../model/palette/palette.dart';
import '../../../model/todo_model/todo_model.dart';
import 'edit_todo.dart';

class TodoPage extends StatefulWidget{
  const TodoPage({super.key});

  @override
  TodoPageState createState()=> TodoPageState();
}
class TodoPageState extends State<TodoPage>{
  final Box<TodoModel> todoBox = Hive.box<TodoModel>("todo");
  final Box<TodoModel> completedTodoBox = Hive.box<TodoModel>("completed");
  String title = "";
  @override 
  Widget build(context){
    
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: appUiStyle.setAppBarTheme()
      ),
      child: Scaffold(
        backgroundColor: appUiStyle.setAppBarTheme(),
        resizeToAvoidBottomInset: false,
        floatingActionButton: floatingActionButton(appUiStyle),
        body: buildBody(appUiStyle)
      ),
    );
  }

  Widget buildBody(AppUiStyle appUiStyle) {
    return ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: (context, todoBox, __) {
          if (todoBox.isEmpty) {
            return showNoTodo(appUiStyle);
          } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: appUiStyle.setItemBackgroundTheme(),
                    ),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: todoBox.length,
                    itemBuilder: (context, index) {
                      index = todoBox.length - 1 - index;
                      return todoButton(index, appUiStyle);
                    }),
              ),
            );
          }
        });
  }

  Widget todoButton(int index, AppUiStyle appUiStyle) {
    final todo = todoBox.getAt(index) as TodoModel;
    return MaterialButton(
      onPressed: () {
        Get.to(
          EditTodoPage(index: index),
          transition: Transition.cupertino
          );
        
      },
      onLongPress: () => deleteUnDoneTodoOnLongPressDialog(context, index, appUiStyle),
      height: 50,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Consumer<DbCounterState>(
            builder: (context, dbCounterState, _) {
              return Checkbox(
                shape: const CircleBorder(),
                value: false,
                side: BorderSide(color: appUiStyle.setTextTheme()),
                onChanged: (value) {
                  setState(() {
                    todoBox.deleteAt(index);
                    completedTodoBox.add(todo);
                    dbCounterState.updateTodoCounter(todoBox.length);
                    dbCounterState.updateCompletedCounter(completedTodoBox.length);
                    dbCounterState.saveDbCounterState();
                  });
                },
              );
            }
          ),
          Text(
            todoBox.getAt(index)!.title,
            style: TextStyle(
              color: appUiStyle.setTextTheme()
              
              ),
          ),
        ],
      ),
    );
  }

  Widget showNoTodo(AppUiStyle appUiStyle) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "asset/image/to-do-list-cuate.png",
            width: 250,
          ),
          Text(
            "No todo",
            style: TextStyle(fontSize: 17, color: appUiStyle.setTextTheme()),
          )
        ],
      ),
    );
  }
    void showNewTodoBottomSheet(AppUiStyle appUiStyle) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                color: appUiStyle.setBackgroundTheme(),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        todoTextField(appUiStyle),
                        const SizedBox(height: 10),
                        saveTodoButton(appUiStyle)
                      ],
                    )),
              ));
        });
  }

  Widget todoTextField(AppUiStyle appUiStyle) {
    return TextField(
      cursorColor: Palette.ultramarineBlue,
      textCapitalization: TextCapitalization.sentences,
      autofocus: true,
      style: TextStyle(color: appUiStyle.setTextTheme()),
      decoration: const InputDecoration(
        hintText: "Title",
        hintStyle: TextStyle(color: Colors.grey),
        contentPadding: EdgeInsets.all(8.0),
        border: InputBorder.none,
      ),
      onChanged: (String value) {
        title = value;
      },
    );
  }

  Widget saveTodoButton(AppUiStyle appUiStyle) {
    final DbCounterState dbCounterState = Provider.of<DbCounterState>(context);
    return Align(
      alignment: Alignment.centerRight,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            todoBox.add(
              TodoModel(title, ""),
            );
            dbCounterState.updateTodoCounter(todoBox.length);
            dbCounterState.saveDbCounterState();
            Navigator.of(context).pop();
          });
        },
        height: 40,
        minWidth: 40,
        color: Palette.ultramarineBlue,
        elevation: 0.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: const Text(
          "Save",
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }

  FloatingActionButton floatingActionButton(AppUiStyle appUiStyle) {
    return FloatingActionButton(
      onPressed: () {
        showNewTodoBottomSheet(appUiStyle);
      },
      tooltip: "Add new todo",
      backgroundColor: Palette.ultramarineBlue,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Icon(
        Icons.add,
        size: 40,
      ),
    );
  }

  void deleteUnDoneTodoOnLongPressDialog(BuildContext context, int index,
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
                  todoBox.deleteAt(index);
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