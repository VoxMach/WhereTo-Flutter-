import 'dart:convert';

import 'package:WhereTo/Rider_ViewMenuTransac/menudesign.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/rider_classMenu.dart';
import 'package:WhereTo/api/api.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MShowStep extends StatefulWidget {

  final String id;

  const MShowStep({Key key, this.id}) : super(key: key);


  @override
  _MShowStepState createState() => _MShowStepState();
}

    



class _MShowStepState extends State<MShowStep> {

  var idgetter;
  var playerID;
  var riderID;
  @override
  void initState() {
    this.getMenuTransaction();
    super.initState();
    sendNotif();
    
  }
  sendNotif() async {
    SharedPreferences local = await SharedPreferences.getInstance();
    idgetter = local.getString("menuplustrans");
    playerID = local.getString("playerIDS");
    var userJson = local.getString('user'); 
      var user = json.decode(userJson);
      setState(() {
        riderID = user;
      });
                  // print(idgetter+"-"+playerID);
     String url = 'https://onesignal.com/api/v1/notifications';
        var contents = {
          "include_player_ids": ['$playerID'],
          "include_segments": ["Users Notif"],
          "excluded_segments": [],
          "large_icon": "https://res.cloudinary.com/amadpogi/image/upload/v1600008167/logo_nh4bpx.png",
          "big_picture":"https://res.cloudinary.com/amadpogi/image/upload/v1599185567/banner-01_sxhg1m.png",
          "contents": {"en": "Your Order is Accepted and Ongoing to Buy The Menu."},

          "data": {
            "id": "${riderID['id']}",
            "transact_id":"$idgetter",
            "status":"2"
          },
          "headings": {"en": "WhereTo Rider"},
          "filter": [
            {"field": "tag", "key": "UR", "relation": "=", "value": "TRUE"},
          ],
          "app_id": "f5091806-1654-435d-8799-0cbd5fc49280"
        };
        Map<String, String> headers = {
          'Content-Type': 'application/json',
          'authorization': 'Basic MGM5OTlmNzgtYzdlMi00NjUyLWFlOGEtZDYxZDM5YTUwNjll'
        };
        var repo =
            await http.post(url, headers: headers, body: json.encode(contents));
            print(repo.body);

  }



 Future<List<RiverMenu>> getMenuTransaction() async {

        SharedPreferences local = await SharedPreferences.getInstance();
                  idgetter = local.getString("menuplustrans");
       

        final response = await ApiCall().viewMenuTransac('/getMenuPerTransaction/$idgetter');
        // await ApiCall().transactionBuying('/transactionBuying/${widget.getID}');
        await ApiCall().transactionBuying('/transactionBuying/$idgetter');
       
        // final response = await ApiCall().viewMenuTransac('/getMenuPerTransaction/2');
        List<RiverMenu> ridermenu = [];

        var body = json.decode(response.body);
        for(var body in body){
            RiverMenu riverMenu = RiverMenu(
             menuName: body["menuName"],
              description: body["description"],
              totalPrice: body["totalPrice"].toDouble(),
              id: body["id"],
              quantity: body["quantity"],
            );
           
            ridermenu.add(riverMenu);          
        }

       

        return ridermenu;
        
  }


  @override


  Widget build(BuildContext context) {
    return Container(
          height: 240,
          width: MediaQuery.of(context).size.width,
          child: FutureBuilder(
            future: getMenuTransaction(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if(snapshot.data == null){
                return Container(
                      child: Center(
                        child: Text("Loading Menu's Please wait...",
                        style: TextStyle(
                color:  Color(0xFF0C375B),
                fontFamily: 'OpenSans',
                fontSize:  16.0,
                fontWeight: FontWeight.normal
              ),),    
                      ),
                    );
              }else{
                
                  return Container(
                    
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context,index){

                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                
                                  children: <Widget>[
                                   
                                     MenuDesign(
                                       menuname: snapshot.data[index].menuName,
                                       description: snapshot.data[index].description,
                                       price: snapshot.data[index].totalPrice.toString(),
                                       quantity: snapshot.data[index].quantity.toString(),

                                     ),
                                     
                                  ],

                              ),
                            );



                      }),
                  );
              }



            },
            ),
        );
  }
}