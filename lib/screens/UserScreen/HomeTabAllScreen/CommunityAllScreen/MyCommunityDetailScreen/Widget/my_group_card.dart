import 'package:flutter/material.dart';
import '../../../../../../widget/GroupCard/group_card.dart';
import '../Controller/my_community_detail_controller.dart';

class MyGroupCard extends StatelessWidget {
  final GroupItem item;
  final VoidCallback onTap;

  const MyGroupCard({super.key, required this.item, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppGroupCard(
      image: item.image,
      name: item.name,
      memberCount: item.memberCount,
      onTap: onTap,
    );
  }
}
