import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';

class XviewTransac extends StatefulWidget {

                             final String  image;
                             final String deliveryAddress;
                             final String address;
                             final String restaurantName;
                             final String status ;
                             final Function onTap;

  const XviewTransac({Key key, this.image, this.deliveryAddress, this.address, this.restaurantName, this.status, this.onTap}) : super(key: key);


  @override
  _XviewTransacState createState() => _XviewTransacState();
}

class _XviewTransacState extends State<XviewTransac> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: widget.onTap,
        child: Container(
          height: 150,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
             gradient:  LinearGradient(
                              stops: [0.2,4],
                              colors: 
                              [
                                Color(0xFF0C375B),
                                Color(0xFF176DB5)
                              ],
                              begin: Alignment.bottomRight,
                              end: Alignment.topLeft),
            borderRadius: BorderRadius.all(Radius.circular(20),
            
            )
          ),
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  height: 60,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF176DB5),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(90),
                      bottomLeft: Radius.circular(90))
                  ),
                  child: Center(
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage(widget.image))
                      ),
                    )
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Container(
                  height: 150,
                  width: 140,
                  decoration: BoxDecoration(
                    color:  Color(0xFF0C375B),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                      topRight: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15,top: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(widget.restaurantName,
                        style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      letterSpacing: 1,
                      fontFamily: 'Gilroy-ExtraBold'
                    ),
                        ),
                        SizedBox(height: 8,),
                        Text(widget.address,
                        style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      letterSpacing: 1,
                      fontFamily: 'Gilroy-light'
                    ),
                        ),
                        SizedBox(height: 8,),
                        Text(widget.deliveryAddress,
                        style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      letterSpacing: 1,
                      fontFamily: 'Gilroy-light'
                    ),
                        ),
                        SizedBox(height: 8,),
                        Text(widget.status,
                        style: TextStyle(
                      color: Colors.white,
                      fontSize: 13.0,
                      letterSpacing: 1,
                      fontFamily: 'Gilroy-light'
                    ),
                        ),
                        
                      ],
                    ),
                    ),
                )
              ),
            ],
          ),
        ),
    );
  }
}