import 'dart:convert';
import 'package:WhereTo/A_loadingSimpe/dialog_singleStyle.dart';
import 'package:WhereTo/AnCustom/Rider_havePendingtrans.dart';
import 'package:WhereTo/AnCustom/dialog_showGlobal.dart';
import 'package:WhereTo/Rider/RiderDetails/riderStream.dart';
import 'package:WhereTo/Rider/RiderDetails/riderdetails.dart';
import 'package:WhereTo/Rider/RiderDetails/ridrDetailsresonse.dart';
import 'package:WhereTo/Rider/Rider_map.dart';
import 'package:WhereTo/Rider/profile_rider.dart';
import 'package:WhereTo/Rider/rider_dash.dart';
import 'package:WhereTo/Rider_MonkeyBar/rider_headerpage.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/button_OkAssign.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/finale/accepttransac.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuPerTransaction.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuResponseTran.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/getMenu/getMenuStreamtran.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/menudesign.dart';
import 'package:WhereTo/google_maps/Rider_route.dart';
import 'package:WhereTo/google_maps/coordinates_converter.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:WhereTo/Rider_ViewMenuTransac/rider_classMenu.dart';
import 'package:WhereTo/Rider_ViewMenuTransac/ridershowStep_Menu.dart';
import 'package:WhereTo/Rider_viewTransac/rider_viewtransac.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/designbuttons.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewMenuOnTransac extends StatefulWidget {
  
  final int getID;

  const ViewMenuOnTransac({this.getID});
  // final String gotTotal;
  // final String deliverTo;
  // final String restaurantName;
  // final String riderID;
  // final String deviceID;
  // final String deliveryCharge;
  // final String nametran;
  // final String playerId;
  // final String transacIDs;
  // final String user_coor;
  // final String contactNumber;

  // const ViewMenuOnTransac({Key key, this.getID, this.gotTotal, this.deliverTo, this.restaurantName, this.riderID, this.deviceID, this.deliveryCharge, this.nametran, this.playerId, this.transacIDs, this.user_coor, this.contactNumber}) : super(key: key);
  // final double dellats;
  // final double dellongs;
  // final double reslats;
  // final double reslongs;

 
  @override
  _ViewMenuOnTransacState createState() => _ViewMenuOnTransacState(getID);
}



class _ViewMenuOnTransacState extends State<ViewMenuOnTransac> {

  final int getID;

  _ViewMenuOnTransacState(this.getID);

// StepperType stepperType = StepperType.horizontal;

// switchThis(){

//   setState(() => stepperType == StepperType.horizontal 
//   ? stepperType = StepperType.vertical
//   : stepperType = StepperType.horizontal);

// }

var totalAll;
// var deliverFee;
double priceTotal = 0;
// int quantityTotal = 0;
var totals;
// var userData;
// var stepnumber;
// bool available = true;
// bool okAvail = true;
// int currentStep = 0;
// bool complete = false;
// bool stepTf = true;
// bool menuHide = true;
// bool backTF =true;
// bool cancelOrder = false;
// bool fuckme = false;
// var idgetter;
// var iderntify;
@override
  void initState() {
    getTotalPrice();
    // _getUserInfo();
    // identify();
    // riderCheck();
    // print(widget.getID);
    riderStreamDetails..getRiderTransacDetails(getID);
    getMenuStreamTransDet..getMenuTransacDetails(getID);
    super.initState();
  }


  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //    getMenuStreamTransDet..drainStreamDet();
  //    getMenuStreamTransDet..dispose();
  //   super.dispose();
   
  // }


  // void identify() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //     var userRider = localStorage.getString('menuplustrans');

  //     if(userRider != null){

