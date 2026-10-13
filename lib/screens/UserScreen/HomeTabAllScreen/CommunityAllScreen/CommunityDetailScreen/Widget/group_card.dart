import 'package:flutter/material.dart';
import '../../../../../../widget/GroupCard/group_card.dart';
import '../Controller/community_detail_controller.dart';

class GroupCard extends StatelessWidget {
  final GroupItem item;
  final VoidCallback onTap;

  const GroupCard({super.key, required this.item, required this.onTap});

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
