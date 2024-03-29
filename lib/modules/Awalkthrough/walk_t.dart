import 'package:WhereTo/modules/homepage.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:WhereTo/styletext.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class WalkThroughPage extends StatefulWidget {
  @override
  _WalkThroughPageState createState() => _WalkThroughPageState();
}

class _WalkThroughPageState extends State<WalkThroughPage> {

  final introKey = GlobalKey<IntroductionScreenState>();

  void _onEndEdge(context){
    Navigator.pushReplacement(context, 
    new MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  Widget _buildImage(String assetImage){

    return Align(
      child: Image.asset('asset/img/$assetImage.png',width: 350.0,),
      alignment: Alignment.bottomCenter,
    );

  }

  @override
  Widget build(BuildContext context) {

    const bodyStyle = TextStyle(fontSize: 19.0);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );
    return Scaffold(
        body: SafeArea(
          child: WillPopScope(
            child: Center(
              child: IntroductionScreen(
                key: introKey,
                pages: 
                [
                  PageViewModel(
                    title: "",
                    body: "No need to squek or squel, the prices are low and real.",
                    decoration: pageDecoration,
                    image: _buildImage('img1')
                  ),
                  PageViewModel(
                    title: "",
                    body: "Anything,Anytime,Anywhere",
                    decoration: pageDecoration,
                    image: _buildImage('img2')
                  ),
                  PageViewModel(
                    title: "",
                    body: "Proceeding with ease to buy with a little effort.",
                    decoration: pageDecoration,
                    image: _buildImage('img3')
                  ),
                ],
                onDone: () => _onEndEdge(context),
                showSkipButton: true,
                skipFlex: 0,
                nextFlex: 0,
                skip: const Text('Skip',style: TextStyle(fontFamily: 'Gilroy-light'),),
                next: const Icon(Icons.arrow_forward),
                done: const Text('Done',style: TextStyle(fontFamily: 'Gilroy-light'),),
                dotsFlex: 1,
                dotsDecorator: const DotsDecorator(
                  size: Size(10.0, 10.0),
                  color: Colors.amberAccent,
                  activeSize: Size(22.0, 22.0),
                  activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  activeColor: Color(0xFF0F75BB),
                ),
              ),
            ),
          onWillPop: () async => false),
        ),
    );
  }
}