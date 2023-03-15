part of'../home.dart';

 void addTaskBottomSheet(
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
        final taskDB = Hive.box<TaskModel>("task");
        final task = taskDB.getAt(index) as TaskModel;
        return BottomSheet(
          backgroundColor: setTheme.setBackgroundTheme(),
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
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          TextButton(
                            onPressed: (){
                              deleteDialog(context,index, taskDB, setTheme);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Add new task",
                                  style: TextStyle(
                                    color: setTheme.setTextTheme(),
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600
                                  ),
                                ),
                                Text(
                                   "Delete",
                                  style: TextStyle(
                                    color: Colors.red.shade600,
                                    letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                  ),
                                ),
                              ],
                            ),
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
                          const SizedBox(height: 24),
                          updateTaskButton(context, index)
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
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(
          color: setTheme.setTextTheme()
        ),
        initialValue: task.title,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: "title",
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
        cursorColor: setTheme.setTextTheme(),
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(
          color: setTheme.setTextTheme()
        ),
        initialValue: taskModel.label,
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
      cursorColor: setTheme.setTextTheme(),
      style: TextStyle(
        color: setTheme.setTextTheme()
      ),
      maxLines: 10,
      initialValue: taskModel.description,
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
    return MaterialButton(
      onPressed: (){
          taskBox.putAt(index, TaskModel(
            task.title, task.label,
            task.description, task.currentDate
            ));
          Navigator.of(context).pop();
      },
      height: 44,
      minWidth: double.infinity,
      color: Palette.ultramarineBlue,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      child: const  Text(
        "Update",
        style: TextStyle(
          fontSize: 18,
          color: Colors.white
        ),
      ),
    );
  }


  void deleteDialog(
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
            TextButton(
              onPressed: (){
                taskDB.deleteAt(index);
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text("Yes"),
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