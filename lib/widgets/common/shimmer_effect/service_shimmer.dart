import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled4/core/constants/app_colors.dart';
import 'package:untitled4/core/widgets/rtl_text.dart';

class ServiceShimmer extends StatelessWidget {
  const ServiceShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: 4,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                width: 130,
                height: 90,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              title: RTLText(
                text: 'Item ${index + 1}',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4),
                child: RTLText(
                  text: 'Item ${index + 1} description',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
