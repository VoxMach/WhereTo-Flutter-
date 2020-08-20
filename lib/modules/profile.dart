import 'dart:convert';
import 'package:WhereTo/AnCustom/UserDialog_help.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/designbuttons.dart';

import 'package:WhereTo/modules/OtherFeatures/trans_port.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/restaurants/searchRestaurant.dart';
import 'package:WhereTo/styletext.dart';
import 'package:location/location.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// class Profile extends StatefulWidget with NavigationStates{
//   @override
//   _Profile createState() => _Profile();
// }

class Profile extends StatefulWidget {
  @override
  _Profile createState() => _Profile();
}

class _Profile extends State<Profile> {
  var userData;
  var constant;
  bool casting;
   
  String getRestaurant;
  final scaffoldKey = new GlobalKey<ScaffoldState>();
   TextEditingController search = new TextEditingController();
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
  }
//  getLocation() async{
//     var location =Location();
//     try{
//       var userLocation =await location.getLocation();
//       print("${userLocation.latitude},${userLocation.longitude}");
//     } on Exception catch (e){
//       print(e.toString());
//     }
//  }

//  Future<void>getService() async{
//    var location =Location();
//    bool _serviceEnabled;
//    _serviceEnabled = await location.serviceEnabled();
//   if (!_serviceEnabled) {
//   _serviceEnabled = await location.requestService();
//   if (!_serviceEnabled) {
//     return;
//   }
// }
//  }
//  Future<void>getPermission() async{
//    var location =Location();
//    PermissionStatus permissionStatus =await location.hasPermission();
//    if(permissionStatus ==PermissionStatus.denied){
//      permissionStatus =await location.requestPermission();
//      if(permissionStatus !=PermissionStatus.granted){
//        return;
//      }
//    }
//  }
  
  
  // void configSignal() async {
  //   OneSignal.shared
  //       .setInFocusDisplayType(OSNotificationDisplayType.notification);
  //   OneSignal.shared
  //       .setNotificationReceivedHandler((OSNotification notification){
  //     setState(() {
  //       //  constant = notification.payload.additionalData;
  //       data = notification.payload.additionalData;
  //       setState(() {
  //         if(data != null){
  //           if(data['force'].toString() == 'penalty'){
  //               _showDone(meesages.toString());
  //           }
             
  //         }
  //       });
        
  //     });
  //   });
  //   // await OneSignal.shared.setSubscription(true);
  //   // var tags = await OneSignal.shared.getTags();
  //   // var sendtag = await OneSignal.shared.sendTags({'UR': 'TRUE'});
  //   // var status = await OneSignal.shared.getPermissionSubscriptionState();

  //   // String url = 'https://onesignal.com/api/v1/notifications';
  //   // var playerId = status.subscriptionStatus.userId;
  //   // var idChil = "1106b49d-60f0-435a-b44f-5d2f4849cb38";
  //   // var numb = "3";
  //   // var contents = {
  //   //   "include_player_ids": [idChil,playerId],
  //   //   "include_segments": ["Users Notif"],
  //   //   "excluded_segments": [],
  //   //   "contents": {"en": "This is a test."},

  //   //   "data": {"id": numb},

  //   //   "headings": {"en": "Erchil Testings"},
  //   //   "filter": [
  //   //     {"field": "tag", "key": "UR", "relation": "=", "value": "TRUE"},
  //   //   ],
  //   //   "app_id": "2348f522-f77b-4be6-8eae-7c634e4b96b2"
  //   // };
  //   // Map<String, String> headers = {
  //   //   'Content-Type': 'application/json',
  //   //   'authorization': 'Basic MzExOTY5NWItZGJhYi00MmI3LWJjZjktZWJjOTJmODE4YjE5'
  //   // };
  //   // var repo =
  //   //     await http.post(url, headers: headers, body: json.encode(contents));

  //   // // await OneSignal.shared.deleteTags(["userID","2","transactionID","2"]);
  //   // print(data.toString());
  //   // print(tags);
  //   // print(sendtag);
  //   // print(playerId);
  //   // print(repo.body);
  
    
  // }



   

  @override
  Widget build(BuildContext context) {
  return Scaffold(
      key: scaffoldKey,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Stack(
                          overflow: Overflow.visible,
                          alignment: Alignment.topCenter,
                          children: <Widget>[
                            Container(
                          height: 330.0,
                          decoration: BoxDecoration(
                            color: pureblue,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(290),
                            ),
                          ),

                        ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(padding: const EdgeInsets.only(left: 30,top: 40),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                textDirection: TextDirection.ltr,
                                children: <Widget>[
                                    Container(
                             height: 120,
                             width: 120,
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               image: DecorationImage(
                                 image: AssetImage("asset/img/62512004_p0.png"),
                                 fit: BoxFit.cover),
                             ),
                           ),
                                SizedBox(height: 10,),
                                Text(userData!= null ? '${userData['name']}':  'Fail get data.',
                                                  style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 40.0,
                                                  fontFamily: 'Gilroy-ExtraBold'
                                                ),
                                                  ),
                                                  SizedBox(height: 10,),
                                                  Text(userData!= null ? '${userData['email']}' :  'Fail get data.',
                                                  style: TextStyle(
                                                  color: Color(0xfff2f2f2),
                                                  fontWeight: FontWeight.normal,
                                                  fontSize: 20.0,
                                                  fontFamily: 'Gilroy-light'
                                                ),
                                                  ),
                                ],
                              ),
                              ),
                            ),
                          
                          ],
                        ),
                           
                         
                                                  SizedBox(height: 40,),
                                                 Padding(
                                                   padding: const EdgeInsets.only(left: 20,right: 20),
                                                   child: NCard(
                                                        active: false,
                                 icon: Icons.phone_android,
                                 label: userData!= null ? '${userData['contactNumber']}' :  'Fail get data.',
                                                      ),
                                                 ), 
                                                    SizedBox(height: 40,),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 20,right: 20),
                                                      child: NCard(
                                                        active: false,
                                 icon: Icons.my_location,
                                 label: userData!= null ? '${userData['address']}' :  'Fail get data.',
                                                      ),
                                                    ),
                      SizedBox(height: 40,),
                      GestureDetector(
                            onTap: (){
                               UserDialog_Help.exit(context);
                            },
                            child: Container(
                              height: 50,
                              width: 140,
                              decoration: BoxDecoration(
                                color: pureblue,
                                borderRadius: BorderRadius.all(Radius.circular(100)),
                              ),
                              child: Center(
                                child: Text('Logout X',
                                style: TextStyle(
                                  fontFamily: 'Gilroy-ExtraBold',
                                  fontSize: 18,
                                  color: Colors.white
                                ),
                                ),
                              ),
                            ),
                          ),              
                                             
                                      

                      ],
              
                ),
              ),
            ),
        
    
  );
  }

  
 

}

class NCard extends StatelessWidget {

  final bool active;
  final IconData icon;
  final String label;
  final Function onTap;
  const NCard({this.active,this.icon,this.onTap,this.label});
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: onTap,
      child: Container(
        height: 50.0,
        width: MediaQuery.of(context).size.width,
        // decoration: BoxDecoration(
        //   color: Color(0xFF0C375B),
        //   borderRadius: BorderRadius.all(Radius.circular(40))
        // ),
        // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
        // decoration: eBox,
        decoration: eBoxDecorationStyle,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: <Widget>[
              Icon(icon,color: pureblue,size: 15.0,),
              SizedBox(width: 7.0,),

               Flexible(
                 flex: 1,
                 child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Container(
                        child: Text(label,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          color: pureblue,
                          fontWeight: FontWeight.w700,
                          fontSize: 16.0,
                          fontFamily: 'Gilroy-light'
                        ),),
                      ),
                    ),
               ),
             
              
            ],
          ),
        ),
      ),
    );
  }
}
