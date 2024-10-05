import 'package:flutter/material.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/views/meal_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavoriteMealsScreen extends StatefulWidget {
  @override
  _FavoriteMealsScreenState createState() => _FavoriteMealsScreenState();
}

class _FavoriteMealsScreenState extends State<FavoriteMealsScreen> {
  List<Meal> _favoriteMeals = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  // Carrega os favoritos sempre que as dependências mudam, incluindo quando a tela volta do detalhe
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadFavorites();  // Recarrega os favoritos quando a tela de favoritos é reexibida
  }

  Future<void> _loadFavorites() async {
    setState(() {
      _isLoading = true;  // Mostra o loader enquanto carrega os favoritos
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favoriteIds = prefs.getStringList('favorites');

    if (favoriteIds != null && favoriteIds.isNotEmpty) {
      List<Meal> meals = [];

      // Faz requisição à API para cada ID salvo
      for (String id in favoriteIds) {
        Meal? meal = await _fetchMealById(id);
        if (meal != null) {
          meals.add(meal);
        }
      }

      setState(() {
        _favoriteMeals = meals;
        _isLoading = false;
      });
    } else {
      setState(() {
        _favoriteMeals = [];
        _isLoading = false;
      });
    }
  }

  Future<Meal?> _fetchMealById(String id) async {
    final response = await http.get(Uri.parse('https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] != null && data['meals'].isNotEmpty) {
        return Meal.fromJson(data['meals'][0]);
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Meals'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _favoriteMeals.isEmpty
              ? Center(child: Text('No favorites yet!'))
              : ListView.builder(
                  itemCount: _favoriteMeals.length,
                  itemBuilder: (context, index) {
                    final meal = _favoriteMeals[index];
                    return Card(
                      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: EdgeInsets.all(16),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            meal.image,
                            height: 80,
                            width: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        title: Text(
                          meal.name,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, size: 18),
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MealDetailScreen(meal: meal),
                            ),
                          );

                          // Após voltar da tela de detalhes, atualiza os favoritos
                          _loadFavorites();
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
