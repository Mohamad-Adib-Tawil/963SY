import 'package:flutter/material.dart';
import 'package:untitled4/const.dart';

class ServiceItemModel {
  final String name;
  final String details;

  ServiceItemModel({required this.name, required this.details});
}

class GenericServiceListScreen extends StatelessWidget {
  final String title;
  final List<ServiceItemModel> items;

  const GenericServiceListScreen({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: true,
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
          elevation: 0,
        ),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return ListTile(
            title: Text(item.name,
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text(item.details),
          );
        },
      ),
    );
  }
}
