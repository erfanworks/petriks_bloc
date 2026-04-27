import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Terms Controller
class TermsController extends GetxController {
  final hasReadAll = false.obs;
  void onScrollEnd() => hasReadAll.value = true;
}



