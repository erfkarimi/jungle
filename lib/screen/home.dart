import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tasks/model/task_model.dart';
import 'package:tasks/modelView/provider/upated_state.dart';

class Home extends StatefulWidget{
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override 
  Widget build(context){
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        resizeToAvoidBottomInset: false,
        appBar: appBar(),
        floatingActionButton: floatingActionButton(),
        body: body(),
      ),
    );
  }

    /* -------------------------------Functions----------------------------------- */

  // Widgets
  AppBar appBar(){
    return AppBar(
      title: const Text("Tasks",
        style: TextStyle(
          color: Colors.black
        ),),
        centerTitle: true,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent

        ),
        elevation: 0.0,
        backgroundColor: const Color(0xFF929fd1),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu,
            color: Color(0xFF000000),),
            onPressed: (){
              menuBottomSheet();
            },
          )
        ],
        bottom: const TabBar(
          indicatorColor: Color(0xFF0C2333),
          labelColor: Colors.black,
          indicatorWeight: 3.5,
          indicatorPadding: EdgeInsets.symmetric(horizontal: 30),
          //indicatorSize: TabBarIndicatorSize.values,
          tabs: [
            Tab(
              child: Text("My Tasks"),
            ),
            Tab(
              child: Text("Completed"),
            )
          ],
        ),
    );
  }

  // FloatinActionButton Widget
  FloatingActionButton floatingActionButton(){
    return FloatingActionButton.extended(
      label: Row(
        children: const [
          Icon(Icons.edit,
          color: Colors.black,),
          SizedBox(width: 5.0),
           Text("New Task",
          style: TextStyle(color: Colors.black),),
        ],
      ),
      backgroundColor: const Color(0xFF929fd1),
      onPressed: (){
        addNewTask();
      },
    );
  }

  // Scaffold Body
  Widget body(){
    return TabBarView(
      children: [
        tasks(),
        completed()
      ],
    );
  }

  // No item Widget
  Widget noItemWidget(){
    return const Padding(
      padding: EdgeInsets.all(15),
      child: Center(
        child: Text("No item"),
      )
    ); 
  }

  // Tasks Widget
  Widget tasks(){
    final state = Provider.of<UpdateState>(context);
    List tasksList = List.from(state.tasks.reversed);
    if(state.tasks.isEmpty){
      return noItemWidget();
    } else{
      return ListView.builder(
        itemCount: tasksList.length,
        itemBuilder: (context, int index){
          return Padding(
            padding: const EdgeInsets.only(
              top: 10, left: 10, right: 10),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(20)
              ),
              child: ListTile(
                leading: Checkbox(
                   shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(10)
                   ),
                   activeColor: const Color(0xFF929fd1),
                  value: tasksList[index].isCompleted,
                   onChanged: (value){
                     setState(() {
                       if(tasksList[index].isCompleted == false){
                        tasksList[index].isCompleted = true;
                     } else {
                        tasksList[index].isCompleted = false;
                     }
                     });
                     
                     }
                   ),
                   title: Text(tasksList[index].title.toString()),
                   trailing: IconButton(
                     icon: const Icon(Icons.delete),
                     onPressed: (){
                         state.deleteTaskFromTasksList(index);
                     },
                   ),
              ),
            ),
          );
        },
      );
    }
  }

  // Completed Widget
  Widget completed(){
    return Column();
  }

  // Add new task Field
  Future addNewTask(){

    final state = Provider.of<UpdateState>(context, listen: false);
    TaskModel taskModel = TaskModel();

    return showModalBottomSheet(
    backgroundColor: Colors.white,
    context: context,
    isScrollControlled: true,
    builder: (context) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 8.0,
            ),
            Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                  left: 10,
                  right: 10),
              child: Column(
                children: [
                   TextField(
                    cursorColor: Colors.black,
                    textCapitalization: TextCapitalization.values.first,
                    decoration: const InputDecoration(
                      hintText: 'New Task',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(14)
                    ),
                    autofocus: true,
                    onChanged: (value){
                      taskModel.title = value;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          child: const Text("Save",
                          style: TextStyle(
                            color: Color(0xFF929fd1),
                            fontSize: 17
                          ),),
                          onPressed: (){
                            state.updateTasksList(taskModel);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

            ),
          ]
       )
    );
  }

  // Menu Bottom Sheet
  void menuBottomSheet(){
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
     builder: (context){
       return SizedBox(
         height: 220,
         child: Column(
           children: [
             const SizedBox(height: 10,),
             Container(
               height: 5,
               width: 100,
               decoration: BoxDecoration(
                 color: Colors.black,
                 borderRadius: BorderRadius.circular(20)
               ),
             ),
             const SizedBox(height: 10,),
             // Lanuguage Button
             MaterialButton(
               child: const ListTile(
                 leading: Icon(Icons.translate_outlined,
                 color: Colors.black,),
                 title: Text("Language"),
                 trailing: Text("English",
                 style: TextStyle(color: Colors.grey),),
               ),
               onPressed: (){

               }),
               // Theme Button
               MaterialButton(
               child: const ListTile(
                 leading: Icon(Icons.brightness_2_outlined,
                 color: Colors.black,),
                 title: Text("Theme",
                          style: TextStyle(
                            color: Colors.black
                          ),),
                 trailing: Text("Light",
                 style: TextStyle(color: Colors.grey),),
               ),
               onPressed: (){

               }),
              // Trash Button
              MaterialButton(
               child: const ListTile(
                 leading: Icon(Icons.delete_outline,
                 color: Colors.black,),
                 title: Text("Trash",
                          style: TextStyle(
                            color: Colors.black
                          ),),
                 trailing: Text("No item",
                 style: TextStyle(color: Colors.grey),),
               ),
               onPressed: (){

               })
           ],
         ),
       );
     }
     );
  }
}