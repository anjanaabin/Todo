import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled18/4th%20page.dart';
import 'package:untitled18/secondproject.dart';

class todo2 extends StatefulWidget {
  const todo2({Key? key}) : super(key: key);

  @override
  State<todo2> createState() => _todo2State();

  static add(Map<String, String> map) {}
}

class _todo2State extends State<todo2> {
  CollectionReference todo = FirebaseFirestore.instance.collection('todo');
  final Stream<QuerySnapshot> todo2 = FirebaseFirestore.instance.collection('todo').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(
          'All ToDos',
          style: TextStyle(fontSize: 25),
        ),

        backgroundColor: Colors.orange,
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: todo2,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('todo');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text('waiting'),
            );
          }
          return Container(color: Colors.white,
            child: ListView(
                children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data()! as Map<String, dynamic>;

              return Card(

                child: ListTile(
                  onTap: (){},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  tileColor: Colors.white,

                  // leading: Text(""),
                  title:Text("${data['todo Date']}"),
                  subtitle: Column(mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:[

                      Text("${data['todo Discription']}"),
                      Text("${data['todo tittle']}"),




                    ],

                  ),

                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(child: Icon(Icons.delete,color: Colors.black,),onTap: ()async{
                        await todo.doc(document.id).delete();},),
                      InkWell(child: Icon(Icons.edit),onTap: (){
                        Navigator .push(context, MaterialPageRoute(builder: (BuildContext context)=>todo3(todo:document.id)));
                      },)

                    ],
                  ),










              ),












                );


            }).toList()),
          );
        },
      ),
    );
  }
}
