part of '../task_page.dart';

void editTaskBottomSheet(
  BuildContext context,
  SetTheme setTheme,
  int index
  ){
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context){
        final taskBox = Hive.box<TaskModel>("task");
        final task = taskBox.getAt(index) as TaskModel;
        return BottomSheet(
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
                  color: setTheme.setTextTheme(),
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Edit task",
                              style: TextStyle(
                                color: setTheme.setTextTheme(),
                                fontSize: 18,
                                fontWeight: FontWeight.w600
                              ),
                            ),
                            const Expanded(child: SizedBox()),
                            updateTaskButton(context, index),
                            const SizedBox(width: 10),
                            deleteTaskButton(context, index, taskBox, setTheme)
                      
                      ],
                      ),
                      Divider(
                        thickness: 1.0,
                        color: setTheme.setTextFieldBorderTheme(),
                      ),
                      const SizedBox(height: 10),
                      titleTextField(
                        context,
                        setTheme,
                        task
                        ),
                      const SizedBox(height: 10),
                      labelTextField(context, setTheme, task),
                      const SizedBox(height: 10),
                      descriptionTextField(context, setTheme, task),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          );
          }
          );
      }
    );
  }

    Widget titleTextField(
      BuildContext context,
      SetTheme setTheme,
      TaskModel task
      ){
    return SizedBox(
      height: 50,
      child: TextFormField(
        cursorColor: Palette.ultramarineBlue,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        style: TextStyle(
          color: setTheme.setTextTheme(),
          fontSize: 26, fontWeight: FontWeight.bold
        ),
        initialValue: task.title,
        decoration: const InputDecoration(
          hintText: "Title",
          hintStyle: TextStyle(
            color: Colors.grey
          ),
          border: InputBorder.none
      ),
      onChanged: (String value){
        task.title = value;
      },
      )
    );
  }

  Widget labelTextField(
    BuildContext context,
    SetTheme setTheme,
    TaskModel taskModel
    ){
    return SizedBox(
      height: 50,
      child: TextFormField(
        cursorColor: Palette.ultramarineBlue,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        style: TextStyle(
          color: setTheme.setTextTheme()
        ),
        initialValue: taskModel.label,
        decoration: InputDecoration(
          hintText: "Label",
          hintStyle: const TextStyle(
            color: Colors.grey
          ),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.tag,
          color: setTheme.setTextTheme(),)
        ),
        onChanged: (String value){
          taskModel.label = value;
        },
      ),
    );
  }

  Widget descriptionTextField(
    BuildContext context,
    SetTheme setTheme,
    TaskModel taskModel
    ){
    return TextFormField(
      cursorColor: Palette.ultramarineBlue,
      style: TextStyle(
        color: setTheme.setTextTheme()
      ),
      maxLines: 10,
      textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.newline,
      initialValue: taskModel.description,
      decoration: const InputDecoration(
        hintText:  "Description",
        hintStyle: TextStyle(
          color: Colors.grey
        ),
        border: InputBorder.none
      ),
      onChanged: (String value){
        taskModel.description = value;
      },
    );
  }

  Widget updateTaskButton(
    BuildContext context,
    int index){
    final taskBox = Hive.box<TaskModel>("task");
    final task = taskBox.getAt(index) as TaskModel;
    return TextButton(
      onPressed: (){
          taskBox.putAt(index, TaskModel(
            task.title, task.label,
            task.description, task.currentDate
            ));
          Navigator.of(context).pop();
      },
      child: const  Text(
        "Update",
        style: TextStyle(
          fontSize: 16, fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget deleteTaskButton(
    BuildContext context,
    int index,
    Box<TaskModel> taskBox,
    SetTheme setTheme
  ){
    return TextButton(
    onPressed: () {
      deleteTaskDialog(context, index, taskBox, setTheme);
    },
    child: Text(
      "Delete",
      style: TextStyle(
          color: Colors.red.shade600,
          fontWeight: FontWeight.bold,
          fontSize: 16),
    ),
  );
  }


  void deleteTaskDialog(
    BuildContext context,
    int index, Box<TaskModel> taskDB,
    SetTheme setTheme
    ){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text(
            "Deletion",
            style: TextStyle(
              color: setTheme.setTextTheme()
            )
          ),
          backgroundColor: setTheme.setBackgroundTheme(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          content: Text(
            "Are you sure ?",
            style: TextStyle(
              color: setTheme.setTextTheme()
            )
          ),
          actions: [
            Consumer<DbCounterState>(
              builder: (context, dbCounterState, _) {
                return TextButton(
                  onPressed: (){
                    taskDB.deleteAt(index);
                    dbCounterState.updateTaskCounter(taskDB.length);
                    dbCounterState.saveDbCounterState();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: const Text("Yes"),
                );
              }
            ),
            TextButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
              child: Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.red.shade600
                ),
                ),
            )
          ],
        );
      }
     );
  }