class Recipe {
  int id;
  String name;
  String img;
  String? instructions;
  String? youtube;
  Map<String, String>? ingredients;


  Recipe({
    required this.id,
    required this.name,
    required this.img,
    this.instructions,
    this.youtube,
    this.ingredients,


  });
  Recipe.fromBasicJson(Map<String, dynamic> data)
      : id = int.parse(data['idMeal']),
        name = data['strMeal'],
        img = data['strMealThumb'],
        instructions = null,
        youtube = null,
        ingredients = null;

  Recipe.fromJson(Map<String, dynamic> data)
      : id =  int.parse(data['idMeal']),
        name = data['strMeal'],
        img =data['strMealThumb']
  {
      instructions = data['strInstructions'];
      youtube = data['strYoutube'];
      ingredients = {};
    for (int i = 1; i <= 20; i++) {
      String ingredient = data['strIngredient$i'];
      String measure = data['strMeasure$i'];

      if (ingredient != null && ingredient.trim().isNotEmpty) {
        ingredients![ingredient] = measure ?? '';
      }
    }
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'img': img,
    'instructions': instructions,
    'youtube': youtube,
    'ingredients': ingredients,

  };
}
