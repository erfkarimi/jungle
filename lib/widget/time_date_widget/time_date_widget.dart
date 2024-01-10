import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jungle/model/todo_model/todo_model.dart';

class TimeDateWidget extends StatefulWidget {
  final String? time;
  final String? date;
  final TodoModel? todoModel;
  final VoidCallback onFunction;
  const TimeDateWidget(
      {super.key,
      required this.time,
      required this.date,
      required this.todoModel,
      required this.onFunction
      });

  @override
  State<TimeDateWidget> createState() => TimeDateWidgetState();
}

class TimeDateWidgetState extends State<TimeDateWidget> {
  @override
  Widget build(context) {
    if (widget.todoModel!.timeOfDay != null && widget.todoModel!.dateTime != null) {
          return Row(
            children: [
              const Icon(Icons.schedule),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Theme.of(context).textTheme.bodyMedium!.color ??
                          Colors.white,
                    )),
                child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${widget.date} , ${widget.time}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                          width: 22,
                          height: 22,
                          child: IconButton(
                              padding: const EdgeInsets.all(0),
                              onPressed: widget.onFunction,
                              icon: const Icon(
                                Icons.close,
                                size: 20,
                              )))
                    ],
                  ),
              ),
            ],
          ).paddingAll(10);
    } else {
      return const Row(
        children: [
          Icon(Icons.schedule),
          SizedBox(width: 10),
          Text(
            "Not set",
            style: TextStyle(fontWeight: FontWeight.bold),
          )
        ],
      ).paddingAll(10);
    }
  }
}
