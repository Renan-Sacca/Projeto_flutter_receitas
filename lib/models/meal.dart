class Meal {
  final String id;
  final String name;
  final String image;
  final String instructions;
  final List<String> ingredients;
  final List<String> measures; // Adicionando as medidas/quantidades

  Meal({
    required this.id,
    required this.name,
    required this.image,
    required this.instructions,
    required this.ingredients,
    required this.measures, // Medidas adicionadas
  });

  factory Meal.fromJson(Map<String, dynamic> json) {
    List<String> ingredients = [];
    List<String> measures = [];

    // Pega os ingredientes e suas medidas correspondentes (strIngredient e strMeasure)
    for (int i = 1; i <= 20; i++) {
      final ingredient = json['strIngredient$i'];
      final measure = json['strMeasure$i'];
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add(ingredient);
        measures.add(measure ?? "");  // Adiciona a medida correspondente
      }
    }

    return Meal(
      id: json['idMeal'],
      name: json['strMeal'],
      image: json['strMealThumb'],
      instructions: json['strInstructions'],
      ingredients: ingredients,
      measures: measures,  // Armazena as medidas
    );
  }
}
