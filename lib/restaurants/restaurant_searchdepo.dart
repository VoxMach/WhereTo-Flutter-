import 'dart:convert';

import 'package:WhereTo/AnCustom/LocationSet.dart';
import 'package:WhereTo/AnCustom/UserDialog_help.dart';
import 'package:WhereTo/Services/connectivity_status.dart';
import 'package:WhereTo/Transaction/MyOrder/address.dart';
import 'package:WhereTo/Transaction/SearchMenu/newSearch.dart';
import 'package:WhereTo/Transaction/SearchMenu/search.dart';
import 'package:WhereTo/modules/gobal_call.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_view.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/static_food.dart';
import 'package:WhereTo/restaurants/carousel_rest.dart';
import 'package:WhereTo/restaurants/dialog.dart';
import 'package:WhereTo/restaurants/list_restaurant.dart';
import 'package:WhereTo/restaurants/new_Carousel.dart';
import 'package:WhereTo/styletext.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'FoodDisplay.dart';
class SearchDepo extends StatefulWidget {
  @override
  _SearchDepoState createState() => _SearchDepoState();
}

class _SearchDepoState extends State<SearchDepo> {
  @override
  void initState() {
    _getUserInfo();
    super.initState();
  }

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController search = new TextEditingController();
  String searchit;
  var userData;
  String address;
  String newAddress;
  bool isLoc =false;
  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    
    var user = json.decode(userJson);
    setState(() {
      userData = user;
      address =userData!= null ? userData['address'] :  'Fail get data.';
      newAddress ="${localStorage.getString("unit_number")}, ${localStorage.getString("house_number")}, ${localStorage.getString("building")}, ${localStorage.getString("street_name")}";
    });
  }

  @override
  Widget build(BuildContext context) {
    // var connectionStatus =Provider.of<ConnectivityStatus>(context);
    // if(connectionStatus ==ConnectivityStatus.Wifi){
    //   asuka.showSnackBar(SnackBar(content: Text("Connected",style: TextStyle(
    //     color: Colors.green
    //   ),)));
    // }
    // if(connectionStatus ==ConnectivityStatus.Offline){
    //   asuka.showSnackBar(SnackBar(content: Text("No Internet",style: TextStyle(
    //     color: Colors.red
    //   ),)));
    // }
    // if(connectionStatus ==ConnectivityStatus.Cellular){
    //   asuka.showSnackBar(SnackBar(content: Text("Mobile Data",style: TextStyle(
    //     color: Colors.orange
    //   ),)));
    // }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pureblue,
        title: Padding(
          padding: EdgeInsets.only(left: 0),
          child: Container(
            width: MediaQuery.of(context).size.width*0.8,
            child: GestureDetector(
                child: Column(
                  children: [
                  Text(
                "Delivery Address",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: "Gilroy-light",
                    fontWeight: FontWeight.bold),
                  ),
                  Text(address ?? "" , style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontFamily: "Gilroy-light",
                fontWeight: FontWeight.bold
              ),),
                  ],
                ),
              onTap: (){
                setState(() {
                  isLoc=false;
                });
                // Navigator.push(context, MaterialPageRoute(builder: (context) => AddressLine()));
              },
              ),

          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(left: 0),
          child: IconButton(icon: Icon(Icons.location_on), onPressed: (){
            setState(() {
              isLoc =true;
            });
          }),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => UserDialog_Help.exit(context),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Icon(
                    Icons.exit_to_app,
                    color: Color(0xFF0C375B),
                    size: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      key: scaffoldKey,
      body: WillPopScope(
        onWillPop: () async => false,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    NewCarousel(),
                  ],
                ),
                // SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 0,right: 0),
                  child: Container(
                              height: 50.0,
                              decoration: BoxDecoration(
                                color: pureblue,
                                // Colors.white.withOpacity(0.80),
                                // borderRadius: BorderRadius.circular(30.0),
                              ),
                              alignment: Alignment.centerLeft,
                              child: TextField(
                                readOnly: true,
                                showCursor: false,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy-light'),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: const EdgeInsets.only(
                                    top: 15.0,
                                  ),
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color:  Colors.white,
                                  ),
                                  hintText: "Search for Food",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy-light'),
                                ),
                                onTap: () {
                                  if(userData['address'].toString().contains("Tagum")){
                                  //   Navigator.push(context,
                                  //     MaterialPageRoute(builder: (context) {
                                  //   return SearchResto();
                                  // }));
                                  showSearch(context: context, delegate: CustomSearch());
                                  }else{
                                  AwesomeDialog(
                                  context: context,
                                  headerAnimationLoop: false,
                                  animType: AnimType.SCALE,
                                  dialogType: DialogType.INFO,
                                  title: "Location Not Available",
                                  desc: "This app is only available in Tagum City for the mean time",
                                  btnOkText: "Comeback Later",
                                  btnOkColor: Color(0xFF0C375B),
                                  btnOkOnPress: () async {
                                  Navigator.pop(context);
                                  }).show();
                                  }
                                  
                                },
                              )),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,),
                  child: SharedPrefCallnameData(),
                ),
                
                SizedBox(height: 40,),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    width: 300,
                    height: 20,
                    child: Text(
                      "Featured Food in Restaurants",
                      style: TextStyle(
                          color: pureblue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          fontFamily: 'Gilroy-light'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                FoodDisplay(),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    width: 200,
                    height: 20,
                    child: Text(
                      "Featured Restaurants",
                      style: TextStyle(
                          color:pureblue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          fontFamily: 'Gilroy-light'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 5.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: NewRestaurantViewFeatured(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