  //        if(userRider == widget.getID){
  //           print("Can Continue");
  //        }else{
  //          print("The Id is"+userRider + "="+"${widget.getID}");
  //              showDialog(context: context,
  //       barrierDismissible: false,
  //       builder: (context) => RiderPending(
  //         message: "You have Still a Pending Transaction.",
  //         function: () => Navigator.pushReplacement(context,
  //          new MaterialPageRoute(builder: (context)
  //          => RiderProfile()),)),
  //       );
          
          
  //        } 

        
  //     }else{
  //       print("can get This transac.");
  //     }
  // }
//   notif2() async {
//        String url = 'https://onesignal.com/api/v1/notifications';
//     // var playerId = status.subscriptionStatus.userId;
//     // var idChil = "1106b49d-60f0-435a-b44f-5d2f4849cb38";
//     // var numb = "3";
//     var contents = {
//       "include_player_ids": ['${widget.playerId}'],
//       "include_segments": ["Users Notif"],
//       "excluded_segments": [],
//        "large_icon": "https://res.cloudinary.com/amadpogi/image/upload/v1600008167/logo_nh4bpx.png",
//       "contents": {"en": "Your Order is Being Delivered."},

//       "data": {
//         "id": "${userData['id']}",
//         "transact_id":"${widget.getID}",
//         "status":"3"
//       },
//       "headings": {"en": "WhereTo Rider"},
//       "filter": [
//         {"field": "tag", "key": "UR", "relation": "=", "value": "TRUE"},
//       ],
//       "app_id": "f5091806-1654-435d-8799-0cbd5fc49280"
//     };
//     Map<String, String> headers = {
//       'Content-Type': 'application/json',
//       'authorization': 'Basic MGM5OTlmNzgtYzdlMi00NjUyLWFlOGEtZDYxZDM5YTUwNjll'
//     };
//     var repo =
//         await http.post(url, headers: headers, body: json.encode(contents));
//         print(repo.body);
//   }
//   notif3() async {
//  String url = 'https://onesignal.com/api/v1/notifications';
//     // var playerId = status.subscriptionStatus.userId;
//     // var idChil = "1106b49d-60f0-435a-b44f-5d2f4849cb38";
//     // var numb = "3";
//     var contents = {
//       "include_player_ids": ['${widget.playerId}'],
//       "include_segments": ["Users Notif"],
//       "excluded_segments": [],
//        "large_icon": "https://res.cloudinary.com/amadpogi/image/upload/v1600008167/logo_nh4bpx.png",
//       "contents": {"en": "Your Order Successfully Delivered."},

//       "data": {
//         "id": "${userData['id']}",
//         "transact_id":"${widget.getID}",
//         "status":"4"
//       },
//       "headings": {"en": "WhereTo Rider"},
//       "filter": [
//         {"field": "tag", "key": "UR", "relation": "=", "value": "TRUE"},
//       ],
//       "app_id": "f5091806-1654-435d-8799-0cbd5fc49280"
//     };
//     Map<String, String> headers = {
//       'Content-Type': 'application/json',
//       'authorization': 'Basic MGM5OTlmNzgtYzdlMi00NjUyLWFlOGEtZDYxZDM5YTUwNjll'
//     };
//     var repo =
//         await http.post(url, headers: headers, body: json.encode(contents));
//         print(repo.body);
//   }
//    Widget _viewMenus(){

//         return Visibility(
//           visible: menuHide,
//           child: Container(
//             height: 240,
//             width: MediaQuery.of(context).size.width,
//             child: FutureBuilder(
//               future: getMenuTransac(),
//               builder: (BuildContext context, AsyncSnapshot snapshot){
//                 if(snapshot.data == null){
//                   return Container(
//                         child: Center(
//                           child: Text("Loading Menu's Please wait...",
//                           style: TextStyle(
//                   color:  Color(0xFF0C375B),
//                   fontFamily: 'OpenSans',
//                   fontSize:  16.0,
//                   fontWeight: FontWeight.normal
//                 ),),    
//                         ),
//                       );
//                 }else{
                  
//                     return Container(
                      
//                       child: ListView.builder(
//                         scrollDirection: Axis.horizontal,
//                         itemCount: snapshot.data.length,
//                         itemBuilder: (context,index){
//                               return Padding(
//                                 padding: const EdgeInsets.only(right: 10),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  
//                                     children: <Widget>[
                                     
//                                        MenuDesign(
//                                          menuname: snapshot.data[index].menuName,
//                                          description: snapshot.data[index].description,
//                                          price: snapshot.data[index].totalPrice.toString(),
//                                          quantity: snapshot.data[index].quantity.toString(),

//                                        ),
                                       
//                                     ],

//                                 ),
//                               );



//                         }),
//                     );
//                 }



//               },
//               ),
//           ),
//         );

//     }


//   List<Step> steps = [
//       Step(
//         title: const Text("Buy",
//         style: TextStyle(
//           fontFamily: 'OpenSans',
//           color:  Colors.black,
//         ),
//         ),
//         isActive: true,
//         state: StepState.editing,
//         content: MShowStep(),),


//          Step(
//         title: const Text("Deliver",
//         style: TextStyle(
//           fontFamily: 'OpenSans',
//           color:  Colors.black,
//         ),
//         ),
//         isActive: true,
//         state: StepState.complete,
        
//         content: Stack(
//          children: <Widget>[
//            Align(
//              alignment: Alignment.topCenter,
//              child: Container(
//                         height: 300.0,
//                         width: 300.0,
//                         decoration: BoxDecoration(
//                           image: DecorationImage(
//                             image: AssetImage("asset/img/deliveryProcess.png"))
//                           // color: Color(0xFF0C375B),
//                         ),
//                         // child: Text("2"),
//                 ),
//            ),
//          ], 
//         )),
//          Step(
//         title: const Text("Done.",
//         style: TextStyle(
//           fontFamily: 'OpenSans',
//           color:  Colors.black,
//         ),
//         ),
//         isActive: true,
//         state: StepState.complete,
//         content: Stack(
//           alignment: Alignment.topCenter,
//          children: <Widget>[
//            Container(
//                       height: 300.0,
//                       width: 300.0,
//                       decoration: BoxDecoration(
//                         image: DecorationImage(
//                           image: AssetImage("asset/img/doneprocess.png"))
//                         // color: Color(0xFF0C375B),
//                       ),
//                       // child: Text("2"),
//               ),
//          ], 
//         ))

//   ];

//   // by() async {
//   // await ApiCall().transactionBuying('/transactionBuying/${widget.getID}');
//   // notif1();
//   // }
//   deliver() async {
//   await ApiCall().transactionDelivery('/transactionDelivery/${widget.getID}');
//   notif2();
//   }
//   done() async{
//   // await ApiCall().transactionComplete('/transactionComplete/${widget.getID}');
//   notif3();
//   }

//   nextSteps(){
//     currentStep + 1 != steps.length
//     ? goTo(currentStep + 1) 
//     : setState(()=> complete = true);
   
//     stepnumber = currentStep+ 1;  
//   }


//   cancel(){
//     if(currentStep > 0){
//       goTo(currentStep - 1);
//     }
//   }
//   goTo(int step){
//     setState(() => currentStep = step);

//     print(step);
//       if(step == 1){
//       deliver();
//     }else if(step == 2){
//       done();
//     }
//   }
// void _getUserInfo() async {
//       SharedPreferences localStorage = await SharedPreferences.getInstance();
//       var userJson = localStorage.getString('user'); 
//       var user = json.decode(userJson);
//       setState(() {
//         userData = user;
//       });
//   }

// Future<List<RiverMenu>> getMenuTransac() async {


//         final response = await ApiCall().viewMenuTransac('/getMenuPerTransaction/${widget.getID}');
//         // final response = await ApiCall().viewMenuTransac('/getMenuPerTransaction/3');
        
//         List<RiverMenu> ridermenu = [];

//         var body = json.decode(response.body);
//         for(var body in body){
//             RiverMenu riverMenu = RiverMenu(
//               menuName: body["menuName"],
//               description: body["description"],
//               totalPrice: body["totalPrice"].toDouble(),
//               id: body["id"],
//               quantity: body["quantity"],
//             );
           

//             ridermenu.add(riverMenu);          
//         }

       

//         return ridermenu;
        
//   }

void getTotalPrice() async{


final response = await ApiCall().viewMenuTransac('/getMenuPerTransaction/${widget.getID.toString()}');                     
                              var body = json.decode(response.body);
                              for(var body in body){
                                  RiverMenu riverMenu = RiverMenu(
                                    menuName: body["menuName"],
                              description: body["description"],
                              totalPrice: body["totalPrice"].toDouble(),
                              id: body["id"],
                              quantity: body["quantity"],
                                  );
                                  List prices =  [riverMenu.totalPrice];
                                  List quans =  [riverMenu.quantity];
                                  for(var i = 0 ; i < prices.length; i++){
                                    // double chan = i;
                                    for(var x = 0 ; x < quans.length ; x++){
                                        totalAll = prices[i]*quans[x];
                                      List all =  [totalAll]; 
                                      for(var z = 0 ; z < all.length; z++){
                                            priceTotal = priceTotal+all[z];                                           
                                      }
                                  }
                                  }           
                              }
                              setState(() {
                                  totals = priceTotal;
                              print(totals);

                              });
                            
}

// void riderCheck() async{
// SharedPreferences localStorage = await SharedPreferences.getInstance();
// var checkVal = localStorage.getBool('check');
//         String riderId = widget.riderID.toString();
//         if(riderId == "null"){
//           print(riderId);
//               setState(() {
//                 okAvail = !okAvail;
//                 available = available;
//               });
//         }else if(riderId != null){
//           setState(() {
//             available = !available;
            
//             if(checkVal != null){
//               if(checkVal){
              
//                 if(riderId != userData['id'].toString()){
//                     okAvail = !okAvail;
//                 }else{
//                   okAvail = okAvail;
//                   menuHide = !menuHide;
//                   backTF = !backTF;
//                 }
//               }
               
//             } 

//           });
//         }
//     }

final ScrollController _scrollContext = ScrollController();
bool visvisiko;
  
