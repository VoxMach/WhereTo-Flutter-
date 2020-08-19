import 'dart:convert';

import 'package:WhereTo/AnCustom/restaurant_front.dart';
import 'package:WhereTo/Transaction/MyOrder/getViewOrder.dart';
import 'package:WhereTo/Transaction/SearchMenu/FeaturedRestaurant.dart';
import 'package:WhereTo/Transaction/SearchMenu/bloc.search.dart';
import 'package:WhereTo/Transaction/SearchMenu/filteredMenu.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/restaurants/dialog.dart';
import 'package:WhereTo/restaurants/list_restaurant.dart';
import 'package:WhereTo/restaurants/searchRestaurant.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ntp/ntp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
class SearchResto extends StatefulWidget {
  @override
  _SearchRestoState createState() => _SearchRestoState();
}

class _SearchRestoState extends State<SearchResto> {
  var focus = new FocusNode();
    
  BlocSearch blocSearch;
    Future<void>getBloc(String id) async {
    await blocSearch.getmenu(id);
    }

    Future<void> disposeBloc() async {
    blocSearch.dispose();
    }
    
  TextEditingController search =TextEditingController();
  @override
  Widget build(BuildContext context) {
     setState(() {
    blocSearch = BlocSearch();
    getBloc(search.text); 
    });
    // FocusScope.of(context).requestFocus(focus);
    // focus.requestFocus();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(Icons.arrow_back, color: Colors.black), onPressed: (){
          Navigator.pop(context);
          
        }),
        actions: [
          IconButton(icon: Icon(Icons.clear, color: Colors.black,), onPressed:(){
            search.text ="";
          }),
        ],
        title: TextField(
          // focusNode: focus,
          controller: search,
          onChanged: (val){
            val =search.text;
            getBloc(search.text); 
          },
          textInputAction: TextInputAction.search,
          decoration: InputDecoration(
            border: InputBorder.none,
            fillColor: Colors.black,
            hintText: "Search"
          ),
        ),
        
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          
          Padding(padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
          child: Container(
            height: 700.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
            color: Color(0xFFF2F2F2F2),
            borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30), topRight: Radius.circular(30)),
          ),
          child: StreamBuilder<List<FilterRestaurant>>(
            stream: blocSearch.streamMenuApi,
            builder: (context,snapshot){
              if(snapshot.hasData){
              if(snapshot.data.length >0){
                return new ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int index) {
                  if(snapshot.data.length >0){
                     return Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: RestaurantFront(
                              image:
                                  "asset/img/${snapshot.data[index].restaurantName}.jpg",
                              restaurantName:
                                  snapshot.data[index].restaurantName,
                                  menuName: snapshot.data[index].menuName,
                              // restaurantAddress: snapshot.data[index].address,
                              // openAndclose: snapshot.data[index].openTime +
                              //     "-" +
                              //     snapshot.data[index].closingTime,
                              
                              onTap: () async {
                                // bool istrue =false;
                                // String baranggay;
                                // String restoID;
                                // final response = await ApiCall().getRestarant('/getFeaturedRestaurant');
                                // List<FeaturedRestaurant> search = featuredRestaurantFromJson(response.body);
                                // for(int z=0;z<search.length;z++){
                                //   if(snapshot.data[index].id.toString().contains(search[z].id.toString()) && snapshot.data[index].address.contains(search[z].address)){
                                //     baranggay =search[z].barangayName;
                                //     restoID =search[z].id.toString();
                                //     istrue =true;
                                //     break;
                                //   }
                                // }
                                // if(istrue){
                                //   // final now = await NTP.now();
                                // // final formatNow = DateFormat.Hm().format(now);
                                // // DateFormat inputFormat = DateFormat("H:mm");
                                // // DateTime dateCloseTime = inputFormat
                                // //     .parse(snapshot.data[index].closingTime);
                                // // DateTime dateOpen = inputFormat
                                // //     .parse(snapshot.data[index].openTime);
                                // // String formatClosing =
                                // //     DateFormat.Hm().format(dateCloseTime);
                                // // String formatOpen =
                                // //     DateFormat.Hm().format(dateOpen);
                                // // int cpTime =int.parse(formatNow.substring(0, 2));
                                // // int restoTime =int.parse(formatClosing.substring(0, 1));
                                // // int restoOpen =int.parse(formatOpen.substring(0,1));
                                SharedPreferences local =
                                    await SharedPreferences.getInstance();
                                var userjson = local.getString('user');
                                var user = json.decode(userjson);
                                var restaurant;
                                var status;
                                var address;
                                var insideResto =snapshot.data[index].restaurantName;
                                var insideAddress =snapshot.data[index].address;
                                var isRead = false;
                                Map<String, dynamic> temp;
                                List<dynamic> converted = [];
                                final response = await ApiCall().getData('/viewUserOrders/${user['id']}');
                                final List<ViewUserOrder> transaction =viewUserOrderFromJson(response.body);
                                transaction.forEach((element) {
                                  restaurant = element.restaurantName;
                                  status = element.status;
                                  address =element.address;
                                  temp = {
                                    "restaurant": restaurant,
                                    "status": status,
                                    "address":address,
                                  };
                                  converted.add(temp);
                                });
                                for (var i = 0; i < converted.length; i++) {
                                  if (insideResto ==converted[i]['restaurant'] &&insideAddress==converted[i]['address'] &&converted[i]['status'] < 4) {
                                    isRead = true;
                                    break;
                                  }
                                }
                                if (isRead) {
                                AwesomeDialog(
                                context: context,
                                headerAnimationLoop: false,
                                animType: AnimType.SCALE,
                                dialogType: DialogType.INFO,
                                title: "You Have a Pending Transaction",
                                desc: "Only One transaction on this Restaurant",
                                btnOkText: "Okay",
                                btnOkColor: Color(0xFF0C375B),
                                btnOkOnPress: () async {
                                
                                }).show();
                                } else {
                                  // if (int.parse(formatNow.split(":")[0]) >=int.parse(formatClosing.split(":")[0]) ||int.parse(formatNow.split(":")[0]) >= 0 &&int.parse(formatNow.split(":")[0]) <08) {
                                  //   print(
                                  //       "CLOSE current:${formatNow.split(":")[0]} restoTime:${formatClosing.split(":")[0]}");
                                  //   showDial(context,
                                  //       "Sorry The Restaurant is close at the Moment Please Come Back");
                                  // } else {
                                  //   if (int.parse(formatNow.split(":")[0]) >=
                                  //       int.parse(formatOpen.split(":")[0])) {
                                      Navigator.pushReplacement(
                                          context,
                                          new MaterialPageRoute(
                                              builder: (context) => ListStactic(
                                                    restauID: snapshot
                                                        .data[index].id
                                                        .toString(),
                                                    nameRestau: snapshot
                                                        .data[index]
                                                        .restaurantName
                                                        .toString(),
                                                        baranggay: snapshot.data[index].barangayName,
                                                  )));
                                   
                                  //   } else {
                                  //     showDial(context,
                                  //         "Sorry The Restaurant is Not yet open at the Moment Please Wait!");
                                  //   }
                                
                                }
                              },
                            ),
                          );   
                  }else{
                    return Container();
                  }
                },
              );
              }else{
                return Container();
              }

            }else{
              return Container(
                child: Center(
                  child: Text(
                    "",
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Gilroy-light',
                        fontStyle: FontStyle.normal),
                  ),
                ),
              );
            }
          }),
          ),
          )
        ],
      ),
    );
  }
}