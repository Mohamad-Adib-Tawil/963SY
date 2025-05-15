import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool automaticallyImplyLeading;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.automaticallyImplyLeading = true,
    this.height = 60.0,
    this.backgroundColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(height),
      child: AppBar(
        automaticallyImplyLeading: automaticallyImplyLeading,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            color: backgroundColor ?? AppColors.primary,
          ),
        ),
        centerTitle: true,
        title: Text(
          title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: textColor ?? Colors.white,
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
