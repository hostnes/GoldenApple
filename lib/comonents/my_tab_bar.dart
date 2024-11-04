import 'package:flutter/material.dart';

class MyTabBar extends StatelessWidget {
  final TabController tabController;
  final List<String> categories;

  const MyTabBar({
    super.key,
    required this.tabController,
    required this.categories,
  });

  List<Tab> _buildCategoryTabs() {
    return categories.map((category) {
      return Tab(text: category);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TabBar(
        controller: tabController,
        tabs: _buildCategoryTabs(),
        isScrollable: true, // Добавлено для прокручивания, если категорий много
      ),
    );
  }
}
