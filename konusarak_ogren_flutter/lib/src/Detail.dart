import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:konusarak_ogren_flutter/src/charView.dart';
import 'package:konusarak_ogren_flutter/src/model/charModel.dart';
import 'package:konusarak_ogren_flutter/src/style/renkler.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {
  List<dynamic>? urlList;
  Detail(this.urlList);
  @override
  _DetailState createState() => _DetailState(urlList);
}

class _DetailState extends State<Detail> {
  List<dynamic>? urlList;
  _DetailState(this.urlList);
  Renkler renkler=Renkler();
  List<charModel> list =[];
  bool isLoading = true;

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: renkler.koyu,
      appBar: _appBar(),
      body: isLoading? _loading(): ListView.builder(
          itemCount: list.length,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemBuilder: (BuildContext context, index){
            var data = list[index];
        return GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CharView(id:"${data.id}",name:"${data.name}",status: "${data.status}",species: "${data.species}",type: "${data.type}",gender:"${data.gender}",image: "${data.image}",url:"${data.url}",created:"${data.created}",)));
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ClipRRect(
                  child: Image.network("${data.image}"),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(data.id!.toString(),style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 10),textAlign: TextAlign.center,),
                    SizedBox(
                        width: MediaQuery.of(context).size.width*0.50,
                        child: Text(data.name!,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 13),textAlign: TextAlign.center,)),
                    ],
                ),
              ],
            ),
          ),
        );
      }),
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

  void getData()async{
    for(var i =0; i<urlList!.length; i++){
      var response = await http.get(Uri.parse(urlList![i]));
      final jsondata=json.decode(response.body);
      charModel model = charModel(
          id: jsondata["id"],
          name: jsondata["name"],
          status: jsondata["status"],
          species: jsondata["species"],
          type: jsondata["type"],
          gender: jsondata["gender"],
          image: jsondata["image"],
          url: jsondata["url"],
          created: jsondata["created"]
      );
      list.add(model);
      setState(() {
        isLoading=false;
      });
    }


  }
  Widget _loading() {
    return Center(
      child: CircularProgressIndicator(color: Colors.white,),
    );
  }
}