  Widget bodyAll(){
      return StreamBuilder<RiderDetailsResponse>(
      stream: riderStreamDetails.subject.stream,
      builder: (context,AsyncSnapshot<RiderDetailsResponse> snaphot){
         if(snaphot.hasData){
            if(snaphot.data.error !=null && snaphot.data.error.length > 0){
                return _errorTempMessage(snaphot.data.error);
            }
              return _view(snaphot.data);
        }else if(snaphot.hasError){
              return _errorTempMessage(snaphot.error);
        }else{
              return _loading();
        }
      
      });
  }

  Widget bodyAllMenu(){
      return StreamBuilder<GetMenuPertransactionResponse>(
      stream: getMenuStreamTransDet.subject.stream,
      builder: (context,AsyncSnapshot<GetMenuPertransactionResponse> snaphot){
         if(snaphot.hasData){
            if(snaphot.data.error !=null && snaphot.data.error.length > 0){
                return _errorTempMessage(snaphot.data.error);
            }
              return _views(snaphot.data);
        }else if(snaphot.hasError){
              return _errorTempMessage(snaphot.error);
        }else{
              return _loading();
        }
      
      });
  }
  Widget _views(GetMenuPertransactionResponse getMenuPertransactionResponse ){
    List<GetMenuPerTransaction> geto = getMenuPertransactionResponse.getTran;
    if(geto.length == 0){
      return Center(
          child: Icon(Icons.clear,color: wheretoDark,size: 50,),
        );
    }else{
      return ListView.builder(
        itemCount: geto.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (con,index){
          return Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: 140,
              width: 160,
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow( spreadRadius: 2.2,blurRadius: 2.2,color: wheretoDark.withOpacity(0.2))],
                  borderRadius: BorderRadius.circular(15),
              ),
            child: Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Text(geto[index].menuName,
                    style: TextStyle(
                      color: wheretoDark,
                      fontFamily: 'Gilroy-ExtraBold',
                      fontSize: 12
                    ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Divider(
                    height: 6.0,
                    thickness: 2,
                    color: wheretoDark,
                    indent: 10.0,
                    endIndent: 10.0,
                  ),
                  SizedBox(height: 15,),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Price : ',
                           style: TextStyle(
                    color: wheretoDark,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 12
                  ),
                        ),
                        TextSpan(
                          text: geto[index].totalPrice.toString(),
                           style: TextStyle(
                    color: wheretoDark,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 12
                  ),
                        ),
                      ]
                    )),

