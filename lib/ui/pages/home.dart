import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:project1_iremember/resources/constants.dart';
import '../../resources/db_provider.dart';
import '../../models/item_model.dart';
import 'detail.dart';


class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List items = [];

  void initState() {
    super.initState();
  }

  Future<List> getItems() async {
    return DbProvider().fetchItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //TODO 2 build app bar
      appBar: AppBar(
        title: Text("Flutter College Marathon 2020"),
        backgroundColor: Colors.red,
        ),
        
      body: FutureBuilder(
        future: getItems(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
          if(snapshot.hasError) return Center(child: Text("There was an error ${snapshot.error}" ),);
          List items = snapshot.data;
          if(items.isEmpty) items = [{
            columnId: 1,
            columnImage: "img/36411.jpg",
            columnTitle: "Test item",
            columnDescription: "Test description is this. Thank you",
          }];
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index)
             {
              ItemModel item = ItemModel.fromMap(items
              [index]);
              //TODO 2.1 build ListTile with title and description
              //TODO 2.2 Add circle avatar to show the image
              //TODO 2.3 onTap navigate to details page
              //TODO 2.4 add delete IconButton
              //TODO 2.5 call delete function on press delete button
              return ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context)=>DetailPage(item: item)
                  ));
                  
                },
                leading:CircleAvatar(
                //backgroundImage: AssetImage(item.image),
                ),
                title:Text(item.title),
                subtitle: Text(item.description),
              );
            },
          );
        },
      ),

      //TODO 2.6 Add floating action button
      floatingActionButton: FloatingActionButton(
        child:Icon(Icons.add),
        backgroundColor: Colors.indigo,
        onPressed: (){
          print("Hello Pressed");
          Navigator.pushNamed(context,'add');
        },
      ),
      //TODO 2.7 onPressed navigate to AddItem page
      backgroundColor: Colors.green[200],
    );
  }

  // void _delete(ItemModel item) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text("Delete item"),
  //         content: Text("Are you sure you want to delete Item?"),
  //         actions: <Widget>[
  //           FlatButton(
  //             child: Text("Cancel"),
  //             onPressed: ()=>Navigator.pop(context),
  //           ),
  //           FlatButton(
  //             child: Text("Delete"),
  //             onPressed: (){
  //               removeItem(item);
  //               Navigator.pushReplacement(context, MaterialPageRoute(
  //                 builder: (_) => HomePage()
  //               ));
                
  //             }
  //           )
  //         ],
  //       );
  //     }
  //   );
  // }

  void removeItem(ItemModel item) {
    setState(() { 
      DbProvider().deleteItem(item.id);
    });
  }

}
