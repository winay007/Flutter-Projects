import 'package:flutter/material.dart';
import '/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routename = '/filter';

  final Function saveFilters;
  final Map<String,bool> currentFilter;
  FilterScreen(this.currentFilter,this.saveFilters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _lactoseFree = false;
  bool _isVegan = false;
  bool _isVegetarian = false;

  @override 
  initState(){
   _glutenFree=widget.currentFilter['gluten'];
   _lactoseFree=widget.currentFilter['lactose'];
   _isVegan=widget.currentFilter['vegan'];
   _isVegetarian=widget.currentFilter['vegetarian'];
   super.initState();
  }

  
  Widget _buildSwitchTile(
      String title, String description, bool current, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: current,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Filters'),
          actions: [
            IconButton(icon:Icon(Icons.save) ,onPressed: (){
              final selectedFilters ={
                  'lactose':_glutenFree,
                  'gluten' :_lactoseFree,
                  'vegan' :_isVegan,
                  'vegetarian':_isVegetarian,
                    };
              widget.saveFilters(selectedFilters);
              } , )
          ],
        ),
        drawer: MainDrawer(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                'Adjust your Meal Selection',
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                _buildSwitchTile(
                'Gluten-free',
                'only include Gluten free meals.',
                 _glutenFree, 
                  (newValue) {
                  setState(() {
                    _glutenFree = newValue;
                  });
                }),
                 _buildSwitchTile(
                'Lactose-free',
                'only include Lactose free meals.',
                 _lactoseFree, 
                  (newValue) {
                  setState(() {
                    _lactoseFree = newValue;
                  });
                }),
                _buildSwitchTile(
                'Vegetarian Food',
                'only include Vegeterian meals.',
                 _isVegetarian, 
                  (newValue) {
                  setState(() {
                    _isVegetarian = newValue;
                  });
                }),
                _buildSwitchTile(
                'Vegan Food',
                'only include Vegan meals.',
                 _isVegan, 
                  (newValue) {
                  setState(() {
                    _isVegan = newValue;
                  });
                }),
              ],
            ))
          ],
        ));
  }
}
