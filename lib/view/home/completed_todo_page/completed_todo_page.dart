import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jungle/constant/palette/palette.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import 'package:jungle/widget/delete_dialog_widget.dart/delete_dialog_widget.dart';
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
          return showNoCompletedTodo();
        } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: completedTodoBox.length,
                itemBuilder: (context, int index){
                  index = completedTodoBox.length - 1 - index;
                  return completedTodoButton(index);
                }
                ),
            );
        }
      }
      );
  }

  Widget completedTodoButton(int index){
    final completedTodo = completedTodoBox.getAt(index) as TodoModel;
    return MaterialButton(
      onPressed: (){
        Get.to(
          EditCompletedTodoPage(index: index),
          transition: Transition.cupertino);
      },
      onLongPress: ()=> deleteDoneTodoOnLongPressDialog(context, index),
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
          Icons.task_alt_outlined,
          color: Palette.ultramarineBlue,
          ),
      ),
      title: Text(
        completedTodoBox.getAt(index)!.title,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          decoration: TextDecoration.lineThrough),
        ),
        subtitle: completedTodoBox.getAt(index)!.description.isEmpty ? null :
        Text(
          completedTodoBox.getAt(index)!.description,
          maxLines: 2,
          style: const TextStyle(
            decoration: TextDecoration.lineThrough
          ),
      ),
      ),
    );
  }

  Widget showNoCompletedTodo(){
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "asset/image/to-do-list-cuate.png",
              width: 250,
            ),
            const Text(
              "Nothing is completed",
              style: TextStyle(
                fontSize: 17,
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
    ) {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteDialogWidget(
            index: index,
            firstButtonFunction: (){
              completedTodoBox.deleteAt(index);
                  Get.back();
            },
  
          );
        });
  }
}