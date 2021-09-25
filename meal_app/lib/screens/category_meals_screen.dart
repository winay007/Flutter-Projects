import 'package:flutter/material.dart';
import 'package:meal_app/widgets/meal_item.dart';
import '../dummy_data.dart';
import '../models/meal.dart';

class CategoryMealScreen extends StatefulWidget {
  static const routename = '/category_meal';
  final List<Meal> availableMeal;

  CategoryMealScreen(this.availableMeal);
  @override
  _CategoryMealScreenState createState() => _CategoryMealScreenState();
}

class _CategoryMealScreenState extends State<CategoryMealScreen> {
  String categoryTitle;
  List<Meal> displayedMeals;
  var _loadInitData =false;

  @override
  void initState() {
    
    // TODO: implement initState
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if(!_loadInitData){
      final routeargs= ModalRoute.of(context).settings.arguments as Map<String,String>;
      categoryTitle =routeargs['title'];
     final categoryId = routeargs['id'];
      displayedMeals =widget.availableMeal.where((meal) {
        return meal.categories.contains(categoryId);
     }).toList();
     _loadInitData=true;

    }
    
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
   
  void _removeMeal(String mealID){
    setState(() {
      displayedMeals.removeWhere((meal) => meal.id==mealID);
    });
  }
  
  @override
  Widget build(BuildContext context) {
     
     
    return Scaffold(
       appBar: AppBar(title: Text(categoryTitle)) ,
        body: ListView.builder(itemBuilder: (ctx,index){
           return MealItem(
           id:displayedMeals[index].id,
           imageUrl: displayedMeals[index].imageUrl,
           title:displayedMeals[index].title ,
           duration: displayedMeals[index].duration,
           affordability: displayedMeals[index].affordability,
           complexity: displayedMeals[index].complexity,
         );
        },itemCount: displayedMeals.length,)
        );
  }
}
