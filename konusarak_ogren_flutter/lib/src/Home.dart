// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:konusarak_ogren_flutter/src/Detail.dart';
import 'package:konusarak_ogren_flutter/src/model/episodeModel.dart';
import 'package:konusarak_ogren_flutter/src/style/renkler.dart';
import 'package:http/http.dart' as http;
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Renkler renkler=Renkler();
  List<episodeModel> list =[];
  String url = "https://rickandmortyapi.com/api/episode?page=";
  bool isLoading = true;
  int page = 1;

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: _appBar(),
      backgroundColor: renkler.koyu,
      body: isLoading?_loading():ListView.builder(
             padding: const EdgeInsets.symmetric(horizontal: 20),
           itemCount: list.length,
          itemBuilder: (BuildContext context,int index){

           return GestureDetector(
             onTap: (){

               Navigator.push(context, MaterialPageRoute(builder: (context)=>Detail(list[index].charList)));
             },
             child: Container(
               margin: const EdgeInsets.only(bottom: 20),
               width: double.maxFinite,
               padding:const EdgeInsets.all(10),
               height: 100,
               decoration: BoxDecoration(
                 color: renkler.acik,
                 borderRadius: BorderRadius.circular(15),

               ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.center,
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   Text(list[index].id!.toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 10),textAlign: TextAlign.center,),
                   Text(list[index].name!,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),textAlign: TextAlign.center,),
                   Text(list[index].airDate!,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 10),textAlign: TextAlign.center,),
                   Text(list[index].episode!,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 10),textAlign: TextAlign.center,),
                 ],
               ),
             ),
           );
          }
      ),
      bottomNavigationBar: _bottom(),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: Text("EPISODE",style: TextStyle(color: renkler.acik,fontWeight: FontWeight.bold),),
    );
  }

  _bottom() {
    return Container(
      height: 50,
      width: double.maxFinite,
      child: Row(
        children: [
          Expanded(child: MaterialButton(
            height: 40,
            color: renkler.gecis,
            onPressed: (){
              if(page>=2){
                setState(() {
                  page--;
                  list.clear();
                  isLoading=true;
                });
                getData();
              }
            },
            child: Text("PREW",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500,),),
          )),
          Expanded(child: MaterialButton(
            height: 40,
            color: renkler.sari,
            onPressed: (){
              if(page<=2){
                setState(() {
                  page++;
                  list.clear();
                  isLoading=true;
                });
                getData();
              }

            },
            child: Text("NEXT",style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w500,),),
          )),
        ],
      ),
    );
  }

  void getData()async {
    var response = await http.get(Uri.parse(url+page.toString()));

    final jsondata=json.decode(response.body);

    for(var data in jsondata["results"]){
         episodeModel model = episodeModel
           (id: data["id"],
             name: data["name"],
             airDate: data["air_date"],
             episode: data["episode"],
             url: data["url"],
             created: data["created"],
            charList: data["characters"]
         );
         list.add(model);
          isLoading=false;
         setState(() {

         });

    }

  }
  Widget _loading() {
  return Center(
    child: CircularProgressIndicator(color: Colors.white,),
  );
  }
}


