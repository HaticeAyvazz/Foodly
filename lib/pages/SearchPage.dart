import 'package:flutter/material.dart';
import 'package:foodly/cards/PopulerMeals.dart';
import 'package:foodly/pages/ContentPage.dart';
import 'package:foodly/pages/FavoriteListPage.dart';
import 'package:foodly/services/api_service.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key, required ApiService apiService})
    : _apiService = apiService;

  final ApiService _apiService;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchMealName = TextEditingController();

  int _choosedPageIndex = 0;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [_buildSearchBody(), FavoriteListPage()];
  }

  void _pageChange(int newIndex) {
    setState(() {
      _choosedPageIndex = newIndex;
    });
  }

  @override
  void dispose() {
    searchMealName.dispose();
    super.dispose();
  }

  Widget _buildSearchBody() {
    return SizedBox.expand(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            TextField(
              controller: searchMealName,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.blueGrey.shade600,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(15),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.orange.shade800),
                ),
                suffixIcon: IconButton(
                  onPressed: () async {
                    final query = searchMealName.text.trim();
                    if (query.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please enter a dish name")),
                      );
                      return;
                    }
                    try {
                      final mealData = await widget._apiService.fetchMeal(
                        query,
                      );
                      if (mealData != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ContentPage(meal: mealData),
                          ),
                        );
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Food not found")),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Meal information could not be obtained",
                          ),
                        ),
                      );
                    }
                  },
                  icon: Icon(Icons.search, color: Colors.grey.shade700),
                ),
                hintText: "Enter Meal Name",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 30),
            PopulerMeals(),

            SizedBox(height: 20),
            Text(
              "The top 10 most popular dishes in Türkiye",
              style: TextStyle(color: Colors.orange, fontSize: 18),
            ),
            SizedBox(
              height: 300,
              child: ListView(
                children: [
                  ListTile(title: Text("Kebap")),
                  ListTile(title: Text("Mantı")),
                  ListTile(title: Text("Lahmacun")),
                  ListTile(title: Text("Baklava")),
                  ListTile(title: Text("Köfte")),
                  ListTile(title: Text("Yaprak Sarma")),
                  ListTile(title: Text("Lokum")),
                  ListTile(title: Text("Pide")),
                  ListTile(title: Text("Künefe")),
                  ListTile(title: Text("Balık Ekmek")),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _choosedPageIndex,
        children: [_buildSearchBody(), FavoriteListPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 50,
        backgroundColor: Colors.orange.shade100,
        unselectedItemColor: Colors.grey.shade200,
        currentIndex: _choosedPageIndex,
        onTap: _pageChange,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.blueGrey.shade400, size: 35),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite_border,
              color: Colors.blueGrey.shade400,
              size: 35,
            ),
            label: "Favorite",
          ),
        ],
      ),
    );
  }
}
