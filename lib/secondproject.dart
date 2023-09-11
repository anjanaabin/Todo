import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:untitled18/3rd%20project.dart';

class hello extends StatefulWidget {
  const hello({Key? key}) : super(key: key);

  @override
  State<hello> createState() => _helloState();
}

class _helloState extends State<hello> {
  TextEditingController tittlecontroller=TextEditingController();
  TextEditingController Discriptioncontroller=TextEditingController();
  TextEditingController Date=TextEditingController();
  CollectionReference todo=FirebaseFirestore.instance.collection('todo');
  String t='';
  String D='';
  String Da='';
GlobalKey<FormState>fky=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width:double.infinity ,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                colors: [
                  Colors.orange,
                  Colors.orangeAccent,
                  Colors.orange,
                ]
              )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 35,
                  
                ),
                Padding(
                    padding: EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('ToDo',style:TextStyle(fontSize: 40),),
                      Text('all ToDos',style: TextStyle(fontSize: 20),)
                    ],
                  ),

                ),


                Expanded(child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topLeft:Radius.circular(40),topRight: Radius.circular(40))
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Center(
                          child: Form(
                            key: fky,
                            child: Column(mainAxisAlignment: MainAxisAlignment.center,),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Container(
                          padding: EdgeInsets.all(35),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            boxShadow: [BoxShadow(
                              color: Color.fromRGBO(220, 95, 27, 3),
                              blurRadius: 25,
                              offset: Offset(0,10)
                            )]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                  border: Border(bottom: BorderSide(color: Colors.grey))
                                ),
                                child: TextFormField(
                                  controller: tittlecontroller,
                                  onChanged: (value){
                                    t=value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Tittle',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,

                                  ),
                                  validator: (value){
                                    if(value !.isEmpty){
                                      return 'Fill in the blank';
                                    }else{
                                      return null;
                                    }
                                  },

                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey))
                                ),
                                child: TextFormField(
                                  controller: Discriptioncontroller,
                                  onChanged: (value){
                                    D=value;
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Discription',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,

                                  ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'Fill in the blank';
                                    }else{
                                      return null;
                                    }
                                  },

                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border(bottom: BorderSide(color: Colors.grey))
                                ),
                                child: TextFormField(
                                  controller: Date,
                                  onChanged: (value){
                                    Da=value;
                                  },
                                  decoration: InputDecoration(
                                    icon: Icon(Icons.calendar_today_rounded),
                                    hintText: 'Datechoose',
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,

                                  ),
                                  validator: (value){
                                    if(value!.isEmpty){
                                      return 'Fill in the blank';
                                    }else{
                                      return null;
                                    }
                                  },
                                  onTap: ()async{
                                    var date=await showDatePicker(
                                        context: context,
                                        initialDate:  DateTime.now(),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2100));
                                    if (date !=null){
                                      setState(() {
                                        Date.text=DateFormat('MM/dd/yyy').format(date);
                                        Da=DateFormat('MM/dd/yyy').format(date);
                                      });
                                    }
                                  },

                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ElevatedButton(onPressed: ()async{
                                    if(fky.currentState!.validate()){
                                      await todo.add({
                                        'todo tittle':t,
                                        'todo Discription':D,
                                        'todo Date':Da,
                                      }).then((value) => Fluttertoast.showToast(
                                          msg: "added",
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.black,
                                      ));
                                    }
                                  }, child:Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.add),
                                  )),
                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [

                                  ElevatedButton(onPressed: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context)=>todo2()));
                                    }, child:Icon(Icons.navigate_next)),

                                ],
                              )


                            ],
                          ),
                        ),
                      ],
                    ),

                    ),
                  ),


                ),



              ],
            ),
          ),






    );
  }
}
