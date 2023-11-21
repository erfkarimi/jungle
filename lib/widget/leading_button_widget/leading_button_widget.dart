import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LeadingButtonWidget extends Padding{
  LeadingButtonWidget({super.key}):
  super(
    padding: const EdgeInsets.symmetric(vertical: 10),
        child: MaterialButton(
          onPressed: () {
            Get.back();
          },
          minWidth: 10,
          child: const Icon(Icons.arrow_back),
        ),
  );
}