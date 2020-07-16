import 'dart:convert';

import 'package:WhereTo/Transaction/orderList.dart';
import 'package:WhereTo/Transaction/orders.dart';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/api_restaurant_bloc/computation.dart';
import 'package:WhereTo/api_restaurant_bloc/orderbloc.dart';
import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';



class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  @override
  void setState(fn) {
    super.setState(fn);
    
  }

  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: BlocConsumer<OrderBloc, List<TransactionOrders>>(buildWhen:
          (List<TransactionOrders> previous, List<TransactionOrders> current) {
        return true;
      }, listenWhen:
          (List<TransactionOrders> previous, List<TransactionOrders> current) {
        if (current.length > previous.length) {
          return true;
        }
        return false;
      }, builder: (context, snapshot) {
        return Stack(
          children: <Widget>[
           Padding(
             padding: EdgeInsets.only(bottom: 50),
             child:  ListView.builder(
                padding: EdgeInsets.all(20),
                itemCount: snapshot.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.all(10),
                    child: Stack(
                      children: <Widget>[
                        Card(
                          color: Colors.white70,
                          elevation: 15.6,
                          child: ListTile(
                            onLongPress: () {
                              BlocProvider.of<OrderBloc>(context)
                                  .add(Computation.delete(index));
                            },
                            title: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Text(snapshot[index].name),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(snapshot[index].description),
                                Text(
                                  "₱" + snapshot[index].price.toString(),
                                  style: GoogleFonts.roboto(
                                      color: Colors.blue,
                                      letterSpacing: 2,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            ),
                            trailing: Padding(
                              padding: EdgeInsets.only(top: 10),
                              child: Container(
                                width: 100,
                                child: Row(
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        if (snapshot[index].quantity > 0) {
                                          setState(() {
                                              snapshot[index].quantity =
                                                snapshot[index].quantity - 1;
                                                 print(
                                                ' ${snapshot[index].id.toString()} ${snapshot[index].quantity.toString()}');
                                            
                                           
                                          });
                                        }
                                      },
                                      child: Container(
                                        width: 30,
                                        child: Icon(
                                          Icons.remove_circle_outline,
                                          color: Colors.blue,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: 30,
                                      child: Center(
                                          child: Text(
                                        snapshot[index].quantity.toString(),
                                        style: TextStyle(fontSize: 15),
                                      )),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          snapshot[index].quantity =
                                              snapshot[index].quantity + 1;
                                           print(
                                                ' ${snapshot[index].id.toString()} ${snapshot[index].quantity.toString()}');
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.only(right: 5),
                                        width: 30,
                                        child: Icon(
                                          Icons.add_circle_outline,
                                          color: Colors.blue,
                                          size: 25,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
             ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: ArgonButton(
                  height: 50,
                  roundLoadingShape: false,
                  width: MediaQuery.of(context).size.width * 1.5,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                          child:
                            BlocConsumer<OrderBloc, List<TransactionOrders>>(
                            builder: (context, datasnapshot) {
                              int total = 0;
                             for(int z=0;z<datasnapshot.length;z++){
                              total+=snapshot[z].price*snapshot[z].quantity;
                              //  if(snapshot[z].quantity==0){
                              //    total+=snapshot[z].price*1;
                              //  }
                             }
                              return Text(
                              "Total: ${total.toString()}" ,
                              style: GoogleFonts.archivo(
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            );
                            },
                            listener: (BuildContext context, order) {
                                  // Scaffold.of(context).showSnackBar(
                                  // SnackBar(content: Text("Order Remove")));
                                },
                          ),
                        ),
                     
                      Padding(
                        padding: EdgeInsets.only(left : 150),
                        child: Text(
                        "Checkout" ,
                        style: GoogleFonts.archivo(
                            color: Colors.white,
                            letterSpacing: 2,
                            fontSize: 20,
                            fontWeight: FontWeight.w700),
                      ),
                      ),
                    ],
                  ),
                  loader: Text(
                    "Loading...",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                  color: Colors.blue,
                  onTap: (startLoading, stopLoading, btnState) async{
                  // var id;
                  // var quantity;
                  // Map<String, dynamic> string;
                  // Map<String, dynamic> post;
                  // List<dynamic> order =[];
                  // SharedPreferences localStorage = await SharedPreferences.getInstance();
                  // var userJson = localStorage.getString('user'); 
                  // var user = json.decode(userJson);
                  
                  //   snapshot.forEach((element)async { 
                  //     setState(() {
                  //       id=element.id;
                  //       quantity =element.quantity;
                  //       string ={
                  //       'menuId': '$id', 'quantity': '$quantity' 
                  //       };
                  //       order.add(string);
                  //     });
                      
                  //     });
                  //     // print(order);   
                  //     setState(() {
                  //       post ={
                  //         'userId': user['id'],
                  //          'order':order,
                  //         'optionalAddress': 'Davao'
                  //       };
                  //       // print(post);
                  //     });
                  //     var res =await ApiCall().postData(post, '/putOrder');
                  //     if(res.statusCode ==200){
                  //     print("Success");
                                   
                  //     }
                      
                        final query ="Penongs Quirante II, Tagum, Davao del Norte";
                        var addresses =await Geocoder.local.findAddressesFromQuery(query);
                        var first =addresses.first;
                        print("${first.featureName} ${first.coordinates}");
                     
                    

                  },
                ),
              ),
            ),
          ],
        );
      }, listener: (BuildContext context, orderList) {
        Scaffold.of(context).showSnackBar(
          SnackBar(content: Text("Order Remove")),
        );
      }),
    );
  }
  
}
