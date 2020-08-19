import 'dart:convert';

import 'package:WhereTo/Transaction/x_view.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'MyOrder/StatusStepper.dart';
import 'MyOrder/bloc.dart';
import 'MyOrder/getViewOrder.dart';

class MyNewViewOrder extends StatefulWidget {
  @override
  _MyNewViewOrderState createState() => _MyNewViewOrderState();
}

class _MyNewViewOrderState extends State<MyNewViewOrder> {

  var data;
  String transactID;
  String riderID;
  String status;
  String statusExist;
  String sunkist;
  bool isExist =false;
  BlocAll bloc;
  Future<void> getBloc(var id) async {
    await bloc.getMenuTransaction(id);
  }

  Future<void> disposeBloc() async {
    bloc.dispose();
  }

  var userData;

  @override
  void initState() {
    getData();
    super.initState();
    _getUserInfo();
  }
   getData() async{
     OneSignal.shared.setInFocusDisplayType(OSNotificationDisplayType.notification);
     OneSignal.shared.setNotificationReceivedHandler((OSNotification notification) {
        data =notification.payload.additionalData;
        setState(() {
          if(data!=null){
            print(data['transact_id'].toString());
            print(data['id'].toString());
            print(data['status'].toString());
            isExist =true;
            transactID =data['transact_id'].toString();
            riderID =data['id'].toString();
            status =data['status'].toString();
          }else{
            print("Error");
          }
        });
      });
  }

  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    setState(() {
      userData = user;
    });
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      bloc = BlocAll();
      getBloc(userData['id'].toString());  
    });
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Padding(
          //   padding: EdgeInsets.only(top: 40, left: 10, right: 10),
          //   child: Align(
          //     alignment: Alignment.topLeft,
          //     child: GestureDetector(
          //       onTap: (){
          //         Navigator.pop(context);
          //         disposeBloc();
          //       },
          //       child: Container(
          //         height: 50,
          //         width: 50,
          //         decoration: BoxDecoration(
          //           color: Color(0xFF0C375B),
          //           shape: BoxShape.circle
          //         ),
          //         child: Center(
          //           child: Icon(
          //             Icons.arrow_back_ios,
          //             color: Colors.white,
          //           ),
          //         ),
          //       ),
          //     )
          //   ),
          // ),
          Padding(
            padding: EdgeInsets.only(top: 55),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "My Orders",
                style: TextStyle(
                    fontSize: 36,
                    color: pureblue,
                    fontFamily: 'Gilroy-ExtraBold',
                    fontWeight: FontWeight.w500),

              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 70),
            child: xStreamAsshole(),
          ),
        ],
      ),
    );
  }

  Widget xStreamAsshole() {
    return StreamBuilder<List<ViewUserOrder>>(
      stream: bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data.length > 0) {
                      if(transactID.toString().contains(snapshot.data[index].id.toString())){
                        sunkist =status;
                      }else{
                        sunkist =snapshot.data[index].status.toString();
                      }
                      return  Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                               XviewTransac(
                                image:"asset/img/app.jpg",
                                deliveryAddress: snapshot.data[index].deliveryAddress,
                                address: snapshot.data[index].address,
                                restaurantName: snapshot.data[index].restaurantName,
                                status: sunkist =="0" ?snapshot.data[index].status.toString() :sunkist,
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return StepperStatus(status: sunkist,);
                                  }));
                                },
                              ),
                            ],
                          ),
                        
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              
            
            );
          } else {
            return Container();
          }
        } else {
          return _load();
        }
      },
    );
  }

  Widget _load() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 25.0,
            width: 25.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
              strokeWidth: 4.0,
            ),
          ),
        ],
      ),
    );
  }

 

 
}