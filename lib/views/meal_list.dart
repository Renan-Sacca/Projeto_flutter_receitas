import 'package:flutter/material.dart';
import 'package:meal_app/controllers/meal_controller.dart';
import 'package:meal_app/models/meal.dart';
import 'package:meal_app/views/meal_detail.dart';

class MealListScreen extends StatefulWidget {
  @override
  _MealListScreenState createState() => _MealListScreenState();
}

class _MealListScreenState extends State<MealListScreen> {
  MealController _mealController = MealController();
  List<Meal> _meals = [];
  bool _isLoading = false;
  String _searchQuery = "";

  @override
  void initState() {
    super.initState();
    _fetchMeals();
  }

  _fetchMeals([String query = ""]) async {
    setState(() {
      _isLoading = true;
    });
    try {
      List<Meal> meals = await _mealController.fetchMeals(query);
      setState(() {
        _meals = meals;
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
  }

  _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  _onSearchSubmitted() {
    _fetchMeals(_searchQuery);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meal List'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _onSearchChanged,
              onSubmitted: (value) => _onSearchSubmitted(),
              decoration: InputDecoration(
                labelText: 'Search for a meal',
                hintText: 'Enter meal name',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
              ),
            ),
          ),
          Expanded(
            child: _isLoading
                ? Center(child: CircularProgressIndicator())
                : _meals.isEmpty
                    ? Center(child: Text('No meals found!'))
                    : ListView.builder(
                        itemCount: _meals.length,
                        itemBuilder: (context, index) {
                          final meal = _meals[index];
                          return Card(
                            elevation: 5,
                            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            child: ListTile(
                              contentPadding: EdgeInsets.all(10),
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  meal.image,
                                  height: 80,
                                  width: 80,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              title: Text(meal.name, style: Theme.of(context).textTheme.titleLarge),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MealDetailScreen(meal: meal),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
