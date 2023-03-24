import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/model/palette/palette.dart';
import 'package:jungle/view/home/todo/todo_page.dart';
import 'package:jungle/view_model/set_theme/set_theme.dart';
import 'package:page_transition/page_transition.dart';
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
    final SetTheme setTheme = Provider.of<SetTheme>(context);
    return Scaffold(
      backgroundColor: setTheme.setBackgroundTheme(),
      appBar: buildAppBar(setTheme),
      body: buildBody(setTheme)
    );
  }

  AppBar buildAppBar(SetTheme setTheme){
    return AppBar(
      backgroundColor: setTheme.setBackgroundTheme(),
      elevation: 0.0,
      title: Text(
        "Completed todo",
        style: TextStyle(
          color: setTheme.setTextTheme()
        ),
      ),
      leading: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: MaterialButton(
            onPressed: (){
              Navigator.of(context).pop(
                PageTransition(
                  type: PageTransitionType.leftToRight,
                  child: TodoPage(toggleView: (){},)
                )
              );
            },
            minWidth: 10,
            shape: CircleBorder(
              side: BorderSide(
                color: setTheme.setTextTheme()
              )
            ),
            child: Icon(
            Icons.arrow_back,
            color: setTheme.setTextTheme()
            ),
          ),
        ),
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
              padding: const EdgeInsets.all(8.0),
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
      height: 50,
      elevation: 0.0,
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

  
}