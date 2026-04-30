import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../../../../Widget/text/custom_text.dart';
import '../../../../../constant/const_color.dart';
import '../../../../../constant/const_string.dart';
import '../../../../../widget/AppImage/app_image.dart';
import '../../../../../widget/GlobalAppBar/global_app_bar.dart';
import '../FeedScreen/Controller/feed_controller.dart';

class CommentScreen extends StatelessWidget {
  const CommentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<FeedController>();
    return Scaffold(
      backgroundColor: ConstColor.white,
      appBar: GlobalAppBar(title: ConstString.comments, showBack: true),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              itemCount: c.comments.length,
              itemBuilder: (_, i) => _CommentItem(comment: c.comments[i], index: i, c: c),
            )),
          ),
          _CommentInputBar(c: c),
        ],
      ),
    );
  }
}

class _CommentItem extends StatelessWidget {
  final CommentModel comment;
  final int index;
  final FeedController c;
  const _CommentItem({required this.comment, required this.index, required this.c});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _CommentCard(
            comment: comment,
            isReply: false,
            onLike: () => c.onLikeComment(index),
            onReply: () => c.onReplyComment(index),
          ),
          // if (comment.reply != null)
          //   Padding(
          //     padding: EdgeInsets.only(left: 44.w, top: 8.h),
          //     child: _CommentCard(comment: comment.reply!, isReply: true, onLike: () {}, onReply: () {}),
          //   ),
        ],
      ),
    );
  }
}

// ─── Comment Card ─────────────────────────────────────────────────────────────
class _CommentCard extends StatelessWidget {
  final CommentModel comment;
  final bool isReply;
  final VoidCallback onLike, onReply;
  const _CommentCard({required this.comment, required this.isReply, required this.onLike, required this.onReply});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: ConstColor.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [BoxShadow(color: Colors.black.withAlpha(10), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: AppImage(path: comment.userImage, width: 36.w, height: 36.h, fit: BoxFit.cover),
              ),
              SizedBox(width: 10.w),
              Expanded(child: CustomText(title: comment.userName, textSize: 13.sp, fontWeight: FontWeight.w600, textColor: ConstColor.black, maxLine: 1)),
              CustomText(title: comment.timeAgo, textSize: 11.sp, textColor: ConstColor.grey, maxLine: 1),
            ],
          ),
          SizedBox(height: 8.h),

          // Content
          CustomText(title: comment.content, textSize: 13.sp, textColor: ConstColor.black, maxLine: 5),
          SizedBox(height: 10.h),

          // Like + Reply
          // Row(
          //   children: [
          //     _ActionBtn(icon: Icons.favorite_border_rounded, label: comment.likes.toString(), onTap: onLike),
          //     if (!isReply) ...[
          //       SizedBox(width: 16.w),
          //       _ActionBtn(icon: Icons.reply_rounded, label: ConstString.reply, onTap: onReply),
          //     ],
          //   ],
          // ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _ActionBtn({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.sp, color: ConstColor.grey),
          SizedBox(width: 4.w),
          CustomText(title: label, textSize: 12.sp, textColor: ConstColor.grey, maxLine: 1),
        ],
      ),
    );
  }
}

// ─── Comment Input Bar ────────────────────────────────────────────────────────
class _CommentInputBar extends StatelessWidget {
  final FeedController c;
  const _CommentInputBar({required this.c});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(16.w, 10.h, 16.w, 24.h),
      decoration: BoxDecoration(color: ConstColor.white, border: Border(top: BorderSide(color: ConstColor.borderColor))),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(color: ConstColor.backgroundColor, borderRadius: BorderRadius.circular(30.r)),
              child: Row(
                children: [
                  Icon(Icons.sentiment_satisfied_alt_outlined, size: 20.sp, color: ConstColor.grey),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: TextField(
                      onChanged: c.onCommentChanged,
                      style: TextStyle(fontSize: 13.sp, color: ConstColor.black, fontFamily: 'Roboto'),
                      decoration: InputDecoration(
                        hintText: ConstString.addAComment,
                        hintStyle: TextStyle(fontSize: 13.sp, color: ConstColor.grey, fontFamily: 'Roboto'),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      cursorColor: ConstColor.primaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 10.w),
          Obx(() => GestureDetector(
            onTap: c.isSendingComment.value ? null : c.onSendComment,
            child: Container(
              width: 44.w,
              height: 44.h,
              decoration: BoxDecoration(color: ConstColor.primaryColor, shape: BoxShape.circle),
              child: c.isSendingComment.value
                  ? Padding(padding: EdgeInsets.all(12.r), child: CircularProgressIndicator(color: ConstColor.white, strokeWidth: 2))
                  : Icon(Icons.send_rounded, color: ConstColor.white, size: 18.sp),
            ),
          )),
        ],
      ),
    );
  }
}