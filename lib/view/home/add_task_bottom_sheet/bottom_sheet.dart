import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:jungle/model/palette/palette.dart';
import 'package:jungle/model/task_model/task_model.dart';
import 'package:jungle/view_model/change_theme/theme.dart';
import 'package:provider/provider.dart';

class AddTaskBottomSheet extends StatefulWidget{
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  
  @override 
  Widget build(context){
    final ChangeTheme changeTheme = Provider.of<ChangeTheme>(context);
    return BottomSheet(
      backgroundColor: changeTheme.changeBackgroundTheme(),
        onClosing: (){}, 
        enableDrag: false,
        builder: (context){
          return Column(
            children: [
              const SizedBox(height: 14),
              Container(
                height: 5,
                width: 50,
                decoration: BoxDecoration(
                  color: changeTheme.changeTextTheme(),
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          TextButton(
                            onPressed: (){
                              Navigator.of(context).pop();
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Text(
                                    "Add new task",
                                    style: TextStyle(
                                      color: changeTheme.changeTextTheme(),
                                      fontSize: 18
                                    ),
                                  ),
                                ),
                                Text(
                                  "close",
                                  style: TextStyle(
                                    color: Colors.red.shade600,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          Divider(
                            thickness: 1.0,
                            color: changeTheme.changeTextTheme(),
                          ),
                          const SizedBox(height: 10),
                          titleTextField(changeTheme),
                          const SizedBox(height: 20),
                          descriptionTextField(changeTheme),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              saveTaskButton(),
                              const SizedBox(width: 10),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      ); 
  }

    Widget titleTextField(ChangeTheme changeTheme){
    return SizedBox(
      height: 50,
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(
          color: changeTheme.changeTextTheme()
        ),
        controller: titleController,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: "Title",
          hintStyle: TextStyle(
            color: changeTheme.changeTextTheme()
          ),
          labelText: "Title",
          labelStyle: TextStyle(
            color: changeTheme.changeTextTheme()
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: changeTheme.changeTextTheme()
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: changeTheme.changeTextTheme()
            ),
        ),
      ),
      )
    );
  }

  Widget descriptionTextField(ChangeTheme changeTheme){
    return TextField(
      cursorColor: changeTheme.changeTextTheme(),
      style: TextStyle(
        color: changeTheme.changeTextTheme()
      ),
      maxLines: 10,
      controller: descriptionController,
      decoration: InputDecoration(
        hintText: "Description",
        hintStyle: TextStyle(
          color: changeTheme.changeTextTheme()
        ),
        border: OutlineInputBorder(
            borderSide: BorderSide(
              color: changeTheme.changeTextTheme()
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: changeTheme.changeTextTheme()
            ),
        ),
      ),
    );
  }

  Widget saveTaskButton(){
    final taskBox = Hive.box<TaskModel>("task");
    return MaterialButton(
      onPressed: (){
          taskBox.add(
            TaskModel(titleController.text,
            descriptionController.text
            ),
          );
          Navigator.of(context).pop();
      },
      color: Palette.copenhagenBlue,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: const Text(
        "Save",
        style: TextStyle(
          fontSize: 17,
          color: Colors.white
        ),
      ),
    );
  }
} 