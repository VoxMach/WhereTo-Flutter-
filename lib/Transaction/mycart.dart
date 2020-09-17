
import 'package:WhereTo/Transaction/productTransaction.dart';
import 'package:flutter/material.dart';


class MyCart extends StatefulWidget {
  final String nameRestau;
  final String restauID;
  final double restoLat;
  final double restoLng;
  MyCart({this.nameRestau, this.restauID, this.restoLat, this.restoLng});
  @override
  _MyCartState createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async=> false,
          child: Scaffold(
        body: TransactionList(
            restoLat: widget.restoLat,
            restoLng: widget.restoLng,
            restauID: widget.restauID,
      ),
      ),
    );
  }
  
}
