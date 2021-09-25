import 'dart:io';

import 'package:flutter/material.dart';
import 'package:place_app/models/place.dart';
import 'package:provider/provider.dart';
import '../widgets/Image_input.dart';
import '../providers/great_places.dart';
import  '../widgets/location_input.dart';

class AddplaceScreen extends StatefulWidget {
  static const routename = '/add-place';
  @override
  _AddplaceScreenState createState() => _AddplaceScreenState();
}

class _AddplaceScreenState extends State<AddplaceScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;
  PlaceLoaction _pickedlocation;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }
 
  void _selectPlace(double lat,double lng){
        _pickedlocation = PlaceLoaction(latitude: lat,longitude: lng);
  }

  void _savePlace() {
    if (_titleController.text.isEmpty || _pickedImage == null || _pickedlocation == null) {
      return;
    }
    Provider.of<GreatPlaces>(context,listen: false)
        .addPlace(_titleController.text, _pickedImage,_pickedlocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: _titleController,
                    ),
                    SizedBox(height: 30),
                    ImageInput(_selectImage),
                    SizedBox(height: 10,),
                     LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            color: Theme.of(context).accentColor,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            elevation: 0,
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            onPressed:  _savePlace,
          )
        ],
      ),
    );
  }
}
