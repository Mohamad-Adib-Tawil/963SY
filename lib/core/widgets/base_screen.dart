import 'package:flutter/material.dart';
import 'package:untitled4/core/widgets/bottom_navigation.dart';

abstract class BaseScreen extends StatefulWidget {
  final int navigationIndex;

  const BaseScreen({
    super.key,
    required this.navigationIndex,
  });

  @override
  State<BaseScreen> createState();
}

abstract class BaseScreenState<T extends BaseScreen> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
      bottomNavigationBar: AppBottomNavigation(
        currentIndex: widget.navigationIndex,
      ),
    );
  }

  Widget buildBody(BuildContext context);
}
