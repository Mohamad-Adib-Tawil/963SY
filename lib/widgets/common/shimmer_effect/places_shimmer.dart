import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class PlacesShimmer extends StatelessWidget {
  const PlacesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        children: [
          ListView.builder(
            padding: const EdgeInsets.all(16),
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Container(
                height: 200,
                width: double.infinity,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
