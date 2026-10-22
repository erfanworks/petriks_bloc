import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../constant/const_color.dart';

class OtherReasonField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final int maxLength;

  const OtherReasonField({
    super.key,
    required this.controller,
    this.hintText = 'Please tell us more...',
    this.maxLength = 250,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: TextField(
        controller: controller,
        autofocus: true,
        minLines: 3,
        maxLines: 4,
        maxLength: maxLength,
        keyboardType: TextInputType.multiline,
        textCapitalization: TextCapitalization.sentences,
        style: TextStyle(fontSize: 14.sp, color: ConstColor.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(fontSize: 14.sp, color: ConstColor.grey),
          filled: true,
          fillColor: Colors.white,
          contentPadding: EdgeInsets.all(14.r),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: ConstColor.borderColor),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.r),
            borderSide: const BorderSide(color: ConstColor.primaryColor),
          ),
        ),
      ),
    );
  }
}
