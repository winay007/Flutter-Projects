import 'package:flutter/material.dart';


import './dummy_data.dart';
import './models/meal.dart';
import '/screens/tab_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'screens/filters_screen.dart';
import 'screens/category_meals_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String , bool> _filters ={
    'lactose':false,
    'gluten' :false,
    'vegan' :false,
    'vegetarian':false,
  };
  
  List<Meal> _availabeMeal = DUMMY_MEALS;
  List<Meal> _fovoriteMeal =[];

  void _setFilters( Map<String , bool> filterdata){
   setState(() {
     _filters = filterdata;
    
     _availabeMeal =DUMMY_MEALS.where((meal) {
       if(_filters['lactose'] && !meal.isLactoseFree){
          return false;
       }
        if(_filters['gluten'] && !meal.isGlutenFree){
          return false;
       }
        if(_filters['vegan'] && !meal.isVegan){
          return false;
       }
        if(_filters['vegetarian'] && !meal.isVegetarian){
          return false;
       }
       return true;
     } ).toList();
   });
  }

  void _toggleFavorite(String mealID){
    final exsistingindex=
    _fovoriteMeal.lastIndexWhere((meal) => meal.id == mealID);
    if(exsistingindex >=0){
      setState(() {
         _fovoriteMeal.removeAt(exsistingindex);
      });
    }
    else{
      setState(() {
        _fovoriteMeal.add(DUMMY_MEALS.firstWhere((meal) => meal.id == mealID));
      });
    }
  }

  bool _isMealFavorite(String id){
    return _fovoriteMeal.any((meal) => meal.id == id );
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        accentColor: Colors.amber,
        canvasColor: Color.fromRGBO(255, 254, 251, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
          title: TextStyle(fontFamily: 'RobotoCondensed',fontSize:20,fontWeight: FontWeight.bold),
        ),
      ),
      initialRoute: '/',
      routes: { 
        '/' : (ctx) => TabsScreen(_fovoriteMeal),
        CategoryMealScreen.routename: (ctx) => CategoryMealScreen(_availabeMeal),
        MealDetailsScreen.routeName : (ctx) => MealDetailsScreen(_toggleFavorite,_isMealFavorite),
        FilterScreen.routename : (ctx) => FilterScreen(_filters,_setFilters), 
      },
      // onGenerateRoute: (settings){
      //   return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      // },
    );
  }
}