                    SizedBox(height: 15,),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Qty : ',
                           style: TextStyle(
                    color: wheretoDark,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 12
                  ),
                        ),
                        TextSpan(
                          text: geto[index].quantity.toString(),
                           style: TextStyle(
                    color: wheretoDark,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontSize: 12
                  ),
                        ),
                      ]
                    )),
                ],
              ),
            ),

            ),
            );
      });
    }
  }
  Widget _view(RiderDetailsResponse response){
    List<RiderDetailsTransac> riderDetailsTransac = response.responseDetail;
      if(riderDetailsTransac.length == 0){
        return Center(
          child: Icon(Icons.clear,color: wheretoDark,size: 50,),
        );
      }else{
        return ListView.builder(
          itemCount: riderDetailsTransac.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context,index){

            if(riderDetailsTransac[index].riderId == null){
              visvisiko = true;
            }else{
              visvisiko = false;
            }  

            return 
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                height: 190,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow( spreadRadius: 2.2,blurRadius: 2.2,color: wheretoDark.withOpacity(0.2))],
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight:Radius.circular(15),
                  )
                ),
                child: Stack(
                  overflow: Overflow.visible,
                  children: [

                    Align(
                      alignment: Alignment.topRight,
                      child:   Padding(
                  padding: const EdgeInsets.only(top: 15,right: 20),
                  child: Visibility(
                    visible: visvisiko,
                    child: Container(
                      height: 50,
                      width: 140,
                      child: RaisedButton(
                        splashColor: Colors.white,
                        color: wheretoDark,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: Center(
                          child: Text('Accept',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gilroy-light',
                            fontSize: 14
                          ),
                          ),
                        ),
                        onPressed: ()=>
                         showDialog(
      barrierDismissible: false,
      context: (context),
      builder: (context) 
      =>
       DialogForAll(
        widgets: SpinKitPumpingHeart(color: wheretoDark,size: 80,),
        labelHeader: "Accept Order?",
        message: "Total of Menu is $totals Are you Ok with it?",
        buttTitle1: "YES",
        buttTitle2: "NO",
        noFunc: ()=>Navigator.pop(context),
        yesFunc: () =>
        acceptIt..pumpingAcc(
          context
         ,riderDetailsTransac[index].id
         ,riderDetailsTransac[index].restaurantName
         ,riderDetailsTransac[index].deviceId
         ,riderDetailsTransac[index].deliveryAddress
         ,riderDetailsTransac[index].name
         ,riderDetailsTransac[index].contactNumber.toString()
         ,riderDetailsTransac[index].restaurantId
        ),
        showorNot1: true,
        showorNot2: true,
      ),)
                        ),
                    ),
                  ),
                  ),
                    ),

                      Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20,bottom: 20,top: 10),
                                    child: Container(
                                      height: 28,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: 4,
                                            width: 90,
                                            decoration: BoxDecoration(
                                              color: wheretoDark,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          ),
                                          SizedBox(height: 4,),
                                           Container(
                                            height: 4,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: wheretoDark,
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                      Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 20,top:10,bottom: 10),
                                    child: GestureDetector(
                                      onTap: (){
                                          Navigator.pushReplacement(context, 
                                                     new MaterialPageRoute(builder: (context) =>
                                                     RiderTransaction())
                                                     );
                                      },
                                      child: Icon(
                                        Icons.clear,
                                        size: 45,
                                        color: wheretoDark,
                                      ),
                                    ),
                                    ),
                                ),
                      Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 10,top: 15) ,
                                    child: Container(
                                      height: 90,
                                      width: MediaQuery.of(context).size.width,
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            height: 80,
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(riderDetailsTransac[index].name,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  color: wheretoDark,
                                                  fontFamily: "Gilroy-ExtraBold",
                                                  fontSize: 30                                      ),
                                                ),
                                                SizedBox(height: 5,),
                                                 Text("Customer",
                                                style: TextStyle(
                                                  color: wheretoDark,
                                                  fontFamily: "Gilroy-light",
                                                  fontSize: 16                                      ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 80,
                                            width: 80,
                                            padding: EdgeInsets.all(2.0),
                                            
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              border: Border.all(
                                                color: wheretoDark,
                                                width: 2
                                              ),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Container(
                                              height: 70,
                                              width: 70,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  image: AssetImage("asset/img/logo.png")
                                                ),
                                              ),
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
                SizedBox(height: 15,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.restaurant,size: 25,color: wheretoDark,),
                        SizedBox(width: 30,),
                        Text(riderDetailsTransac[index].restaurantName,
                        style: TextStyle(fontFamily: 'Gilroy-light',fontSize: 18,color: wheretoDark),)
                      ],
                    ), 
                    ),
                ),
                SizedBox(height: 15,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.location_city,size: 25,color: wheretoDark,),
                        SizedBox(width: 30,),
                        Text(riderDetailsTransac[index].barangayName,
                        style: TextStyle(fontFamily: 'Gilroy-light',fontSize: 18,color: wheretoDark),)
                      ],
                    ), 
                    ),
                ),
                SizedBox(height: 15,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.delivery_dining ,size: 25,color: wheretoDark,),
                        SizedBox(width: 30,),
                        Text(riderDetailsTransac[index].deliveryAddress,
                        style: TextStyle(fontFamily: 'Gilroy-light',fontSize: 18,color: wheretoDark),)
                      ],
                    ), 
                    ),
                ),
                SizedBox(height: 15,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.phone_android,size: 25,color: wheretoDark,),
                        SizedBox(width: 30,),
                        Text(riderDetailsTransac[index].contactNumber,
                        style: TextStyle(fontFamily: 'Gilroy-light',fontSize: 18,color: wheretoDark),)
                      ],
                    ), 
                    ),
                ),
                 SizedBox(height: 15,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.device_hub ,size: 25,color: wheretoDark,),
                        SizedBox(width: 30,),
                        Text(riderDetailsTransac[index].deviceId,
                        style: TextStyle(fontFamily: 'Gilroy-light',fontSize: 18,color: wheretoDark),)
                      ],
                    ), 
                    ),
                ),
                SizedBox(height: 15,),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(Icons.money ,size: 25,color: wheretoDark,),
                        SizedBox(width: 30,),
                        Text(riderDetailsTransac[index].deliveryCharge.toString(),
                        style: TextStyle(fontFamily: 'Gilroy-light',fontSize: 18,color: wheretoDark),)
                      ],
                    ), 
                    ),
                ),
              

              ],
            ),
          );
          });
      }
  }


