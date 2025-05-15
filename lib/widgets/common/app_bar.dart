import 'package:flutter/material.dart';
import 'package:untitled4/const.dart';


class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final double height;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.height = 60.0,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: AppColors.primary),
        ),
        centerTitle: true,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: actions,
        elevation: 0,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}
