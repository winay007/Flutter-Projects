import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/products_provider.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';
  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  @override
  final _pricefocus = FocusNode();
  final _descriptionfocus = FocusNode();
  final _imageUrlcontroller = TextEditingController();
  final _imageUrlfocus = FocusNode();
  final _form = GlobalKey<FormState>();
  var _editedProduct =
      Product(description: '', id: null, price: 0, title: '', imageUrl: '');
  var _isInit = true;
  var _initvalues = {
    'title': '',
    'description': '',
    'price': '',
    'imageUrl': '',
  };
  var isLoading = false;

  @override
  void initState() {
    _imageUrlfocus.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final productID = ModalRoute.of(context).settings.arguments as String;
      if (productID != null) {
        _editedProduct = Provider.of<ProductProvider>(context, listen: false)
            .findById(productID);
        _initvalues = {
          'title': _editedProduct.title,
          'description': _editedProduct.description,
          'price': _editedProduct.price.toString(),
          'imageUrl': '',
        };
        _imageUrlcontroller.text = _editedProduct.imageUrl;
      }
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  void _updateImageUrl() {
    if (!_imageUrlfocus.hasFocus) {
      setState(() {});
    }
  }

  Future<void> _saveform() async {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    setState(() {
      isLoading = true;
    });
    if (_editedProduct.id != null) {
     await Provider.of<ProductProvider>(context, listen: false)
          .updateProduct(_editedProduct.id, _editedProduct);
     
    } else {
      try{
          await Provider.of<ProductProvider>(context, listen: false)
          .addproduct(_editedProduct);
      }
      catch(error){
         await showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('An Error Occured !'),
                  content: Text('Something went wrong !'),
                  actions: [
                   FlatButton(child: Text('Okay'),onPressed: (){
                      Navigator.of(ctx).pop();
                   },)
                  ],
                ));
      } 
    }
     setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _imageUrlfocus.removeListener(_updateImageUrl);
    _pricefocus.dispose();
    _descriptionfocus.dispose();
    _imageUrlcontroller.dispose();
    _imageUrlfocus.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Product'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              _saveform();
            },
          )
        ],
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _initvalues['title'],
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_pricefocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter a value"; //error message
                        }
                        return null; //everthing's good
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          title: value,
                          imageUrl: _editedProduct.imageUrl,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initvalues['price'],
                      decoration: InputDecoration(labelText: 'Price'),
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.number,
                      focusNode: _pricefocus,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionfocus);
                      },
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter a price";
                        }
                        if (double.tryParse(value) == null) {
                          return "Please enter a valid number";
                        }
                        if (double.parse(value) <= 0) {
                          return "Please enter a price greater than 0";
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          description: _editedProduct.description,
                          price: double.parse(value),
                          title: _editedProduct.title,
                          imageUrl: _editedProduct.imageUrl,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    TextFormField(
                      initialValue: _initvalues['description'],
                      decoration: InputDecoration(labelText: 'Description'),
                      maxLines: 1,
                      keyboardType: TextInputType.multiline,
                      focusNode: _descriptionfocus,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Please enter a value";
                        }
                        if (value.length < 10) {
                          return "Description should have minimum 10 characters";
                        }
                        return null;
                      },
                      onFieldSubmitted: (_) {},
                      onSaved: (value) {
                        _editedProduct = Product(
                          description: value,
                          price: _editedProduct.price,
                          title: _editedProduct.title,
                          imageUrl: value,
                          id: _editedProduct.id,
                          isFavorite: _editedProduct.isFavorite,
                        );
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Container(
                          width: 100,
                          height: 100,
                          margin: EdgeInsets.only(top: 8, right: 10),
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey)),
                          child: _imageUrlcontroller.text.isEmpty
                              ? Text('Enter a URL')
                              : FittedBox(
                                  child: Image.network(
                                    _imageUrlcontroller.text,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(labelText: 'Image Url'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            controller: _imageUrlcontroller,
                            focusNode: _imageUrlfocus,
                            onEditingComplete: () {
                              setState(() {});
                            },
                            onFieldSubmitted: (_) {
                              _saveform();
                            },
                            validator: (value) {
                              if (value.isEmpty) {
                                return "Please enter image URL";
                              }
                              if (!value.startsWith('http') &&
                                  !value.startsWith('https')) {
                                return "Please enter a valid URL";
                              }

                              return null;
                            },
                            onSaved: (value) {
                              _editedProduct = Product(
                                description: _editedProduct.description,
                                price: _editedProduct.price,
                                title: _editedProduct.title,
                                imageUrl: value,
                                id: _editedProduct.id,
                                isFavorite: _editedProduct.isFavorite,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
