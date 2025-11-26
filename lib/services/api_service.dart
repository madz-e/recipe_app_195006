import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:recipe_app/models/recipe_model.dart';
import 'package:recipe_app/models/category_model.dart';



class ApiService {
  Future<List<RCategory>> loadRecipeCategoryList() async {
    final detailResponse = await http.get(
      Uri.parse('https://www.themealdb.com/api/json/v1/1/categories.php')
    );
    List<RCategory> categoryList=[];
      if (detailResponse.statusCode == 200) {
        final detailData = json.decode(detailResponse.body);
        List categoryJson =detailData['categories'];
        for(var c in categoryJson){
          categoryList.add(RCategory.fromJson(c));
        }
      }

    return categoryList;
  }

  Future<List<Recipe>> loadRecipeList(String category) async {

    final detailResponse = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/filter.php?c=$category')
    );
    List<Recipe> recipeList=[];
    if (detailResponse.statusCode == 200) {
      // print('VLAGA U API METOD');
      final detailData = json.decode(detailResponse.body);
      List recipeJson =detailData['meals'];
      for(var r in recipeJson){
        recipeList.add(Recipe.fromBasicJson(r));
      }
    } else {
      // (print ('EROR U API'));
    }

    return recipeList;
  }

  Future<Recipe?> searchRecipeByName(String name) async {
    try {
      final response = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/search.php?s=$name'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Recipe.fromJson(data);
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  Future<Recipe> loadRecipeDetails(id) async {
    print('vlaga u details');
    final detailResponse = await http.get(
        Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id')
    );

    if (detailResponse.statusCode == 200) {
      final data = json.decode(detailResponse.body);
      if (data['meals'] != null && data['meals'].isNotEmpty) {
        return Recipe.fromJson(data['meals'][0]);
      }
    } throw Exception("couldn't load recipe by id");
  }
}