Widget _errorTempMessage(String error){
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Comback Later.")
              ],
            ),
          );
}
  Widget _loading(){
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
                  height: 25.0,
                  width: 25.0,
                  child:  CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.purple),
                    strokeWidth: 4.0,
                  ),
                ),
          ],


        ),
      );
    }

     Widget inuyashiki(){
        return Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text("Menu Orders:",
                        style: TextStyle(fontFamily: 'Gilroy-ExtraBold',fontSize: 18,color: wheretoDark),),
          );
  }

   Widget totalShown(){
        return Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Text(totals == null ? "..." : "₱ $totals",
                        style: TextStyle(fontFamily: 'Gilroy-ExtraBold',fontSize: 18,color: wheretoDark),),
          );
  }

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
          body: WillPopScope(
            child: SafeArea(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 430,
                          width: MediaQuery.of(context).size.width,
                          child: bodyAll()),
                          SizedBox(height: 30,),
                          inuyashiki(),
                          SizedBox(height: 15,),
                          totalShown(),
                          SizedBox(height: 15,),
                          Container(
                            height: 220,
                            width: MediaQuery.of(context).size.width,
                            child: bodyAllMenu(),
                          ),
                      ],
                    ),
                  ),
                ),
             
          onWillPop: () async => false),
       
    
    );  

 

    // return Scaffold(
    //     backgroundColor:Color(0xFFF2F2F2),
    //     body: WillPopScope(
    //       onWillPop: () async => false,
    //           child: Container(
    //             height: MediaQuery.of(context).size.height,
    //             width: MediaQuery.of(context).size.width,
    //             child: SafeArea(
    //               child: SingleChildScrollView(
    //                 physics: AlwaysScrollableScrollPhysics(),
    //                   child: Padding(
    //                     padding: const EdgeInsets.only(left: 30,right: 30),
    //                     child: Column(
    //                       crossAxisAlignment: CrossAxisAlignment.start,
    //                       children: <Widget>[
    //                         SizedBox(height: 15,),
    //                         Stack(
    //                           children: <Widget>[
    //                             Align(
    //                               alignment: Alignment.topLeft,
    //                               child: Visibility(
    //                                             visible: backTF,
    //                                             child: 
    //                                             GestureDetector(
    //                                               onTap: (){
    //                                                 // Navigator.pop(context);
    //                                                Navigator.pushReplacement(context, 
    //                                                new MaterialPageRoute(builder: (context) =>
    //                                                RiderTransaction())
    //                                                );
    //                                               },
    //                                               child: Container(
    //                                                  height: 60,
    //                                             width: 60,
    //                                             decoration: BoxDecoration(
    //                                               color: pureblue,
    //                                               // border: Border.all(
    //                                               //   width: 1,
    //                                               //   color: pureblue
    //                                               // ),
    //                                               shape: BoxShape.circle,
    //                                             ),
    //                                             child: Center(
    //                                               child: Icon(
    //                                                 Icons.backspace,
    //                                                 size: 30,
    //                                                 color: Colors.white
    //                                               ),
    //                                             ),
    //                                               ),
    //                                             )
    //                                           ),
    //                             ),
    //                             Align(
    //                               alignment: Alignment.topRight,
    //                               child: Visibility(
    //                                 visible: cancelOrder,
    //                                 child: GestureDetector(
    //                                                 onTap: (){
    //                                                   cancelOrderS(widget.getID,widget.playerId);
    //                                                 },
    //                                                 child: Container(
    //                                                    height: 60,
    //                                               width: 120,
    //                                               decoration: BoxDecoration(
    //                                                 color: pureblue,
    //                                                 borderRadius: BorderRadius.all(Radius.circular(50)),
    //                                                 // border: Border.all(
    //                                                 //   width: 1,
    //                                                 //   color: pureblue
    //                                                 // ),
                                                    
    //                                               ),
    //                                               child: Center(
    //                                                 child: Text("CANCEL ORDER",
    //                                                 style: TextStyle(
    //                                                   color: Colors.white,
    //                                                   fontFamily: 'Gilroy-ligh',
    //                                                   fontSize: 12
    //                                                 ),)
    //                                               ),
    //                                                 ),
    //                                               ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
                           
    //                       SizedBox(height: 20,),
    //                        Container(
    //                                 width: MediaQuery.of(context).size.width,
    //                                 child: Column(
    //                                               crossAxisAlignment: CrossAxisAlignment.start,
    //                                             mainAxisAlignment: MainAxisAlignment.center,
    //                                             children: <Widget>[
    //                                               NCard(
    //                                                 icon: Icons.person,
    //                                                 label: widget.nametran,
    //                                               ),
    //                                               SizedBox(height: 10,),
    //                                                NCard(
    //                                                 icon: Icons.restaurant,
    //                                                 label: widget.restaurantName,
    //                                               ),
    //                                               SizedBox(height: 10,),
    //                                               // FutureBuilder(
    //                                               //    future: CoordinatesConverter()
    //                                               //    .getAddressByLocation(
    //                                               //       widget.reslats.toString()
    //                                               //        + "," +
    //                                               //        widget.reslongs.toString()
    //                                               //    ),
    //                                               //   builder: (context,snaps){
    //                                               //     if(snaps.data == null){
    //                                               //       return Text("Data Error");
    //                                               //     }else{
    //                                               //       return  NCard(
    //                                               //   icon: EvaIcons.map,
    //                                               //   label:snaps.data
    //                                               // );
    //                                               //     }
    //                                               //   },
    //                                               //  ),
    //                                               //  SizedBox(height: 10,),
    //                                                NCard(
    //                                                 icon: Icons.phone_android,
    //                                                 label:widget.contactNumber,
    //                                               ),
    //                                               SizedBox(height: 10,),
    //                                                 NCard(
    //                                                 icon: EvaIcons.mapOutline,
    //                                                 label: widget.user_coor,
    //                                               ),

    //                                               SizedBox(height: 10,),
    //                                                NCard(
    //                                                 icon: EvaIcons.pricetags,
    //                                                 label: widget.deliveryCharge,
    //                                               ),
    //                                               SizedBox(height: 10,),

    //                                               //  FutureBuilder(
    //                                               //    future: CoordinatesConverter()
    //                                               //    .getAddressByLocation(
    //                                               //       widget.dellats.toString()
    //                                               //       +","+
    //                                               //       widget.dellongs.toString()
    //                                               //    ),
    //                                               //   builder: (context,snaps){
    //                                               //     if(snaps.data == null){
    //                                               //       return Text("Data Error");
    //                                               //     }else{
    //                                               //       return  NCard(
    //                                               //   icon: Icons.my_location,
    //                                               //   label:snaps.data
    //                                               // );
    //                                               //     }
    //                                               //   },
    //                                               //  ),
    //                                               SizedBox(height: 10,),
                                                    
    //                                                   ],
    //                                                 ),
    //                               ),
    //                        SizedBox(height: 5 ,),
    //                        Visibility(
    //                                         visible: available,
    //                                         child: InkWell(
    //                                           splashColor: pureblue,
    //                                           onTap: (){
    //                                             xDilogAhow(context);
    //                                             // print(userData['id']);
    //                                           },
    //                                           child: Padding(
    //                                             padding: const EdgeInsets.only(left: 20,right: 20),
    //                                             child: Container(
    //                                               height: 50,
    //                                               width: MediaQuery.of(context).size.width,
    //                                               decoration: BoxDecoration(
    //                                                 color: pureblue,
    //                                                 // border: Border.all(
    //                                                 //   width: 1,
    //                                                 //   color: pureblue,
    //                                                 // ),
    //                                                 borderRadius: BorderRadius.all(Radius.circular(100)),
    //                                               ),
    //                                               child: Center(
    //                                                 child: Text("Accept Transaction",
    //                                                 style: TextStyle(
    //                                                   color: Colors.white,
    //                                                   fontFamily: 'Gilroy-ExtraBold',
    //                                                   fontSize: 20
    //                                                 ),
    //                                                 )
    //                                               ),
    //                                             ),
    //                                           ),


    //                                         ),
    //                                       ),     
    //                       SizedBox(height: 20,),

    //                       // Container(
    //                       //   width: MediaQuery.of(context).size.width,
    //                       //   child: Row(
    //                       //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       //     children: [
    //                       //        Container(
    //                       //    width: 110,
    //                       //    height: 50,
    //                       //    child: RaisedButton(
    //                       //      shape: RoundedRectangleBorder(
    //                       //        borderRadius: BorderRadius.all(Radius.circular(50)),
    //                       //      ),
    //                       //      color: pureblue,
    //                       //      onPressed: (){
    //                       //        RiderRoute().getRoute(widget.dellats.toString()+","+widget.dellongs.toString(),);
    //                       //      },
    //                       //      child:Center(
    //                       //        child: Text("Location",
    //                       //        style: TextStyle(
    //                       //          color: Colors.white,
    //                       //          fontFamily: 'Gilroy-light'
    //                       //        ),
    //                       //        ),
    //                       //      ) 
    //                       //      ,),
    //                       //  ),
    //                       //  Container(
    //                       //    width: 110,
    //                       //    height: 50,
    //                       //    child: RaisedButton(
    //                       //      shape: RoundedRectangleBorder(
    //                       //        borderRadius: BorderRadius.all(Radius.circular(50)),
    //                       //      ),
    //                       //      color: pureblue,
    //                       //      onPressed: (){
    //                       //        RiderRoute().getRoute(widget.reslats.toString()+","+widget.reslongs.toString());
    //                       //      },
    //                       //      child:Center(
    //                       //        child: Text("Restaurant",
    //                       //        style: TextStyle(
    //                       //          color: Colors.white,
    //                       //          fontFamily: 'Gilroy-light'
    //                       //        ),
    //                       //        ),
    //                       //      ) 
    //                       //      ,),
    //                       //  ),
    //                       //     ],
    //                       //   ),
    //                       // ),
    //                          SizedBox(height: 20,),
    //                          Container(
    //                          height: 50.0,
    //                          width: MediaQuery.of(context).size.width,
    //                          decoration: BoxDecoration(
    //                            border: Border.all(
    //                              width: 1,
    //                              color: pureblue
    //                            ),
    //                            borderRadius: BorderRadius.circular(60.0),
    //                          ),
                              
    //                           child: Column(
    //                             crossAxisAlignment: CrossAxisAlignment.center,
    //                             children: <Widget>[
    //                              Padding(
    //                                padding: const EdgeInsets.only(top: 12),
    //                                child:  Text(totals == null ? "..." : "₱ $totals",
    //                                 overflow: TextOverflow.ellipsis,
    //                                               style: TextStyle(
    //                                               color: pureblue,
    //                                               fontSize: 18.0,
    //                                               fontFamily: 'Gilroy-ExtraBold'
    //                                             ),
    //                                               ),),
    //                             ],
    //                           ),
    //                         ),
    //                       SizedBox(height: 10.0,),
    //                         complete ? Center(
    //                           child: Padding(
    //                             padding: const EdgeInsets.all(20.0),
    //                             child: Container(
    //                               height: 200,
    //                               width: MediaQuery.of(context).size.width,
    //                               decoration: BoxDecoration(
    //                                 borderRadius: BorderRadius.circular(20.0),
    //                                  gradient: LinearGradient(
    //                               stops: [0.2,4],
    //                               colors: 
    //                               [
    //                                 Color(0xFF0C375B),
    //                                 Color(0xFF176DB5)
    //                               ],
    //                               begin: Alignment.bottomRight,
    //                               end: Alignment.topLeft),
    //                               ),
    //                               child: Column(
    //                                 mainAxisAlignment: MainAxisAlignment.center,
    //                                 children: <Widget>[
    //                                   Padding(
    //                                     padding: const EdgeInsets.only(left: 20,right: 20),
    //                                     child: Text("Done! Orders Successfully Delivered.",
    //                                     style: TextStyle(
    //                                       color: Colors.white,
    //                                       fontFamily: 'OpenSans',
    //                                       fontSize: 18.0,
    //                                       fontWeight: FontWeight.w700,
    //                                     ),),
    //                                   ),
    //                                   SizedBox(height: 30.0,),
    //                                   Text("Again Job Well Done!.",
    //                                   style: TextStyle(
    //                                     color: Colors.white,
    //                                     fontFamily: 'OpenSans',
    //                                     fontSize: 12.0,
    //                                     fontWeight: FontWeight.w700,
    //                                   ),),
    //                                   SizedBox(height: 10.0,),
    //                                    RaisedButton(
    //                                   color: Colors.white,
    //                                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    //                                   onPressed: () async {
    //                                     await ApiCall().transactionComplete('/transactionComplete/${widget.getID}');
    //                                     SharedPreferences localStorage = await SharedPreferences.getInstance();
    //                                     localStorage.remove('menuplustrans');
    //                                     localStorage.remove('playerIDS');
    //                                      Navigator.pushReplacement(context, 
    //                                                new MaterialPageRoute(builder: (context) =>
    //                                                RiderTransaction())
    //                                                );
    //                                         //   setState(() {
    //                                         //   complete = false;                    

    //                                         // });
    //                                   // Navigator.of(context).pop();
    //                                       },   
    //                                   child: Text ( "Yes", style :TextStyle(
    //                                   color: Color(0xFF398AE5),
    //                                               fontWeight: FontWeight.w700,
    //                                               fontSize: 12.0,
    //                                               fontFamily: 'OpenSans'
    //                                 ),),),
    //                                 ],
    //                               ),
    //                             ),
    //                           ),
    //                         ):                         
    //                         Visibility(
    //                           visible: okAvail,
    //                             child: Container(
    //                               width: MediaQuery.of(context).size.width,
    //                               height: 450.0,
    //                               child: Stepper(
    //                                   steps: steps,
    //                                   // type: stepperType,
    //                                   currentStep: currentStep,
    //                                   onStepContinue: nextSteps,
    //                                   onStepTapped: (step) => goTo(step),
    //                                   onStepCancel: cancel,
    //                                   controlsBuilder: (
    //                                     BuildContext context ,{VoidCallback onStepContinue,VoidCallback onStepCancel}){
    //                                        return SingleChildScrollView(
    //                                          scrollDirection: Axis.horizontal,
    //                                          child: Row(
    //                                            crossAxisAlignment: CrossAxisAlignment.start,
    //                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //                                            children: <Widget>[
    //                                               NCard1Button(
    //                                             width: 80,
    //                                             icon: Icons.skip_next,
    //                                             label: "OK",
    //                                             onTap: onStepContinue,
    //                                             active: false,
    //                                               ),
    //                                               SizedBox(width: 30.0,),
    //                                               NCard1Button(
    //                                             width: 80,
    //                                             icon: Icons.cancel,
    //                                             label: "BACK",
    //                                             onTap: onStepCancel,
    //                                             active: true,
    //                                               ),

    //                                            ],
    //                                          ),
    //                                        ); 
    //                                   },
    //                               ),
    //                             ),
                              
    //                         ), 
    //                       SizedBox(height: 20.0,),
    //                       Visibility(
    //                         visible: menuHide,
    //                         child: Text("Menu to Buy :",
    //                         style: TextStyle(
    //                           color: pureblue,
    //                           fontSize: 18,
    //                           fontFamily: 'Gilroy-light',
    //                           fontWeight: FontWeight.bold
    //                         ),
    //                         ),),
    //                     _viewMenus(),
    //                       ],
                        
    //                     ),
    //                   ),
                      
    //                   ),
                      
                     
    //             ),
    //           ),
       
    //     ),
    //   );


  }

 Widget springKling() {

   return Container(
     height: 80,
     width: 80,
     child: SpinKitDoubleBounce(
       color: pureblue,
       size: 60,
     ),
   );

 }

  // void cancelOrderS(String gettheID,String idNotif) async {



  //   showDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (BuildContext context) {
  //       return Dialog(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(20),
  //         ),
  //         elevation: 0,
  //         backgroundColor: Colors.transparent,
  //         child:Container(
  //     height: 300.0,
  //     width: MediaQuery.of(context).size.width,
  //     decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(20), color: Colors.white),
  //     child: SingleChildScrollView(
  //       physics: AlwaysScrollableScrollPhysics(),
  //       child:
        
  //        Column(
  //         children: <Widget>[
  //           Stack(
  //             children: <Widget>[
  //               Container(
  //                 height: 150.0,
  //               ),
  //               Container(
  //                 height: 150.0,
  //                 decoration: BoxDecoration(
  //                   borderRadius: BorderRadius.only(
  //                     topLeft: Radius.circular(10),
  //                     topRight: Radius.circular(10),
  //                   ),
  //                   gradient: LinearGradient(
  //                       stops: [0.2, 4],
  //                       colors: [Color(0xFF0C375B), Color(0xFF176DB5)],
  //                       begin: Alignment.topRight,
  //                       end: Alignment.bottomLeft),
  //                 ),
  //               ),
  //               Align(
  //                     alignment: Alignment.center,
  //                     child: Padding(
  //                       padding: const EdgeInsets.only(top: 40),
  //                       child: Container(
  //                         height: 90,
  //                         width: 90,
  //                         padding: EdgeInsets.all(10.0),
  //                         decoration: BoxDecoration(
  //                           color: Colors.white,
  //                           borderRadius: BorderRadius.circular(45),
                            
  //                           // border: Border.all(
  //                           //   color: Colors.white,
  //                           //   style: BorderStyle.solid,
  //                           //   width: 2.0,
  //                           // ),
  //                           image: DecorationImage(
  //                             image: AssetImage("asset/img/logo.png"),
  //                             fit: BoxFit.cover,
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   ),
  //             ],
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.all(15.0),
  //             child: Text(
  //              "Do You want to Cancel This Order?",
  //               style: TextStyle(
  //                   color: Color(0xFF0C375B),
  //                   fontWeight: FontWeight.w700,
  //                   fontSize: 20.0,
  //                   fontFamily: 'Gilroy-light'),
  //             ),
  //           ),
  //           SizedBox(
  //             height: 25.0,
  //           ),
  //           Row(
  //             crossAxisAlignment: CrossAxisAlignment.center,
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               FlatButton(
  //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
  //                     onPressed: (){
  //                       Navigator.of(context).pop();
  //                     },
  //                     child: Text ( "No", style :TextStyle(
  //                 color: Color(0xFF0C375B),
  //                             fontWeight: FontWeight.w700,
  //                             fontSize: 12.0,
  //                             fontFamily: 'OpenSans'
  //               ),),),
  //               SizedBox(width: 20.0,),
  //               RaisedButton(
  //                 color:Color(0xFF0C375B),
  //                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
  //                 onPressed: () async{
  //                    String url = 'https://onesignal.com/api/v1/notifications';

  //   var contents = {
  //     "include_player_ids": [idNotif],
  //     "include_segments": ["Users Notif"],
  //     "excluded_segments": [],
  //     "contents": {"en": "Your Order was Cancelled. The Restaurant is Already Close. Thnak You"},
  //     "data": {
  //       "status":"fucker"
  //     },
  //     "headings": {"en": "WhereTo Rider"},
  //     "filter": [
  //       {"field": "tag", "key": "UR", "relation": "=", "value": "TRUE"},
  //     ],
  //     "app_id": "f5091806-1654-435d-8799-0cbd5fc49280"
  //   };
  //   Map<String, String> headers = {
  //     'Content-Type': 'application/json',
  //     'authorization': 'Basic MGM5OTlmNzgtYzdlMi00NjUyLWFlOGEtZDYxZDM5YTUwNjll'
  //   };
  //   var repo =
  //       await http.post(url, headers: headers, body: json.encode(contents));
  //       print(repo.body);
  //                   print("Order Cancel");
  //                   var reponse = await ApiCall().cancelOrder('/cancelOrder/$gettheID');
  //                 var body = json.decode(reponse.body);
  //                 print(body);
  //                  SharedPreferences localStorage = await SharedPreferences.getInstance();
  //                                       localStorage.remove('menuplustrans');
  //                                       localStorage.remove('playerIDS');
  //                 //  Navigator.of(context).pop();
  //                 Navigator.pushReplacement(context, 
  //                 new MaterialPageRoute(builder: (context)
  //                 => RiderProfile()
  //                 ));
  //                 _showDistictWarning("The Order is Cancelled and Already Notify the Customer.");
  //                     },   
                      
  //                 child: Text ( "Yes", style :TextStyle(
  //                 color: Colors.white,
  //                             fontWeight: FontWeight.w700,
  //                             fontSize: 12.0,
  //                             fontFamily: 'OpenSans'
  //               ),),),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   ),
  //       );
  //     },
  //   );
  



    
  // }
// void _showDistictWarning(String meesage) {

//     showDialog(
//       context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context) {
//         return Dialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           elevation: 0,
//           backgroundColor: Colors.transparent,
//           child:Container(
//       height: 300.0,
//       width: MediaQuery.of(context).size.width,
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(20), color: Colors.white),
//       child: SingleChildScrollView(
//         physics: AlwaysScrollableScrollPhysics(),
//         child: Column(
//           children: <Widget>[
//             Stack(
//               children: <Widget>[
//                 Container(
//                   height: 150.0,
//                 ),
//                 Container(
//                   height: 150.0,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10),
//                     ),
//                     gradient: LinearGradient(
//                         stops: [0.2, 4],
//                         colors: [Color(0xFF0C375B), Color(0xFF176DB5)],
//                         begin: Alignment.topRight,
//                         end: Alignment.bottomLeft),
//                   ),
//                 ),
//                 Align(
//                       alignment: Alignment.center,
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 40),
//                         child: Container(
//                           height: 90,
//                           width: 90,
//                           padding: EdgeInsets.all(10.0),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(45),
                            
