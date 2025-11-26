import 'package:flutter/material.dart';

import '../models/category_model.dart';
import '../screens/recipes.dart';

class CategoryCard extends StatelessWidget {
  final RCategory category;

  const CategoryCard({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
          builder: (context) => RecipesPage(title: category.name, category: category),
        ),);
      },
      child: Card(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: Colors.pink.shade300, width: 3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(child: Image.network(category.img)),
              Divider(),
              Text(category.name, style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
              Text(
                category.description.length > 70
                    ? "${category.description.substring(0, 70)}..."
                    : category.description,
                style: const TextStyle(fontSize: 12),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
