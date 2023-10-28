part of 'completed.dart';

void showEditBottomSheet(
  BuildContext context,
  Box<TodoModel> completedTodoBox,
  AppUiStyle appUiStyle,
  int index
  ){
    showModalBottomSheet(
      context: context,
      isDismissible: false,
      isScrollControlled: true,
      useSafeArea: false,
      builder: (context){
        final completedTodoBox = Hive.box<TodoModel>("completed");
        final completedTodo = completedTodoBox.getAt(index) as TodoModel;
        return BottomSheet(
          onClosing: (){},
          enableDrag: false,
          builder: (context){
            return BottomSheet(
          backgroundColor: appUiStyle.setBackgroundTheme(),
          onClosing: (){},
          builder: (context){
            return Column(
            children: [
              const SizedBox(height: 14),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: ListView(
                    children: [
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              backButton(context, appUiStyle),
                              Text(
                                "Edit completed todo",
                                style: TextStyle(
                                  color: appUiStyle.setTextTheme(),
                                  fontSize: 18
                                ),
                              ),
                              TextButton(
                                onPressed: (){
                                  deleteTaskDialog(context, 
                                  appUiStyle, completedTodoBox, index);
                                },
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.red.shade600,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            thickness: 1.0,
                            color: appUiStyle.setTextFieldBorderTheme(),
                          ),
                          const SizedBox(height: 10),
                          titleTextField(context, appUiStyle, completedTodo),
                          const SizedBox(height: 10),
                          descriptionTextField(context, appUiStyle, completedTodo),
                          const SizedBox(height: 30),
                          updateCompletedTodoButton(context, appUiStyle, completedTodoBox, completedTodo, index)
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
    );
}

Widget backButton(
  BuildContext context,
  AppUiStyle appUiStyle
  ){
  return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: MaterialButton(
            onPressed: (){
              Navigator.pop(context);
            },
            minWidth: 10,
            shape: CircleBorder(
              side: BorderSide(
                color: appUiStyle.setTextTheme()
              )
            ),
            child: Icon(
            Icons.arrow_downward,
            color: appUiStyle.setTextTheme()
            ),
          ),
        );
}

 Widget titleTextField(
      BuildContext context,
      AppUiStyle appUiStyle,
      TodoModel todo
      ){
    return SizedBox(
      height: 50,
      child: TextFormField(
        cursorColor: Palette.ultramarineBlue,
        textCapitalization: TextCapitalization.sentences,
        textInputAction: TextInputAction.next,
        style: TextStyle(
          color: appUiStyle.setTextTheme()
        ),
        initialValue: todo.title,
        decoration: InputDecoration(
          hintText: "Title",
          hintStyle: const TextStyle(
            color: Colors.grey
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: appUiStyle.setTextFieldBorderTheme()
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: appUiStyle.setTextFieldBorderTheme()
            ),
        ),
      ),
      onChanged: (String value){
        todo.title = value;
      },
      )
    );
  }


  Widget descriptionTextField(
      BuildContext context,
      AppUiStyle appUiStyle,
      TodoModel todo
    ){
    return TextFormField(
      cursorColor: Palette.ultramarineBlue,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.newline,
      style: TextStyle(
        color: appUiStyle.setTextTheme()
      ),
      maxLines: 10,
      initialValue: todo.description,
      decoration: InputDecoration(
        hintText:  "Description",
        hintStyle: const TextStyle(
          color: Colors.grey
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: appUiStyle.setTextFieldBorderTheme()
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
              color: appUiStyle.setTextFieldBorderTheme()
            ),
        ),
      ),
      onChanged: (String value){
        todo.description = value;
      },
    );
  }

   Widget updateCompletedTodoButton(
      BuildContext context,
      AppUiStyle appUiStyle,
      Box<TodoModel> completedTodoBox,
      TodoModel todo,
      int index
    ){

    return MaterialButton(
      onPressed: (){
          completedTodoBox.putAt(index, TodoModel(
            todo.title,
            todo.description,
            ));
          Navigator.of(context).pop();
      },
      height: 48,
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


  void deleteTaskDialog(
      BuildContext context,
      AppUiStyle appUiStyle,
      Box<TodoModel> completedTodoBox,
      int index
    ){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          title: Text(
            "Deletion",
            style: TextStyle(
              color: appUiStyle.setTextTheme()
            )
          ),
          backgroundColor: appUiStyle.setBackgroundTheme(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
          ),
          content: Text(
            "Are you sure ?",
            style: TextStyle(
              color: appUiStyle.setTextTheme()
            )
          ),
          actions: [
            Consumer<DbCounterState>(
              builder: (context, dbCounterState, _) {
                return TextButton(
                  onPressed: (){
                    completedTodoBox.deleteAt(index);
                    dbCounterState.updateCompletedCounter(completedTodoBox.length);
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