import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:untitled4/features/home/models/category_model.dart';
import 'package:untitled4/widgets/common/shimmer_effect/category_shimmer.dart';

class Category_Card extends StatelessWidget {
  final dynamic category; // Can be either CategoryModel or Map
  final VoidCallback onTap;

  const Category_Card({
    super.key,
    required this.category,
    required this.onTap,
  });

  String get _title {
    if (category is CategoryModel) {
      return category.catName;
    }
    return category['title'] ?? '';
  }

  String get _imagePath {
    if (category is CategoryModel) {
      return '${category.catPhoto}';
    }
    return category['imageName'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        height: 200,
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                Positioned.fill(
                  child: category is CategoryModel
                      ? CachedNetworkImage(
                          imageUrl:  _imagePath,
                          placeholder: (context, url) => const CategoryShimmer(),
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          _imagePath,
                          fit: BoxFit.cover,
                        ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    color: Colors.white.withOpacity(0.5),
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                    child: Text(
                      _title,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
