import 'dart:convert';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/modules/login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../styletext.dart';
import 'homepage.dart';


class SignupPage extends StatefulWidget{
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage>{
  
  final formkey = GlobalKey<FormState>();
    final TextEditingController fulname  = TextEditingController();
     TextEditingController ownNumber = TextEditingController();
      TextEditingController ownAddress =  TextEditingController();
      TextEditingController ownpass = TextEditingController();
      TextEditingController ownconpass =TextEditingController();

        bool loading = false;

        phoneValidate(String val){

          Pattern pattern = r'^([+0]9)?[0-9]{10,11}$';
          RegExp regExp = new RegExp(pattern);
          if (val.length == 0 ){
            return 'Please enter your number';
          }else if (val.length < 11){
            return 'Mobile Number Consist of 11 Digits';
          }
          else if(!regExp.hasMatch(val)){
            return 'Enter A Valid Contact Number';
          }
          else{
            return null;
          }

    }   


      Widget _formRegister(BuildContext context){

            return Form(
              key: formkey,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  textDirection: TextDirection.ltr,
                  children: <Widget>[
                     Text('Full Name',
                    style: eLabelStyle,
                    ),
                    SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                controller: fulname,
                validator: (val) => val.isEmpty ? ' Please Put Your Full Name' : null,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                  hintText: 'Full Name',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
                SizedBox(height: 15.0,),
                 Text('Address',
                    style: eLabelStyle,
                    ),
                    SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                controller: ownAddress,
                validator: (val) => val.isEmpty ? ' Please Put Your Address' : null,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.my_location,
                    color: Colors.white,
                  ),
                  hintText: 'Address',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
             SizedBox(height: 15.0,),
                 Text('Password',
                    style: eLabelStyle,
                    ),
                    SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                controller: ownpass,
                validator: (input) => ownpass.text.length < 8 ?  'Password to Short' : null,
                obscureText: true,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  hintText: '********',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            SizedBox(height: 15.0,),
                 Text('Confirm Password',
                    style: eLabelStyle,
                    ),
                    SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
                controller: ownconpass,
                validator:(val){
                      if(val.isEmpty){
                        return "Empty";
                      }if(val != ownpass.text){
                        return "Password not Match";
                      }
                      return null;
                    },
                obscureText: true,
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.lock,
                    color: Colors.white,
                  ),
                  hintText: '********',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
             SizedBox(height: 15.0,),
                 Text('Contact Number',
                    style: eLabelStyle,
                    ),
                    SizedBox(height: 10.0,),
                    Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              decoration: eBoxDecorationStyle,
              height: 50.0,
              child: TextFormField(
              keyboardType: TextInputType.number,
                controller: ownNumber,
                validator: (val)=> phoneValidate(ownNumber.text = val),
                    onSaved: (val) => ownNumber.text = val,
                    
                
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.only(top:14.0),
                  prefixIcon: Icon(
                    Icons.phone_android,
                    color: Colors.white,
                  ),
                  hintText: '09**********',
                  hintStyle: eHintStyle,
                ),
              ),
            ),
            SizedBox(height: 20.0,),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 25.0),
                child: RaisedButton(
                  onPressed: (){
                    _signingIn();
                  },
                  elevation: 5.0,
                  padding: EdgeInsets.all(8.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.white,
                  child: Text(  loading ? 'Loading....' : 'Register',
                  style: TextStyle(
                    color: Color(0xFF527DAA),
                    letterSpacing: 1.5,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),),
                  ),
              ),


                  ],
                ),
              ),
            );


        }  
 Widget _botDownSignIn(){
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context){
                                        return LoginPage();
                                      }));
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Have an Account? ',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign In',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Container(
        height: MediaQuery.of(context).size.height,
         width: MediaQuery.of(context).size.width,
         decoration: BoxDecoration(
                    color: Color(0xFF398AE5),
                  ),
                  child: SafeArea(
                    child: SingleChildScrollView(
                       physics: AlwaysScrollableScrollPhysics(),
                     padding: EdgeInsets.symmetric(
                       horizontal: 40.0,
                       vertical: 80.0,
                     ),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: <Widget>[
                          Text(
                            'Sign Up',
                            style: TextStyle(
                              color: Colors.white,
                              fontFamily: 'OpenSans',
                              fontSize: 30.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 25.0,),
                          _formRegister(context),
                          SizedBox(height: 25.0,),
                          _botDownSignIn(),
                       ],
                     ),
                    ),
                    ),
     ),
    );
  }

void _signingIn() async {

  setState(() {
    loading = true;
  });

  if(formkey.currentState.validate()){
      formkey.currentState.save();
      var data = {
        'name' : fulname.text,
        'contactNumber' : ownNumber.text,
        'address' : ownAddress.text,
        'password' : ownpass.text 
            };
      var res = await ApiCall().postData(data,'/register');

     if(res.statusCode == 200){
     var body = json.decode(res.body);
      if(body['success']){
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      localStorage.setString('token', body['token']);
      localStorage.setString('user', json.encode(body['user']));
       Navigator.pushReplacement(
        context,
        new MaterialPageRoute(
            builder: (context) => Home()));
    }else{
      _showDial();
      throw Exception('Failed to Save');
    } 
  }else{
     _showDial();
    throw Exception('Failed to Save');  
        }

    


  }

  setState(() {
    loading = false;
  });


}

void _showDial(){
  showDialog(
    context: context,
    builder: (BuildContext context){
      return AlertDialog(
          title: Text("Contant Number Already Exist."),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          actions: <Widget>[
                FlatButton(onPressed: () => Navigator.of(context).pop(),
                child: const Text("OK",textAlign: TextAlign.center,),),
              ],
           
        );
    },);
}

}
