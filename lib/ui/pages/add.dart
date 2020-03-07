import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../resources/db_provider.dart';
import '../../models/item_model.dart';

class AddPage extends StatefulWidget {
  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  String title;
  String description;
  File _image;
  _showOptionsDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
              child: Container(
                height: 190,
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.blueGrey,
                      child: ListTile(
                        title: Text("Get Picture"),
                      ),
                    ),
                    ListTile(
                      leading: Icon(Icons.photo),
                      title: Text("Select from Gallery"),
                      onTap: () {
                        _getImage(ImageSource.gallery);
                        Navigator.pop(context);
                      },
                    ),
                    Divider(),
                    ListTile(
                        leading: Icon(Icons.camera_alt),
                        title: Text("Take a picture"),
                        onTap: () {
                          _getImage(ImageSource.camera);
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
              backgroundColor: Colors.green[200]);
        });
  }

  Future _getImage(ImageSource source) async {
    var image = await ImagePicker.pickImage(source: source);
    if (image!=null){
      setState((){
        _image=image;
      });
    }
    //TODO 3.2 get image from camera or gallery
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Add item"),
       backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[
          SizedBox(height: 30.0,),
          _buildTitleField(),
        //  Text(title ?? ""),
          SizedBox(
            height: 20,
          ),
          _buildDescriptionField(),
          SizedBox(
            height: 20,
          ),

          _buildImgSelectButton(),
          SizedBox(
            height: 10,
          ),
          _buildImageField(),
          SizedBox(
            height: 20,
          ),
          _buildSaveButton(context)
        ],
      ),
    );
  }

  Widget _buildTitleField() {
    //TODO 3 build title text field
    return TextField(
      onChanged: (val){
        setState(() {
          title = val;
        });
      },
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "title"
        ),
    );
  }

  TextField _buildDescriptionField() {
    return TextField(
          onChanged: (value) {
            setState(() {
              description = value;
            });
          },
          maxLines: 4,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: "Description",
          ),
        );
  }

  Widget _buildImgSelectButton() {
    //TODO 3.1 build AddImage button
    return RaisedButton(
      textColor: Colors.white,
      child: Text("Pick Image"),
      onPressed: (){},
    );
  }

  SizedBox _buildImageField() {
    return SizedBox(
          child: _image == null
              ? Container()
              : Image.file(
                  _image,
                  height: 200,
                ),
        );
  }

  SizedBox _buildSaveButton(BuildContext context) {
    return SizedBox(
          height: 50,
          width: 20.0,
          child: RaisedButton.icon(
            icon: Icon(Icons.save),
            label: Text("Save"),
            color: Colors.blue,
            onPressed: () async {
              if (title == null || description == null || _image == null) {
                return;
              }
              ItemModel item =ItemModel(title: title,description: description,image: _image.path);
              await DbProvider().addItem(item);
              Navigator.pop(context);
            },
          ),
        );
  }
}
