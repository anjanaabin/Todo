import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled18/3rd%20project.dart';

class todo3 extends StatefulWidget {
  final String todo;
  const todo3({Key? key,required this.todo}) : super(key: key);

  @override
  State<todo3> createState() => _todo3State();
}
class _todo3State extends State<todo3> {
TextEditingController tittlecontroller=TextEditingController();
TextEditingController Discriptioncontroller=TextEditingController();
TextEditingController Date=TextEditingController();
CollectionReference todo=FirebaseFirestore.instance.collection('todo');
String t='';
String D='';
String Da='';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    todo.doc(widget.todo).get().then((DocumentSnapshot document) {
      Map<String, dynamic>data = document.data()! as Map<String, dynamic>;
      tittlecontroller.text = data['todo tittle'];
      Discriptioncontroller.text = data['todo Discription'];
      Date.text = data['todo Date'];
    });
        }
        Future<void>editdata()async{
    await todo.doc(widget.todo).update({
      'todo tittle':tittlecontroller.text,
      'todo Discription':Discriptioncontroller.text,
      'todo Date':Date.text,
    });
        }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange,
        title: Text('Edit ToDos',style: TextStyle(fontSize: 25,color: Colors.black),),
    ),
    

    body: Center(
    child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
    Container(
    width: 150,
    ),
    TextField(
    controller: tittlecontroller,
    onChanged: (value){
    t=value;
    },
    decoration: InputDecoration(
    labelText: 'Tittle',
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(80)),
    ),
    ),
    Container(width: 150),
    TextField(
    controller:Discriptioncontroller,
    onChanged: (value) {
    D= value;
    },
    decoration: InputDecoration(
    labelText: 'Discription',
    border:
    OutlineInputBorder(borderRadius: BorderRadius.circular(80)),
    ),
    ),
    Container(
    padding: EdgeInsets.all(10),
    child: TextField(
    controller: Date,
    onChanged: (value){
    Da=value;
    },
    decoration: const InputDecoration(
    icon: Icon(Icons.calendar_today_rounded),
    labelText: 'date choose',
    ),
    ),
    ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 70,
          ),
          ElevatedButton(onPressed: (){
            editdata();
            Navigator.push(context, MaterialPageRoute (builder: (BuildContext context)=>todo2()));
          }, child: Icon(Icons.check,size: 30,color: Colors.black,)),
        ],
      ),
 ],
    ),
    ),

    );
  }
}
