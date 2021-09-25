import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '/models/meal.dart';
class FavouriteScreen extends StatelessWidget {
  
final List<Meal> favoriteMeal;
FavouriteScreen(this.favoriteMeal); 
  @override
  Widget build(BuildContext context) {
    if(favoriteMeal.isEmpty){
         return Center(child : Text('No favouries added yet !'));
    }
    else{
      return ListView.builder(itemBuilder: (ctx,index){
           return MealItem(
           id:favoriteMeal[index].id,
           imageUrl: favoriteMeal[index].imageUrl,
           title:favoriteMeal[index].title ,
           duration: favoriteMeal[index].duration,
           affordability: favoriteMeal[index].affordability,
           complexity: favoriteMeal[index].complexity);
        },itemCount: favoriteMeal.length,);
    }
   
  }
}