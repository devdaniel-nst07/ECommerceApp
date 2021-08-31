import 'dart:io';

import 'package:ecommerce_app/consts/colors.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';

class UploadProductForm extends StatefulWidget {
  static const routeName = '/UploadProductForm';

  const UploadProductForm({Key? key}) : super(key: key);

  @override
  _UploadProductFormState createState() => _UploadProductFormState();
}

class _UploadProductFormState extends State<UploadProductForm> {
  //declare variable
  final _formKey = GlobalKey<FormState>();

  var _productTitle = '';
  var _productPrice = '';
  var _productCategory = '';
  var _productBrand = '';
  var _productDescription = '';
  var _productQuantity = '';
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _brandController = TextEditingController();

  String? _categoryValue;
  String? _brandValue;
  File? _pickedImage;

  //function show alert the dialog
  showAlertDialog(BuildContext context, String title, String body) {
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return AlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'))
            ],
          );
        });
  }

  void _trySubmit() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState!.save();
      print(_productTitle);
      print(_productPrice);
      print(_productCategory);
      print(_productBrand);
      print(_productDescription);
      print(_productQuantity);
    }
  }

  //function upload image
  void _pickedImageCamera() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.getImage(source: ImageSource.camera, imageQuality: 40);
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  void _pickedImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);

    setState(() {
      _pickedImage = pickedImageFile;
    });
  }

  void _removeImage() {
    setState(() {
      _pickedImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /******* Button Upload **************/
      bottomSheet: Container(
        height: kBottomNavigationBarHeight * 0.8,
        width: double.infinity,
        decoration: BoxDecoration(
            color: ColorsConsts.white,
            border: Border(top: BorderSide(color: Colors.grey, width: 0.5))),
        child: Material(
          color: Theme.of(context).backgroundColor,
          child: InkWell(
            onTap: _trySubmit,
            splashColor: Colors.grey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(right: 2),
                  child: Text(
                    'Upload',
                    style: TextStyle(fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
                GradientIcon(
                    Feather.upload,
                    20,
                    LinearGradient(colors: <Color>[
                      Colors.green,
                      Colors.yellow,
                      Colors.deepOrange,
                      Colors.orange,
                      Colors.yellow.shade800
                    ], begin: Alignment.topLeft, end: Alignment.bottomRight))
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Card(
                margin: EdgeInsets.all(15),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        /****** Region Title, Price **********/
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                                flex: 3,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 9),
                                  child: TextFormField(
                                    key: ValueKey('Title'),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'Please enter a Title';
                                      }
                                      return null;
                                    },
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: InputDecoration(
                                        labelText: 'Product Title'),
                                    onSaved: (value) {
                                      _productTitle = value!;
                                    },
                                  ),
                                )),
                            Flexible(
                                flex: 1,
                                child: TextFormField(
                                  key: ValueKey('Price'),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Price is missed';
                                    }
                                    return null;
                                  },
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp(r'[0-9]')),
                                  ],
                                  decoration: InputDecoration(
                                    labelText: 'Price \$',
                                  ),
                                  onSaved: (value) {
                                    _productPrice = value!;
                                  },
                                ))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        /********** Image picker here *****************/
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Expanded(
                                child: this._pickedImage == null
                                    ? Container(
                                        margin: EdgeInsets.all(10),
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                          border: Border.all(width: 1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          color:
                                              Theme.of(context).backgroundColor,
                                        ),
                                      )
                                    : Container(
                                        margin: EdgeInsets.all(10),
                                        height: 200,
                                        width: 200,
                                        child: Container(
                                          height: 200,
                                          decoration: BoxDecoration(
                                            color: Theme.of(context)
                                                .backgroundColor,
                                          ),
                                          child: Image.file(
                                            _pickedImage!,
                                            fit: BoxFit.contain,
                                            alignment: Alignment.center,
                                          ),
                                        ),
                                      )),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FittedBox(
                                  child: FlatButton.icon(
                                      textColor: Colors.white,
                                      onPressed: _pickedImageCamera,
                                      icon: Icon(
                                        Icons.camera,
                                        color: Colors.purpleAccent,
                                      ),
                                      label: Text(
                                        'Camera',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .textSelectionColor),
                                      )),
                                ),
                                FittedBox(
                                  child: FlatButton.icon(
                                      textColor: Colors.white,
                                      onPressed: _pickedImageGallery,
                                      icon: Icon(
                                        Icons.image,
                                        color: Colors.purpleAccent,
                                      ),
                                      label: Text(
                                        'Gallery',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Theme.of(context)
                                                .textSelectionColor),
                                      )),
                                ),
                                FittedBox(
                                  child: FlatButton.icon(
                                    textColor: Colors.white,
                                    onPressed: _removeImage,
                                    icon: Icon(
                                      Icons.remove_circle_rounded,
                                      color: Colors.red,
                                    ),
                                    label: Text(
                                      'Remove',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: Colors.redAccent,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        /*******Select category**********/
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(right: 9),
                              child: Container(
                                child: TextFormField(
                                  controller: _categoryController,
                                  key: ValueKey('Category'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Please enter a Category';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      labelText: 'Add a new Category'),
                                  onSaved: (value) {
                                    _productCategory = value!;
                                  },
                                ),
                              ),
                            )),
                            DropdownButton<String>(
                              items: [
                                DropdownMenuItem(
                                  child: Text('Phones'),
                                  value: 'Phones',
                                ),
                                DropdownMenuItem(
                                  child: Text('Clothes'),
                                  value: 'Clothes',
                                ),
                                DropdownMenuItem(
                                  child: Text('Beauty & healthy'),
                                  value: 'Beauty & healthy',
                                ),
                                DropdownMenuItem(
                                  child: Text('Shoes'),
                                  value: 'Shoes',
                                ),
                                DropdownMenuItem(
                                  child: Text('Furniture'),
                                  value: 'Furniture',
                                ),
                                DropdownMenuItem(
                                  child: Text('Watches'),
                                  value: 'Watches',
                                ),
                                DropdownMenuItem(
                                  child: Text('Laptops'),
                                  value: 'Laptops',
                                ),
                              ],
                              onChanged: (value) {
                                setState(() {
                                  _categoryValue = value;
                                  _categoryController.text = value!;
                                  //_controller.text= _productCategory;
                                  print(_productCategory);
                                });
                              },
                              hint: Text('Select a Category'),
                              value: _categoryValue,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        /****** Region brand ************/
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.only(right: 9),
                              child: Container(
                                child: TextFormField(
                                  controller: _brandController,
                                  key: ValueKey('Brand'),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Brand is missed';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Brand',
                                  ),
                                  onSaved: (value) {
                                    _productBrand = value!;
                                  },
                                ),
                              ),
                            )),
                            DropdownButton(
                              items: [
                                DropdownMenuItem<String>(
                                  child: Text('Addidas'),
                                  value: 'Addidas',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Apple'),
                                  value: 'Apple',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Dell'),
                                  value: 'Dell',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('H&M'),
                                  value: 'H&M',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Nike'),
                                  value: 'Nike',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Samsung'),
                                  value: 'Samsung',
                                ),
                                DropdownMenuItem<String>(
                                  child: Text('Huawei'),
                                  value: 'Huawei',
                                ),
                              ],
                              onChanged: (String? value) {
                                setState(() {
                                  _brandValue = value;
                                  _brandController.text = value!;
                                  print(_productBrand);
                                });
                              },
                              hint: Text('Select a Brand'),
                              value: _brandValue,
                            )
                          ],
                        ),
                        /******* Region Description ***********/
                        SizedBox(
                          height: 15,
                        ),
                        TextFormField(
                          key: ValueKey('Description'),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Product description is required';
                            }
                            return null;
                          },
                          maxLines: 10,
                          textCapitalization: TextCapitalization.sentences,
                          decoration: InputDecoration(
                            labelText: 'Description',
                            hintText: 'Product description',
                            border: OutlineInputBorder(),
                          ),
                          onSaved: (value) {
                            _productDescription = value!;
                          },
                          onChanged: (text) {},
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(right: 9),
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                key: ValueKey('Quantity'),
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'Quantity is missed';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                  labelText: 'Quantity',
                                ),
                                onSaved: (value) {
                                  _productQuantity = value!;
                                },
                              ),
                            ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50,)
          ],
        ),
      ),
    );
  }
}

class GradientIcon extends StatelessWidget {
  GradientIcon(this.icon, this.size, this.gradient);

  final IconData icon;
  final double size;
  final Gradient gradient;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
        child: SizedBox(
          width: size * 1.2,
          height: size * 1.2,
          child: Icon(
            icon,
            size: size,
            color: Colors.white,
          ),
        ),
        shaderCallback: (Rect bounds) {
          final Rect rect = Rect.fromLTRB(0, 0, size, size);
          return gradient.createShader(rect);
        });
  }
}