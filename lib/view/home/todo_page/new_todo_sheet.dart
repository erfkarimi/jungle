import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:jungle/view_model/app_ui_style/app_ui_style.dart';
import '../../../constant/palette/palette.dart';
import '../../../model/todo_model/todo_model.dart';
import '../../../view_model/text_field_validation/text_field_validation.dart';
import '../../../widget/text_button_widget/text_button_widget.dart';

class NewTodoSheet extends StatefulWidget{
  
  const NewTodoSheet({super.key});

  @override
  State<NewTodoSheet> createState() => _NewTodoSheetState();
}

class _NewTodoSheetState extends State<NewTodoSheet> {
  final Box<TodoModel> todoBox = Hive.box<TodoModel>("todo");
  TextEditingController controller = TextEditingController();
  String title = "";
  DateTime presentDate = DateTime.now();
  TimeOfDay presentTime = TimeOfDay.now();
  DateTime? notifDate;
  TimeOfDay? notifTime;
  

  
  @override 
  Widget build(context){
    final AppUiStyle appUiStyle = Provider.of<AppUiStyle>(context);
    return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20)
                  ),
                  color: appUiStyle.setBackgroundTheme(),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        todoTextField(),
                        timeAndDatePickerWidget(),
                      ],
                    )),
              ));
  }

  Widget todoTextField() {
    return Consumer<TextFieldValidation>(
      builder: (context, textFieldValidation, _) {
        return TextField(
          cursorColor: Palette.ultramarineBlue,
          textCapitalization: TextCapitalization.sentences,
          autofocus: true,
          controller: controller,
          decoration: const InputDecoration(
            hintText: "Title",
            hintStyle: TextStyle(
              color: Colors.grey),
            contentPadding: EdgeInsets.all(8.0),
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

  Widget timeAndDatePickerWidget(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () async{
            notifDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2021),
              lastDate: DateTime(2040),
              );
              if(notifDate != null){
                setState(() {
                  presentDate = notifDate!;
                  showTP();
                });
                
              }
          },
          icon: const Icon(
            Icons.schedule,
            )),
            showTimeAndDate(),
            saveTodoButton()
      ],
    );
  }

  Future<void> showTP() async {
    notifTime =
        await showTimePicker(
          context: context, initialTime: presentTime);
    if (notifTime != null) {
      setState(() {
        presentTime = notifTime!;
      });
    }
  }

  Widget showTimeAndDate() {
    DateFormat currentDate = DateFormat("yyy-MM-dd");
    String date = currentDate.format(presentDate);
    String time = presentTime.format(context);
    return Align(
      alignment: Alignment.topLeft,
      child: presentTime == TimeOfDay.now() ? const Text("") : Text(
        "$time, $date",
        style: TextStyle(
            color: Palette.ultramarineBlue, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget saveTodoButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: Consumer<TextFieldValidation>(
        builder: (context, textFieldValidation, _) {
          return TextButtonWidget(
            function: (!textFieldValidation.isValid) ? null : () {
              setState(() {
                todoBox.add(
                  TodoModel(title, "",notifTime, notifDate,),
                );
                print(notifTime);
                textFieldValidation.todoTextFieldTitleChange("");
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
}