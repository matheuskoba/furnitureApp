import 'package:flutter/material.dart';
import 'package:furniture/models/Categories.dart';
import 'package:furniture/screens/home/components/recommend_products.dart';
import 'package:furniture/services/fetchCategories.dart';
import 'package:furniture/services/fetchProducts.dart';

import '../../../components/title_text.dart';
import '../../../models/Product.dart';
import '../../../size_config.dart';
import 'categories.dart';

class Body extends StatelessWidget {
  const Body({super.key});
  @override
  Widget build(BuildContext context) {
    double defaultSize = SizeConfig.defaultSize;
    // It enables scrolling
    return SingleChildScrollView(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(defaultSize * 2),
              child: const TitleText(title: "Browse by categories",),
            ),
            FutureBuilder<Iterable>(
                future: fetchCategories(),
                builder: (context, snapshot)
                => snapshot.hasData ? Categories(categories: List<Category>.from(snapshot.data!)) : const Center(child: CircularProgressIndicator())
            ),
            const Divider(height: 5),
            Padding(
              padding: EdgeInsets.all(defaultSize * 2),
              child: const TitleText(title: "Recommends For You",),
            ),
            FutureBuilder<Iterable>(
                future: fetchProducts(),
                builder: (context, snapshot) {
                  return snapshot.hasData
                      ? RecommendProducts(
                      products: List<Product>.from(snapshot.data!))
                      : const Center(child: CircularProgressIndicator());
                }
            )
          ],
        ),
      ),
    );
  }
}
