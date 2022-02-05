import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks/modelView/provider/upated_state.dart';
import 'screen/home.dart';

void main(){
  runApp(
    ChangeNotifierProvider(
    create: (context) => UpdateState(),
    child: const App(),
  ));
}

class App extends StatelessWidget{
  const App({Key? key}) : super(key: key);
  @override 
  Widget build(context){
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}