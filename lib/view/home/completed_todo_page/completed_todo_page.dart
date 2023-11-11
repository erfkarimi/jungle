import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/constant/palette/palette.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import '../../../../model/todo_model/todo_model.dart';
import 'edit_completed_todo_page.dart';

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
      builder: (context, completedTodoBox, _){
        if(completedTodoBox.isEmpty){
          return showNoCompletedTodo(appUiStyle);
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
        Get.to(
          EditCompletedTodoPage(index: index),
          transition: Transition.cupertino);
      },
      onLongPress: ()=> deleteDoneTodoOnLongPressDialog(context, index, appUiStyle),
      height: 50,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: IconButton(
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
      title: Text(
        completedTodoBox.getAt(index)!.title,
        style: TextStyle(
          color: appUiStyle.setTextTheme(),
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.lineThrough),
        ),
        subtitle: completedTodoBox.getAt(index)!.description.isEmpty ? null :
        Text(
          completedTodoBox.getAt(index)!.description,
          maxLines: 2,
          style: TextStyle(
            color: appUiStyle.setDescriptionTheme(),
            decoration: TextDecoration.lineThrough
          ),
      ),
      ),
            
    );
  }

  Widget showNoCompletedTodo(AppUiStyle appUiStyle){
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "asset/image/to-do-list-rafiki.png",
              width: 250,
            ),
            Text(
              "Nothing is completed",
              style: TextStyle(
                fontSize: 17,
                color: appUiStyle.setTextTheme(),
                
              ),
            )
          ],
        ),
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
                style: TextStyle(
                  color: appUiStyle.setTextTheme(),
                  )),
            backgroundColor: appUiStyle.setBackgroundTheme(),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Text("Are you sure ?",
                style: TextStyle(
                  color: appUiStyle.setTextTheme(),
                  
                  )),
            actions: [
              TextButton(
                onPressed: () {
                  completedTodoBox.deleteAt(index);
                  Get.back();
                },
                child: const Text(
                  "Yes",
                  style: TextStyle(
                    
                  ),
                  ),
              ),
              TextButton(
                onPressed: ()=> Get.back(),
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.red.shade600,
                    
                    ),
                ),
              )
            ],
          );
        });
  }
}