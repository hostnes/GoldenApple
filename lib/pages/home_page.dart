import 'package:flutter/material.dart';
import '../comonents/my_description_box.dart';
import '../comonents/my_drawer.dart';
import '../comonents/my_sliver_app_bar.dart';
import '../comonents/my_tab_bar.dart';
import 'item_detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final List<Map<String, dynamic>> fullMenu = [
    {
      'name': "Туши",
      "items": [
        {
          'title': "Тушь гель",
          "description": "Описание продукта",
          "photo":
              "https://basket-12.wbbasket.ru/vol1802/part180270/180270289/images/c246x328/1.webp",
          "cost": 200
        }
      ],
    },
    {
      'name': "Помады",
      "items": [
        {
          'title': "Губная помада",
          "description": "Описание продукта",
          "photo":
              "https://basket-01.wbbasket.ru/vol87/part8769/8769440/images/c246x328/1.webp",
          "cost": 300
        },
        {
          'title': "Губная помада",
          "description": "Описание продукта",
          "photo":
              "https://basket-01.wbbasket.ru/vol87/part8769/8769440/images/c246x328/1.webp",
          "cost": 300
        }
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: fullMenu.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  final List<String> acts = [
    "https://basket-12.wbbasket.ru/vol1802/part180270/180270289/images/c246x328/1.webp"
  ];
  List<Widget> getCosmeticItemsInCategory() {
    return fullMenu.map((category) {
      return ListView.builder(
        itemCount: category['items'].length,
        itemBuilder: (context, index) {
          final item = category['items'][index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ItemDetailPage(
                    title: item['title'],
                    description: item['description'],
                    photo: item['photo'],
                    cost: item['cost'],
                  ),
                ),
              );
            },
            child: Card(
              child: ListTile(
                leading: Image.network(
                  item['photo'],
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
                title: Text(item['title']),
                subtitle: Text(item['description']),
                trailing: Text('${item['cost']} руб.'),
              ),
            ),
          );
        },
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          MySliverAppBar(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Акции"),
                MyDescriptionBox(photo: acts[0]),
              ],
            ),
            title: MyTabBar(
              tabController: _tabController,
              categories: fullMenu
                  .map((category) => category['name'] as String)
                  .toList(),
            ),
          ),
        ],
        body: TabBarView(
          controller: _tabController,
          children: getCosmeticItemsInCategory(),
        ),
      ),
    );
  }
}
