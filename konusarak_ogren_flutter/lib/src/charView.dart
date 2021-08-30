import 'package:flutter/material.dart';
import 'package:konusarak_ogren_flutter/src/style/renkler.dart';

class CharView extends StatefulWidget {
  String id,name,status,species,type,gender,image,url,created;
  CharView({required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.url,
    required this.created});
  @override
  _CharViewState createState() => _CharViewState(id:id,name: name,status: status,species: species,type: type,gender: gender,image: image,url: url,created: created);
}

class _CharViewState extends State<CharView> {
  String id,name,status,species,type,gender,image,url,created;
  _CharViewState({required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.url,
    required this.created});
  Renkler renkler = Renkler();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: renkler.koyu,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(image,width: double.maxFinite,height: MediaQuery.of(context).size.height*0.50,fit: BoxFit.cover,),
          SizedBox(height: 20,),
         Padding(
           padding: const EdgeInsets.all(10),
           child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
             crossAxisAlignment: CrossAxisAlignment.start,
             children: [
               Text("Name: $name",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),textAlign: TextAlign.center,),
               SizedBox(height: 20,),
               Text("ID: $id",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 13),),
               Text("Status: $status",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 13),),
               Text("Species: $species",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 13),),
               Text("Type: $type",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 13),),
               Text("Gender: $gender",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 13),),
               Text("Created: $created",style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w300,fontSize: 13),),

             ],
           ),
         ),

    ],
      ),
    );
  }
}
