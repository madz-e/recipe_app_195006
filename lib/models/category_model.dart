class RCategory {
  int id;
  String name;
  String img;
  String description;

  RCategory({
    required this.id,
    required this.name,
    required this.img,
    required this.description,
  });

  RCategory.fromJson(Map<String, dynamic> data)
      : id =  int.parse(data['idCategory']),
        name = data['strCategory'],
        img = data['strCategoryThumb'],
        description = data['strCategoryDescription'];

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'img': img,
    'description': description,
  };
}