//                             // border: Border.all(
//                             //   color: Colors.white,
//                             //   style: BorderStyle.solid,
//                             //   width: 2.0,
//                             // ),
//                             image: DecorationImage(
//                               image: AssetImage("asset/img/logo.png"),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//               ],
//             ),
//             Padding(
//               padding: const EdgeInsets.all(15.0),
//               child: Text(
//                 meesage,
//                 style: TextStyle(
//                     color: Color(0xFF0C375B),
//                     fontWeight: FontWeight.w700,
//                     fontSize: 20.0,
//                     fontFamily: 'Gilroy-light'),
//               ),
//             ),
//             SizedBox(
//               height: 25.0,
//             ),
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 RaisedButton(
//                   color: Color(0xFF0C375B),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(30.0)),
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: Text(
//                     "Ok",
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w700,
//                         fontSize: 12.0,
//                         fontFamily: 'OpenSans'),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     ),
//         );
//       },
//     );
//   }
//   void assign(String id, String idyours) async { 

//       bool checkthis = true;
//       var idyours = userData['id'].toString();
//       var data = {
//         "transactionId" : '${widget.getID}',
//         "riderId" :  idyours,
//       };

//       var response = await ApiCall().assignRiders(data, '/assignRider');
//       var body = json.decode(response.body);
//       if(body == true){
//         print("TRUE");
//         SharedPreferences localStore = await SharedPreferences.getInstance();
//         localStore.setBool("cuurentIdtrans", checkthis);
//         localStore.setString("menuplustrans", "${widget.getID}");
//       }else{
//         print("FALSE");
//       }


//   }
//   void xDilogAhow(context){

      

//       showDialog(context: context,
//       barrierDismissible: true,
//       builder: (BuildContext context){

//           return Dialog(
//              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20),
//       ),
//       elevation: 0,
//       backgroundColor: Colors.transparent,
//       child:Container(
//         height: 300.0,
//         width: MediaQuery.of(context).size.width,
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
//         color: Colors.white),
//         child: SingleChildScrollView(
//           physics: AlwaysScrollableScrollPhysics(),
//           child:
//          Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Stack(
//                   children: <Widget>[
//                     Container(
//                       height: 150.0,
//                     ),
//                     Container(
//                       height: 150.0,
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10),),
//                          gradient: LinearGradient(
//                               stops: [0.2,4],
//                               colors: 
//                               [
//                                 Color(0xFF0C375B),
//                                 Color(0xFF176DB5)
//                               ],
//                               begin: Alignment.topRight,
//                               end: Alignment.bottomLeft),),

