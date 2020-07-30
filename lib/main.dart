


import 'package:WhereTo/Transaction/MyOrder/bloc.dart';
import 'package:WhereTo/api_restaurant_bloc/orderbloc.dart';

import 'package:WhereTo/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'Transaction/MyOrder/bloc.provider.dart';
import 'api_restaurant_bloc/orderblocdelegate.dart';
void main() {
  BlocSupervisor.delegate =OrderBlocDelegate();
  runApp(MyApp());
}
class MyApp extends StatefulWidget {
  
  @override
  _MyAppState createState() => _MyAppState();
}
class _MyAppState extends State<MyApp> {
  // bool _isLoggedIn = false;

  @override
  void initState() {
    // _checkIfLoggedIn();
    super.initState();
  }

  // void _checkIfLoggedIn() async{
  //     // check if token is there
  //     SharedPreferences localStorage = await SharedPreferences.getInstance();
  //     var token = localStorage.getString('token');
  //     if(token!= null){
  //        setState(() {
  //           _isLoggedIn = true;
  //        });
  //     }
  // }

  @override
  Widget build(BuildContext context) {
    
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:(BuildContext context){
            return OrderBloc();
          } 
        ),
      ],
      
      child: MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home:Builder(builder: (context){
        return BlocProviders(
        bloc: BlocAll(),
        child: Scaffold(
         body: SplashScreen(),
        // body: _isLoggedIn ? Home() :  LoginPage(),
        ),
        );
      })
      
    ),
    );
  }
}