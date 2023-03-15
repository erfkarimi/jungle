import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:jungle/view/home/home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../../model/palette/palette.dart';
import '../../model/task_model/task_model.dart';
import '../../view_model/set_theme/set_theme.dart';

class AddNewTask extends StatelessWidget{
  const AddNewTask({super.key});

  @override 
  Widget build(context){
    final SetTheme setTheme = Provider.of<SetTheme>(context);
    return Scaffold(
      backgroundColor: setTheme.setBackgroundTheme(),
      appBar: buildAppBar(context, setTheme),
      body: buildBody(context, setTheme)
    );
  }

  AppBar buildAppBar(BuildContext context, SetTheme setTheme){
    return AppBar(
      backgroundColor: setTheme.setAppBarTheme(),
      elevation: 0.0,
      title: Text(
        "Add new task",
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
                  child: const Home()
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

  Widget buildBody(BuildContext context, SetTheme setTheme){
    final TextEditingController titleController = TextEditingController();
    final TextEditingController labelController = TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    final DateTime dateTime = DateTime.now();
    var formatter = DateFormat("yyyy-MM-dd");
    var currentDate = formatter.format(dateTime);
    return Padding(
      padding: const EdgeInsets.all(12),
      child: ListView(
        children: [
          const SizedBox(height: 10),
          titleTextField(context, setTheme, titleController),
          const SizedBox(height: 10),
          labelTextField(context, setTheme, labelController),
          const SizedBox(height: 10),
          descriptionTextField(context, setTheme, descriptionController),
          const SizedBox(height: 24),
          saveTaskButton(
            context,
            titleController, 
            labelController,
            descriptionController,
            currentDate
            )
        ],
      ),
    );
  }

  Widget titleTextField(
    BuildContext context,
     SetTheme setTheme,
     TextEditingController titleController
     ){ return SizedBox(
      height: 50,
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        
        style: TextStyle(
          color: setTheme.setTextTheme()
        ),
        controller: titleController,
        cursorColor: setTheme.setTextTheme(),
        decoration: InputDecoration(
          hintText:  "Title",
          hintStyle: const TextStyle(
            color: Colors.grey
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: setTheme.setTextFieldBorderTheme()
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
             color: setTheme.setTextFieldBorderTheme()
            ),
        ),
      ),
      )
    );
  }

   Widget labelTextField(
    BuildContext context,
    SetTheme setTheme,
    TextEditingController labelController
    ){
    return SizedBox(
      height: 50,
      child: TextField(
        cursorColor: setTheme.setTextTheme(),
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(
          color: setTheme.setTextTheme()
        ),
        controller: labelController,
        decoration: InputDecoration(
          hintText: "Label",
          hintStyle: const TextStyle(
            color: Colors.grey
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: setTheme.setTextFieldBorderTheme()
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: setTheme.setTextFieldBorderTheme()
              ),
          ),
        ),
      ),
    );
  }

  Widget descriptionTextField(
    BuildContext context,
    SetTheme setTheme,
    TextEditingController descriptionController
    ){
    
    return TextField(
      cursorColor: setTheme.setTextTheme(),
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(
        color: setTheme.setTextTheme()
      ),
      maxLines: 10,
      controller: descriptionController,
      decoration: InputDecoration(
        hintText:  "Description",
        hintStyle: const TextStyle(
          color: Colors.grey
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: setTheme.setTextFieldBorderTheme()
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: setTheme.setTextFieldBorderTheme()
            ),
        ),
      ),
    );
  }


  

  Widget saveTaskButton(
    BuildContext context, 
    TextEditingController titleController,
    TextEditingController labelController,
    TextEditingController descriptionController,
    String currentDate
  ){
    final taskBox = Hive.box<TaskModel>("task");
    return Align(
      alignment: Alignment.bottomRight,
      child: MaterialButton(
        onPressed: (){
            taskBox.add(
              TaskModel(
                titleController.text,
                labelController.text,
                descriptionController.text,
                currentDate
              ),
            );
            Navigator.of(context).pop();
        },
        minWidth: double.infinity,
        height: 44,
        color: Palette.ultramarineBlue,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
        ),
        child:  const Text(
           "Save",
          style: TextStyle(
            fontSize: 18,
            color: Colors.white
          ),
        ),
      ),
    );
  }
}