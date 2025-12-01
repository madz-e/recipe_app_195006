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
      backgroundColor: Colors.pink.shade100,
      body:
      _isLoading
          ? const Center(child: CircularProgressIndicator())
      : SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 50.0, left: 16.0),
              child: Row(children: [
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                ),
                Expanded(child: Text(
                  'Random Recipe',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.center,
                ))
              ],)
            ),
            Image.network(_detailedRecipe!.img),
            Divider(),
            SizedBox(height: 10),
            Text(_detailedRecipe!.name, style: TextStyle(fontSize: 22),textAlign: TextAlign.center,),
            SizedBox(height: 10),
            Divider(),
            Text('Ingredients:', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
            Column(
              children: _detailedRecipe!.ingredients!.entries.map((r) {
                return Padding(padding: const EdgeInsets.symmetric(horizontal: 20),
                child:  Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '- ${r.value} ${r.key}',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                );
              }).toList(),
            ),
            const Divider(),
            Text('Instructions:', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),textAlign: TextAlign.justify,),
            Padding(padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child:
                Text(_detailedRecipe!.instructions!,style: TextStyle(fontSize: 20),textAlign: TextAlign.justify),
                ),
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
