part of 'completed_todo.dart';

void showEditBottomSheet(
  BuildContext context,
  Box<TodoModel> completedTodoBox,
  SetTheme setTheme,
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
          backgroundColor: setTheme.setBackgroundTheme(),
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
                              backButton(context, setTheme),
                               Text(
                                "Edit completed todo",
                                style: TextStyle(
                                  color: setTheme.setTextTheme(),
                                  fontSize: 18
                                ),
                              ),
                              TextButton(
                                onPressed: (){
                                  deleteTaskDialog(context, 
                                  setTheme, completedTodoBox, index);
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
                            color: setTheme.setTextFieldBorderTheme(),
                          ),
                          const SizedBox(height: 10),
                          titleTextField(context, setTheme, completedTodo),
                          const SizedBox(height: 10),
                          descriptionTextField(context, setTheme, completedTodo),
                          const SizedBox(height: 30),
                          updateCompletedTodoButton(context, setTheme, completedTodoBox, completedTodo, index)
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
  SetTheme setTheme
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
                color: setTheme.setTextTheme()
              )
            ),
            child: Icon(
            Icons.arrow_downward,
            color: setTheme.setTextTheme()
            ),
          ),
        );
}

 Widget titleTextField(
      BuildContext context,
      SetTheme setTheme,
      TodoModel todo
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
        initialValue: todo.title,
        decoration: InputDecoration(
          hintText: "Title",
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
        todo.title = value;
      },
      )
    );
  }


  Widget descriptionTextField(
      BuildContext context,
      SetTheme setTheme,
      TodoModel todo
    ){
    return TextFormField(
      cursorColor: Palette.ultramarineBlue,
      textCapitalization: TextCapitalization.sentences,
      textInputAction: TextInputAction.newline,
      style: TextStyle(
        color: setTheme.setTextTheme()
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
        todo.description = value;
      },
    );
  }

   Widget updateCompletedTodoButton(
      BuildContext context,
      SetTheme setTheme,
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
      SetTheme setTheme,
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
                completedTodoBox.deleteAt(index);
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