import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jungle/view/home/todo_page/new_todo_sheet.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import 'package:jungle/widget/delete_dialog_widget.dart/delete_dialog_widget.dart';
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
  
  @override 
  Widget build(context){
    
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      floatingActionButton: floatingActionButton(),
      body: buildBody()
    );
  }

  Widget buildBody() {
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    return ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        builder: (context, todoBox, __) {
          if (todoBox.isEmpty) {
            return showNoTodo(appUiStyle);
          } else {
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: todoBox.length,
                  itemBuilder: (context, index) {
                    index = todoBox.length - 1 - index;
                    return todoButton(index, appUiStyle);
                  }),
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
      onLongPress: () => deleteUnDoneTodoOnLongPressDialog(index),
      height: 50,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Checkbox(
          shape: const CircleBorder(),
          value: false,
          onChanged: (value) {
            setState(() {
              todoBox.deleteAt(index);
              completedTodoBox.add(todo);
            });
          },
        ),
        title: Text(
          todoBox.getAt(index)!.title,
          style: const TextStyle(
            fontWeight: FontWeight.bold
            ),
        ),
        subtitle: todoBox.getAt(index)!.description.isEmpty ? null :
          Text(
            todoBox.getAt(index)!.description,
            maxLines: 2,
            style: TextStyle(
              color: appUiStyle.setDescriptionTheme()
            ),
        ),
      ),
    );
  }

  Widget showNoTodo(AppUiStyle appUiStyle) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "asset/image/task_image.png",
              width: 250,
            ),
            const Text(
              "No todo",
              style: TextStyle(
                fontSize: 17,),
            )
          ],
        ),
      ),
    );
  }
    void showNewTodoBottomSheet() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (context) {
          return StatefulBuilder(
            builder: (context, setState){
              return const NewTodoSheet();
            },
              
          );
        }
    );
  }

  

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton(
      onPressed: () {
        showNewTodoBottomSheet();
      },
      tooltip: "Add new todo",
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Icon(
        Icons.add,
        size: 40,
        //color: Colors.white,
      ),
    );
  }

  void deleteUnDoneTodoOnLongPressDialog(int index) {
      showDialog(
        context: context,
        builder: (context) {
          return DeleteDialogWidget(
            index: index,
            firstButtonFunction: (){
              todoBox.deleteAt(index);
              Get.back();
            },
          );
        });
  }
}