import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jungle/view_model/set_theme/set_theme.dart';
import 'package:provider/provider.dart';
import '../../../model/palette/palette.dart';
import '../../../model/todo_model/todo_model.dart';

part 'edit_todo.dart';

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
    
    final SetTheme setTheme = Provider.of<SetTheme>(context);
    return Scaffold(
      backgroundColor: setTheme.setBackgroundTheme(),
      floatingActionButton: floatingActionButton(setTheme),
      body: buildBody(setTheme)
    );
  }

  Widget buildBody(SetTheme setTheme) {
    return ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: (context, todoBox, __) {
          if (todoBox.isEmpty) {
            return showNoTodo(setTheme);
          } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: setTheme.setAppBarTheme(),
                    border: Border.all(color: Colors.black)),
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: todoBox.length,
                    itemBuilder: (context, int index) {
                      index = todoBox.length - 1 - index;
                      return todoButton(index, setTheme);
                    }),
              ),
            );
          }
        });
  }

  Widget todoButton(int index, SetTheme setTheme) {
    final todo = todoBox.getAt(index) as TodoModel;
    return MaterialButton(
      onPressed: () {
        showEditBottomSheet(context, todoBox, setTheme, index);
      },
      onLongPress: () => deleteUnDoneTodoOnLongPressDialog(context, index, setTheme),
      height: 50,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          Checkbox(
            shape: const CircleBorder(),
            value: false,
            onChanged: (value) {
              setState(() {
                todoBox.deleteAt(index);
                completedTodoBox.add(todo);
              });
            },
          ),
          Text(
            todoBox.getAt(index)!.title,
            style: TextStyle(
              color: setTheme.setTextTheme()
              
              ),
          ),
        ],
      ),
    );
  }

  Widget showNoTodo(SetTheme setTheme) {
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
            style: TextStyle(fontSize: 17, color: setTheme.setTextTheme()),
          )
        ],
      ),
    );
  }
    void showNewTodoBottomSheet(SetTheme setTheme) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                color: setTheme.setBackgroundTheme(),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        todoTextField(setTheme),
                        const SizedBox(height: 10),
                        saveTodoButton(setTheme)
                      ],
                    )),
              ));
        });
  }

  Widget todoTextField(SetTheme setTheme) {
    return TextField(
      cursorColor: Palette.ultramarineBlue,
      textCapitalization: TextCapitalization.sentences,
      autofocus: true,
      style: TextStyle(color: setTheme.setTextTheme()),
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

  Widget saveTodoButton(SetTheme setTheme) {
    return Align(
      alignment: Alignment.centerRight,
      child: MaterialButton(
        onPressed: () {
          setState(() {
            todoBox.add(
              TodoModel(title, ""),
            );
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

  FloatingActionButton floatingActionButton(SetTheme setTheme) {
    return FloatingActionButton(
      onPressed: () {
        showNewTodoBottomSheet(setTheme);
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