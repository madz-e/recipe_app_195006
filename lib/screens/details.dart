import 'package:flutter/material.dart';

import '../models/recipe_model.dart';
import '../services/api_service.dart';


class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key,required this.recipe });
  final Recipe recipe;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  Recipe? _detailedRecipe;
  bool _isLoading = true;
  final ApiService _apiService = ApiService();

  @override
  void initState() {
    super.initState();
    _loadRecipeDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body:
      _isLoading
          ? const Center(child: CircularProgressIndicator())
      : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 16.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                ),
              ),
            ),
            Image.network(_detailedRecipe!.img),
            Divider(),
            Text(_detailedRecipe!.name, style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
            Divider(),
            Text('Ingredients:', style: TextStyle(fontSize: 20),textAlign: TextAlign.center,),
            Column(
              children: _detailedRecipe!.ingredients!.entries.map((r) {
                return Text('- ${r.value} ${r.key}');
              }).toList(),
            ),
            const Divider(),
            const Text('Instructions:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(_detailedRecipe!.instructions!),
            const Divider(),
            Text(
              'YouTube Link',
              style: TextStyle(
                fontSize: 18
              ),
            ),
            Text(_detailedRecipe!.youtube!),
          ],
        ),
      ),
    );
  }
  void _loadRecipeDetails() async {
    try{
      final detailedRecipe = await _apiService.loadRecipeDetails(widget.recipe.id);

      setState(() {
        _detailedRecipe = detailedRecipe;
        _isLoading = false;
      });
    }catch(e){
      setState(() {
        _isLoading = false;
      });
      print('Error loading recipe details: $e');
    }
  }
}
