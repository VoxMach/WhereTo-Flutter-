import 'package:WhereTo/Rider_viewTransac/view_Transac.dart';
import 'package:WhereTo/Transaction/Data/response.dart';
import 'package:WhereTo/Transaction/MyOrder/getViewOrder.dart';
import 'package:WhereTo/designbuttons.dart';
import 'package:flutter/material.dart';

import 'MyOrder/bloc.dart';

class MyOrder extends StatefulWidget {
  @override
  _MyOrderState createState() => _MyOrderState();
}

class _MyOrderState extends State<MyOrder> {
  BlocAll bloc = BlocAll();
  var id ="1";

  Future<void> getBloc(var id) async {
    await bloc.getMenuTransaction(id);
  }

  Future<void> disposeBloc() async {
    bloc.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getBloc(id);

    return Scaffold(
      backgroundColor: Color(0xFF398AE5),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 40, left: 10, right: 10),
            child: Align(
              alignment: Alignment.topLeft,
              child: DesignButton(
                height: 55,
                width: 55,
                color: Color(0xFF398AE5),
                offblackBlue: Offset(-4, -4),
                offsetBlue: Offset(4, 4),
                blurlevel: 4.0,
                icon: Icons.arrow_back,
                iconSize: 30.0,
                onTap: () {
                  Navigator.pop(context);
                  disposeBloc();
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 55),
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                "My Orders",
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 90),
            child: xStreamAsshole(),
          ),
        ],
      ),
    );
  }

  Widget xStreamAsshole() {
    return StreamBuilder<List<GetViewOrders>>(
      stream: bloc.stream,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            return SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    if (snapshot.data.length > 0) {
                      return Column(
                        children: [
                          ViewTransacRider(
                          image: "asset/img/app.jpg",
                          address: snapshot.data[index].address,
                          deliveryAddress: snapshot.data[index].deliveryAddress,
                          restaurantName: snapshot.data[index].restaurantName,
                          onTap: () async {

                          },
                      ),
                        ],
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
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
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 4.0,
            ),
          ),
        ],
      ),
    );
  }

 

 
}
