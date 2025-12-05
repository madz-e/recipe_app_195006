import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/category_model.dart';
import '../services/api_service.dart';
import '../widgets/category_grid.dart';
import 'details.dart';
import 'favorites.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  late final List<RCategory> _categories;
  List<RCategory> _filteredCategories = [];
  bool _isLoading = true;
  String _searchQuery = '';
  final ApiService _apiService = ApiService();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadCategoryList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
          icon: const Icon(FontAwesomeIcons.clover, color: Colors.white,size: 35),
          tooltip: 'Go to a random recipe!',
          onPressed: () async {
            try{
              final randomRecipe = await _apiService.loadRecipeDetails("random");
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(recipe: randomRecipe),
                  ));
            }catch(error){
              print("error loading random recipe cause: $error");
            }
          },
        ),
          IconButton(
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FavoritesPage(),
                    ));
              },
              icon: const Icon(Icons.favorite,color: Colors.white))

        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search Category by name...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: _filterCategories,
            ),
          ),
          Expanded(
            child: _filteredCategories.isEmpty && _searchQuery.isNotEmpty
                ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text(
                    'No Categories found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
                : Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: CategoryGrid(categories: _filteredCategories),
            ),
          ),
        ],
      ),
    );
  }


  void _loadCategoryList() async {
    try {
      final categoryList = await _apiService.loadRecipeCategoryList();

      setState(() {
        _categories = categoryList;
        _filteredCategories = categoryList;
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print('Error loading categories: $error');
    }


  }

  void _filterCategories(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCategories = _categories;
      } else {
        _filteredCategories = _categories
            .where((category) =>
            category.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

}