import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:jungle/view_model/text_field_validation/text_field_validation.dart';
import 'package:jungle/widget/delete_dialog_widget.dart/delete_dialog_widget.dart';
import 'package:jungle/widget/leading_button_widget/leading_button_widget.dart';
import 'package:jungle/widget/text_button_widget/text_button_widget.dart';
import 'package:jungle/widget/time_date_widget/time_date_widget.dart';
import 'package:provider/provider.dart';
import '../../../constant/snack_bar/snack_bar.dart';
import '../../../model/task_model/task_model.dart';
import '../../service/notification_service/notification_service.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'dart:ui' as ui;

class EditCompletedTaskPage extends StatefulWidget {
  final int index;
  const EditCompletedTaskPage({super.key, required this.index});

  @override
  State<EditCompletedTaskPage> createState() => _EditCompletedTaskPageState();
}

class _EditCompletedTaskPageState extends State<EditCompletedTaskPage> {
  final Box<TaskModel> todoBox = Hive.box<TaskModel>("task");
  final Box<TaskModel> compTodoBox = Hive.box<TaskModel>("completed");
  String title = "";
  String description = "";
  DateTime? dateTime;
  TimeOfDay? timeOfDay;
  bool titleRTL = false;
  bool descriptionRTL = false;

  @override
  Widget build(context) {
    final compTask = compTodoBox.getAt(widget.index) as TaskModel;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: buildAppBar(compTask),
      body: buildBody(compTask),
    );
  }

  AppBar buildAppBar(TaskModel compTask) {
    return AppBar(
      title: Text(
        AppLocalizations.of(context)!.editUncompTaskBarTitle,
      ),
      leading: LeadingButtonWidget(),
      actions: [deleteCompletedTodoButton()],
    );
  }

  Widget buildBody(TaskModel compTask) {
    return LayoutBuilder(builder: (context, constraint) {
      return SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ConstrainedBox(
          constraints: BoxConstraints(minHeight: constraint.maxHeight),
          child: IntrinsicHeight(
            child: Column(
              children: [
                titleTextField(compTask),
                timeAndDateWidget(compTask),
                descriptionTextField(compTask),
                const Expanded(child: SizedBox()),
                markUncompletedButtonWidget(compTask)
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget titleTextField(TaskModel compTask) {
    return Consumer<TextFieldValidation>(
        builder: (context, textFieldValidation, _) {
      return TextFormField(
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.next,
          textDirection:
              compTask.titleRTL ? ui.TextDirection.rtl : ui.TextDirection.ltr,
          maxLines: null,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          initialValue: compTask.title,
          decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.titleTextFieldTitle,
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              prefixIcon: const Icon(Icons.tag),
              border: InputBorder.none),
          onChanged: (String value) {
            textFieldValidation.rtlCheck(value);
            titleRTL = textFieldValidation.rTol;
            setState(() {
              compTodoBox.putAt(
                  widget.index,
                  TaskModel(
                      title: value,
                      description: compTask.description,
                      dateTime: compTask.dateTime,
                      timeOfDay: compTask.timeOfDay,
                      titleRTL: titleRTL,
                      descriptionRTL: compTask.descriptionRTL));
            });
          });
    });
  }

  Widget timeAndDateWidget(TaskModel compTask) {
    DateFormat currentDate = DateFormat("yyyy-MM-dd");
    DateTime date = compTask.dateTime ?? DateTime.now();
    TimeOfDay time = compTask.timeOfDay ?? TimeOfDay.now();
    String formattedDate = Jiffy.parse(currentDate.format(date)).MMMEd;

    return TimeDateWidget(
        time: time.format(context),
        date: formattedDate,
        task: compTask,
        onFunction: () {
          setState(() {
            NotificationService()
                .cancelNotification(compTodoBox.getAt(widget.index)!.id);
            compTodoBox.putAt(
                widget.index,
                TaskModel(
                    title: compTask.title,
                    description: compTask.description,
                    dateTime: compTask.dateTime,
                    timeOfDay: compTask.timeOfDay,
                    id: compTask.id,
                    titleRTL: compTask.titleRTL,
                    descriptionRTL: compTask.descriptionRTL));
          });
        });
  }

  Widget descriptionTextField(TaskModel compTask) {
    return Consumer<TextFieldValidation>(
        builder: (context, textFieldValidation, _) {
      return TextFormField(
          textCapitalization: TextCapitalization.sentences,
          textInputAction: TextInputAction.newline,
          maxLines: null,
          initialValue: compTask.description,
          textDirection: compTask.descriptionRTL
              ? ui.TextDirection.rtl
              : ui.TextDirection.ltr,
          decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.descriptionTextFieldTitle,
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
              border: InputBorder.none),
          onChanged: (String value) {
            textFieldValidation.rtlCheck(value);
            descriptionRTL = textFieldValidation.rTol;
            setState(() {
              compTodoBox.putAt(
                  widget.index,
                  TaskModel(
                      title: compTask.title,
                      description: value,
                      dateTime: compTask.dateTime,
                      timeOfDay: compTask.timeOfDay,
                      id: compTask.id,
                      titleRTL: compTask.titleRTL,
                      descriptionRTL: descriptionRTL));
            });
          });
    });
  }

  Widget markUncompletedButtonWidget(TaskModel compTask) {
    return Align(
      alignment: Alignment.bottomRight,
      child: TextButton(
        onPressed: () {
          Get.back();
          compTodoBox.deleteAt(widget.index);
          todoBox.add(compTask);
          showMarkedUncompSnackBar(context);
        },
        child: Text(
          AppLocalizations.of(context)!.markUncompButtonTitle,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget deleteCompletedTodoButton() {
    return TextButtonWidget(
      function: () => deleteCompletedTodoDialog(),
      buttonTitle: AppLocalizations.of(context)!.firstDialogButtonTitle,
      color: Colors.red.shade600,
    );
  }

  void deleteCompletedTodoDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return DeleteDialogWidget(
            index: widget.index,
            firstButtonFunction: () {
              compTodoBox.deleteAt(widget.index);
              Get.back();
              Get.back();
            },
          );
        });
  }
}