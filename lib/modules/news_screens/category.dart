import 'package:flutter/material.dart';
import '../../layout/cubit/news_cubit.dart';
import 'category_news_list_screen.dart';

class Category extends StatelessWidget {
  const Category({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Center(
        child: Column(
          children: const [
            CategoryItem(category: "Entertainment"),
            CategoryItem(category: "Technology"),
            CategoryItem(category: "Business"),
            CategoryItem(category: "Science"),
            CategoryItem(category: "Health"),
            CategoryItem(category: "Sport"),
          ],
        ),
      ),
    );
  }
}

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    Key? key,
    required this.category,
  }) : super(key: key);
  final String category;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(100),
      ),
      child: TextButton(
        onPressed: () {
          NewsCubit.get(context).getNews(category: category);
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewsListScreen(category: category)),
          );
        },
        child: Text(
          category,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    );
  }
}
