import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:WhereTo/api/api.dart';
import 'package:cloudinary_client/cloudinary_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as path;
import '../styletext.dart';

class ValidIds extends StatefulWidget {

  final String id;

  const ValidIds({Key key, this.id}) : super(key: key);

  @override
  _ValidIdsState createState() => _ValidIdsState();
}

class _ValidIdsState extends State<ValidIds> {

  var userData;
  final pick = ImagePicker();
   File _idPickerImage;
   String stringPath;
   var thimagelink;
   bool lace = false;
  @override
  void initState() {
    this._getUserInfo();
    lace = false;
    print(widget.id);
    super.initState();
  }

  void _getUserInfo() async {
      SharedPreferences localStorage = await SharedPreferences.getInstance();
      var userJson = localStorage.getString('user');

      var user = json.decode(userJson);
      setState(() {
        userData = user;
      });
  }
   
   getYourIdImage( ImageSource source) async{

    var imageIdValid = await pick.getImage(source: source); 
       File crop = await ImageCropper.cropImage(
      sourcePath: imageIdValid.path ,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      androidUiSettings: AndroidUiSettings(
          toolbarTitle: 'Where To Id Cropper',
          toolbarColor: pureblue,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false),
      iosUiSettings: IOSUiSettings(
        minimumAspectRatio: 1.0,
      ) );
    setState(() {
      _idPickerImage = crop;
      
      // print(imageIdValid.path);
    });
    

  }


  Widget _getImage(){

    if(_idPickerImage != null){

      return Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Container(
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.all(Radius.circular(10),
          ),
          ),
          child: Image.file(
              _idPickerImage,
              fit: BoxFit.cover,
          ),
        ),
      );
    }else{
        return Container(
          width: 80,
        height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white
          ),
          child: Center(
            child: Icon(
              Icons.person,
              size: 40,
              color: wheretoDark,
            ),
          ),
        );
    }

  }  

Widget loadingSpring() {

   return Container(
     height: MediaQuery.of(context).size.height,
     width: MediaQuery.of(context).size.width,
     child: Center(
        child: SpinKitCubeGrid(
          color: Colors.white,
          size: 80.0,
        )
     ),
   );


 }  
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10,sigmaY: 10),
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            height: 700,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 10,right: 10,top: 10),
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  child: 
                  lace ? loadingSpring() :
                  Column(
                   
                    children: <Widget>[
                       
                      _getImage(),
                      SizedBox(height: 15,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: 
                        [
                          //  Align(
                          //   alignment: Alignment.topLeft,
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(left: 70),
                          //     child: 
                              GestureDetector(
                                onTap: (){
                                  getYourIdImage(ImageSource.camera);
                                }, 
                                child: Container(
                                  height: 40,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                  ),
                                  child: Center(
                                   child: Text("Camera",
                                   style: TextStyle(
                                     fontFamily: 'Gilroy-light',
                                     fontWeight: FontWeight.bold,
                                     color: wheretoDark
                                   ),
                                   ),
                                  ),
                                ),
                              ),
                          //     ),
                          // ),
                          // Align(
                          //   alignment: Alignment.topRight,
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(right: 70),
                          //     child: 
                              GestureDetector(
                                onTap: (){
                                  getYourIdImage(ImageSource.gallery);
                                }, 
                                child: Container(
                                  height: 40,
                                  width: 90,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                  ),
                                  child: Center(
                                   child:Text("Gallery",
                                   style: TextStyle(
                                     fontFamily: 'Gilroy-light',
                                     fontWeight: FontWeight.bold,
                                     color: wheretoDark
                                   ),
                                   ),
                                  ),
                                ),
                              // ),
                              // ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: 35,),
                    GestureDetector(
                                onTap: () async{
                              
                              setState(() {
                                lace =true;
                              });

                               if(_idPickerImage == null){
                                  _showDistictWarning("Please Select your valid id. ");
                                  setState(() {
                                  lace = false;
                                });
                               }else{

                                 var viewthis = path.basename(_idPickerImage.path);
                              CloudinaryClient client = new CloudinaryClient(
                                "822285642732717",
                                "6k0dMMg3As30mPmjeWLeFL5-qQ4",
                                "amadpogi");
                              await client.uploadImage( _idPickerImage.path ,filename: "Valid ID/$viewthis") .then((result){
                                  stringPath = result.secure_url;
                                    print(stringPath);
                                    thimagelink = stringPath;
                                })
                                .catchError((error) => print("ERROR_CLOUDINARY::  $error"));

                                var dataAss =  {

                                  'userId': widget.id ,
                                  'imagePath':thimagelink

                                };

                                var valid = await ApiCall().updateImageValid(dataAss, '/updateVerification');
                                print(valid.body);  
                                Navigator.pop(context);
                                 _showDistictWarning("ID verification sent. This process takes several hours. In the meantime, you may browse on our services.");
                                // setState(() {
                                //   lace = false;
                                // });
                               }
                                }, 
                                child: Container(
                                  height: 40,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                  ),
                                  child: Center(
                                   child: Text("Send",
                                   style: TextStyle(
                                     color:wheretoDark,
                                     fontFamily: 'Gilroy-light'
                                   ),
                                   )
                                  ),
                                
                              ),
                              ),
                    SizedBox(height: 20,),
                    Container(
                      height: 250,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20,right: 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Please Read :",
                                      textAlign: TextAlign.justify,
                                      maxLines: 20,
                                      style: TextStyle(
                                        color: pureblue,
                                        fontFamily: 'Gilroy-ExtraBold',
                                        fontSize: 22.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                              Text('We highly encourage our users to get the Accounts Verified by submitting a Valid Id to fully enjoy our services. This is to avoid dummy accounts from flooding our system and avoid losses on scam orders. Upload a photo of your chosen valid ID. Verification takes several hours to process. You can still enjoy using our application  while waiting for the  verification. ',
                                      textAlign: TextAlign.justify,
                                      maxLines: 20,
                                      style: TextStyle(
                                        color: pureblue,
                                        fontFamily: 'Gilroy-light',
                                        fontSize: 12.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      
                    ),
                    ],
                  ),
                ),
              ),
          ),
        ),
      ),
    );
  }

  void _showDistictWarning(String meesage) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child:Container(
      height: 300.0,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.white),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Container(
                  height: 150.0,
                ),
                Container(
                  height: 150.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    gradient: LinearGradient(
                        stops: [0.2, 4],
                        colors: [Color(0xFF0C375B), Color(0xFF176DB5)],
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft),
                  ),
                ),
                Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Container(
                          height: 90,
                          width: 90,
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(45),
                            
                            // border: Border.all(
                            //   color: Colors.white,
                            //   style: BorderStyle.solid,
                            //   width: 2.0,
                            // ),
                            image: DecorationImage(
                              image: AssetImage("asset/img/logo.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Text(
                meesage,
                maxLines: 4,
                style: TextStyle(
                    color: Color(0xFF0C375B),
                    fontWeight: FontWeight.w700,
                    fontSize: 14.0,
                    fontFamily: 'Gilroy-light'),
              ),
            ),
            SizedBox(
              height: 25.0,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  color: Color(0xFF0C375B),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "OK",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 12.0,
                        fontFamily: 'OpenSans'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
        );
      },
    );
  }


}