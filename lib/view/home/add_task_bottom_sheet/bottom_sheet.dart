import 'package:flutter/material.dart';
import 'package:jungle/model/palette/palette.dart';

class AddTaskBottomSheet extends StatelessWidget{
  const AddTaskBottomSheet({super.key});

  @override 
  Widget build(context){
    return BottomSheet(
        onClosing: (){}, 
        builder: (context){
          return Padding(
            padding: const EdgeInsets.all(24),
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
                          const Expanded(
                            child: Text(
                              "Add new task",
                              style: TextStyle(
                                color: Colors.black,
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
                    const Divider(
                      thickness: 1.0,
                      color: Colors.grey,
                    ),
                    titleTextField(),
                    const SizedBox(height: 20),
                    descriptionTextField(),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        saveTaskButton(),
                        const SizedBox(width: 10),
                        deleteTaskButton()
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        }
      ); 
  }

    Widget titleTextField(){
    return const SizedBox(
      height: 50,
      child: TextField(
        textCapitalization: TextCapitalization.sentences,
        cursorColor: Colors.black,
        decoration: InputDecoration(
          hintText: "Title",
          labelText: "Title",
          border: OutlineInputBorder()
        ),
      ),
    );
  }

  Widget descriptionTextField(){
    return const TextField(
      cursorColor: Colors.black,
      maxLines: 10,
      decoration: InputDecoration(
        hintText: "Description",
        border: OutlineInputBorder()
      ),
    );
  }

  Widget saveTaskButton(){
    return MaterialButton(
      onPressed: (){},
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

  Widget deleteTaskButton(){
    return MaterialButton(
      onPressed: (){},
      color: Colors.red.shade600,
      elevation: 0.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: const Text(
        "Delete",
        style: TextStyle(
          fontSize: 17,
          color: Colors.white
        ),
      ),
    );
  }

} 