//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: Padding(
//                         padding: const EdgeInsets.only(top: 40),
//                         child: Container(
//                           height: 90,
//                           width: 90,
//                           padding: EdgeInsets.all(10.0),
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(45),
                            
                    
//                             image: DecorationImage(
//                               image: AssetImage("asset/img/logo.png"),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: 10.0,),
//                 Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Text("Accept Transcation Orders?",
//                   style: TextStyle(
//                     color: Color(0xFF0C375B),
//                     fontWeight: FontWeight.w700,
//                     fontSize: 18.0,
//                     fontFamily: 'OpenSans'
//                   ),
                  
//                   ),),
//                   SizedBox(height: 25.0,),
//                   Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     FlatButton(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
//                       onPressed: (){
//                         Navigator.of(context).pop();
//                       },
//                       child: Text ( "No", style :TextStyle(
//                   color: Color(0xFF0C375B),
//                               fontWeight: FontWeight.w700,
//                               fontSize: 12.0,
//                               fontFamily: 'OpenSans'
//                 ),),),
//                 SizedBox(width: 20.0,),
//                 RaisedButton(
//                   color:Color(0xFF0C375B),
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
//                   onPressed: () async{

                
//       var riderId = userData['id'].toString();

//       var data = {
//         "transactionId" : "${widget.getID}",
//         "riderId" :  userData['id'] ,
//       };


