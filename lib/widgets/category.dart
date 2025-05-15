import 'package:flutter/material.dart';
import 'package:untitled4/features/home/models/category_model.dart';

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
      return 'http://127.0.0.1:8000${category.catPhoto}';
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
                      ? Image.network(
                          _imagePath,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey[300],
                              child: const Icon(Icons.error),
                            );
                          },
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
