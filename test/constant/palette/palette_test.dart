import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:jungle/constant/palette/palette.dart';

void main(){
  test('color assignment', () {
    expect(Palette.ultramarineBlue, const Color(0xff3166ff));
  });
}