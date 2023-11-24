
  import 'package:flutter/material.dart';
import 'package:servicesapp/core/utils/size_utils.dart';
import 'package:servicesapp/theme/theme_helper.dart';
import 'package:velocity_x/velocity_x.dart';

Widget buildKeyValue(String key, String? value) {
    return Text(
      "${key} ${value}",
      style: TextStyle(color: appTheme.black),
    ).w(mediaQueryData.size.width);
  }