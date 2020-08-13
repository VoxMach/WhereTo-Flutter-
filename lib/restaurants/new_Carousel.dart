import 'package:flutter/material.dart';

class NewCarousel extends StatefulWidget {
  @override
  _NewCarouselState createState() => _NewCarouselState();
}

  


class _NewCarouselState extends State<NewCarousel> {

  final List<List<String>> restau = [

    [
      // 'asset/img/carousel1.jpg',
      'asset/img/61338547_p0.png',
      'KFC',
      'Located at GMALL of TAGUM'
    ],
    [
      // 'asset/img/carousel2.jpg',
      'asset/img/62512004_p0.png',
      'Jollibee',
      'Located at National HighWay'
    ],
    [
      // 'asset/img/carousel3.jpg',
      'asset/img/76134055_p0.png',
      'McDonalds',
      'Located at Rizal Street'
    ],
    [
      // 'asset/img/carousel4.jpg',
      'asset/img/fbmYkDz.jpg',
      'Chowking',
      'Located at National HighWay'
    ],
    [
      // 'asset/img/carousel5.jpg',
      'asset/img/mWWsAhL.jpg',
      'Penongs',
      'Located at Lapu-Lapu Street'
    ],

  ];

  int currentIndex = 0;
  
  void next(){
    setState(() {
      if(currentIndex < restau.length -1){
        currentIndex++;
      }else{
        currentIndex = currentIndex;
      }
    });
  }
  void back(){
    setState(() {
      if(currentIndex > 0 ){
        currentIndex--;
      }else{
        currentIndex = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50)
                )
      ),
      child: Column(
        children: <Widget>[
          GestureDetector(
            onHorizontalDragEnd: (DragEndDetails details){
              if(details.velocity.pixelsPerSecond.dx > 0){
                next();
              }else if(details.velocity.pixelsPerSecond.dx < 0){
                back();
              }
            } ,
              child: Container(
              height: 400,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(restau[currentIndex][0]),
                  fit:  BoxFit.cover),
                  
              ),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomRight,
                    colors: [
                      Color(0xFF0C375B).withOpacity(.9),
                      Colors.grey.withOpacity(.0)
                    ])
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      width: 90,
                      margin: EdgeInsets.only(bottom: 60),
                      child: Row(
                        children: buildindicators(),
                      ),
                    ),
                  ],
                ),
              ),
          ),
            
          ),
           Padding(
             padding: const EdgeInsets.only(left: 20,right: 20),
             child: Transform.translate(
                offset: Offset(0, -40),
                  child: Container(
                    height: 150,
                    decoration: BoxDecoration(
                      // color: Color(0xFFF2F2F2),
                      color: Color(0xFF0C375B),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                        bottomRight: Radius.circular(40),
                        bottomLeft: Radius.circular(40)
                      )
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10 ,right: 10,top: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                         mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                        Text(restau[currentIndex][1],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy-ExtraBold',
                              letterSpacing: 1,
                            ),
                            ),
                          
                          SizedBox(height: 5,),
                          Row(
                            children: <Widget>[
                               Icon(Icons.add_location,color: Colors.white,size: 15.0,),
                              SizedBox(width: 7.0,),
                              Flexible(
                                child: Text(restau[currentIndex][2],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Gilroy-light',
                            letterSpacing: 1,
                          ),
                          ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: Text("Reviews",
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 10,
                                   fontFamily: 'Gilroy-light'
                                 ),),
                              ),
                               SizedBox(width:5,),
                              Icon(Icons.star, size: 18, color: Colors.yellow[700],),
                              Icon(Icons.star, size: 18, color: Colors.yellow[700],),
                              Icon(Icons.star, size: 18, color: Colors.yellow[700],),
                              Icon(Icons.star, size: 18, color: Colors.yellow[700],),
                              Icon(Icons.star_half, size: 18, color: Colors.yellow[700],),
                               SizedBox(width:5,),
                               Flexible(
                                 child: Text("4.5/5",
                                 style: TextStyle(
                                   color: Colors.white,
                                   fontSize: 10,
                                   fontFamily: 'Gilroy-light'
                                 ),),
                               )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                
                ),
           )
          

        ],
      ),
    );
  }

  Widget indicators(bool isture){

    return Flexible(
      child: Container(
        height: 4,
        margin: EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          color: isture ?  Colors.amber: Colors.white
        ),
      ),
    );

  }

  List<Widget> buildindicators(){

    List<Widget> indicato = [];

    for(int i = 0 ;  i <restau.length; i++){
      if(currentIndex == i){
        indicato.add(indicators(true));
      }else{
        indicato.add(indicators(false));
      }
    }

    return indicato;

  }

}