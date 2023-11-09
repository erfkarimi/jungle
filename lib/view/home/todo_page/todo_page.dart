import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jungle/view_model/db_counter_state/db_counter_state.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import 'package:jungle/view_model/text_field_validation/text_field_validation.dart';
import 'package:jungle/widget/delete_dialog_widget.dart/delete_dialog_widget.dart';
import 'package:jungle/widget/text_button_widget/text_button_widget.dart';
import '../../../constant/palette/palette.dart';
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
      onLongPress: () => deleteUnDoneTodoOnLongPressDialog(index, appUiStyle),
      height: 50,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Consumer<DbCounterState>(
            builder: (context, dbCounterState, _) {
              return ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: Checkbox(
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
                ),
                title: Text(
                  todoBox.getAt(index)!.title,
                  style: TextStyle(
                    color: appUiStyle.setTextTheme(),
                    fontFamily: appUiStyle.font,
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
              );
            }
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
            style: TextStyle(
              fontFamily: appUiStyle.font,
              fontSize: 17, color: appUiStyle.setTextTheme()),
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
                        timeAndDatePickerWidget(appUiStyle),
                      ],
                    )),
              ));
        });
  }

  Widget todoTextField(AppUiStyle appUiStyle) {
    return Consumer<TextFieldValidation>(
      builder: (context, textFieldValidation, _) {
        return TextField(
          cursorColor: Palette.ultramarineBlue,
          textCapitalization: TextCapitalization.sentences,
          autofocus: true,
          style: TextStyle(
            fontFamily: appUiStyle.font,
            color: appUiStyle.setTextTheme()),
          decoration: InputDecoration(
            hintText: "Title",
            hintStyle: TextStyle(
              fontFamily: appUiStyle.font,
              color: Colors.grey),
            contentPadding: const EdgeInsets.all(8.0),
            border: InputBorder.none,
          ),
          onChanged: (String value) {
            title = value;
            textFieldValidation.todoTextFieldTitleChange(value);
          },
        );
      }
    );
  }

  Widget timeAndDatePickerWidget(AppUiStyle appUiStyle){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: (){},
          icon: Icon(
            Icons.schedule,
            color: appUiStyle.setTextTheme(),
            )),
            saveTodoButton(appUiStyle)
      ],
    );
  }

  Widget saveTodoButton(AppUiStyle appUiStyle) {
    final DbCounterState dbCounterState = Provider.of<DbCounterState>(context);
    return Align(
      alignment: Alignment.centerRight,
      child: Consumer<TextFieldValidation>(
        builder: (context, textFieldValidation, _) {
          return TextButtonWidget(
            function: (!textFieldValidation.isValid) ? null : () {
              setState(() {
                todoBox.add(
                  TodoModel(title, ""),
                );
                dbCounterState.updateTodoCounter(todoBox.length);
                dbCounterState.saveDbCounterState();
                Get.back();
              });
            },
            buttonTitle: "Save",
            color: (!textFieldValidation.isValid) 
            ?Colors.grey : Palette.ultramarineBlue,
          );
        }
      ),
    );
  }

  FloatingActionButton floatingActionButton(AppUiStyle appUiStyle) {
    return FloatingActionButton(
      onPressed: () {
        showNewTodoBottomSheet(appUiStyle);
      },
      tooltip: "Add new todo",
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: const Icon(
        Icons.add,
        size: 40,
        color: Colors.white,
      ),
    );
  }

  void deleteUnDoneTodoOnLongPressDialog(int index, AppUiStyle appUiStyle) {
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