//       var response = await ApiCall().assignRiders(data, '/assignRider');
//       var body = json.decode(response.body);
      
//       if(body == true){
        
//  SharedPreferences localStore = await SharedPreferences.getInstance();
//         localStore.setString("menuplustrans", "${widget.getID}");
//         localStore.setString("playerIDS", "${widget.playerId}");
//         setState(() {
//       available = !available;
//       menuHide = !menuHide;
//       backTF = !backTF;
//       cancelOrder = true;
//       riderCheck();
//       });
//       }else{
//           print(body);
//           _showDistictWarning("The Order Is Accepted by another Rider.");
//       }
        
     
//                    Navigator.of(context).pop();
//                       },   
                      
//                   child: Text ( "Yes", style :TextStyle(
//                   color: Colors.white,
//                               fontWeight: FontWeight.w700,
//                               fontSize: 12.0,
//                               fontFamily: 'OpenSans'
//                 ),),),
//                   ],
//                 ), 
//               ],
//           ),
//         ),
//       ),
//     ); 


//       });


//   }

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
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
        decoration: BoxDecoration(
          // color:  Colors.white
          border: Border.all(
            width: 1,
            color: pureblue,
          ),
          borderRadius: BorderRadius.all(Radius.circular(50)),
        ),
        child: Row(
          children: <Widget>[
            Icon(icon,color:pureblue),
            SizedBox(width: 20.0,),
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(label,
                style: TextStyle(
                  color:pureblue,
                  fontWeight: FontWeight.w700,
                  fontSize: 16.0,
                  fontFamily: 'Gilroy-light'
                ),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
class NCard1Button extends StatelessWidget {

  final bool active;
  final IconData icon;
  final String label;
  final Function onTap;
  final double  width;

  const NCard1Button({Key key, this.active, this.icon, this.label, this.onTap, this.width}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
        onTap: onTap,
      child: Container(
        height: 40.0,
        width: width,
        padding: EdgeInsets.symmetric(horizontal: 15,vertical: 7),
        decoration: BoxDecoration(
          color:  Color(0xFF0C375B),
          borderRadius: BorderRadius.circular(15.0)
        ),
        child: Row(
          children: <Widget>[
            Icon(icon,color: Colors.white),
            SizedBox(width: 3.0,),
               Text(label,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 8.0,
                  fontFamily: 'OpenSans'
                ),),
             
          ],
        ),
      ),
    );
  }
}
