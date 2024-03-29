import 'package:WhereTo/Admin/Rider_UnViewRemit/view_unremit.dart';
import 'package:WhereTo/Admin/Rider_UnViewRemit/view_unresponse.dart';
import 'package:WhereTo/Admin/Rider_viewRemit/view_remit.dart';
import 'package:WhereTo/Admin/Rider_viewRemit/view_responseRem.dart';
import 'package:WhereTo/Admin/User_Verification/user_getterres.dart';
import 'package:WhereTo/Admin/User_Verification/user_verifyclass.dart';
import 'package:WhereTo/api/api.dart';
import 'dart:convert';

import 'package:WhereTo/modules/OtherFeatures/Shared_pref/getpref.dart';
class UserApi{

Future<UserVerified> getUserUnVerified() async {
  try{
    var reponse = await ApiCall().getunverified('/getUnverifiedList');
    // var body = json.decode(reponse.body);
    // List<Unverified> unverified = [];
    // for(var body in body){
    //     Unverified unverifiedUser = Unverified(
    //     userId: body["userId"],
    //     name: body["name"],
    //     imagePath: body["imagePath"],
    //     );
    //     unverified.add(unverifiedUser);
    // }
    return UserVerified.fromJson( json.decode(reponse.body));
  }catch(stacktrace,error){
     print("Error Occurence. $error and $stacktrace" );
      return UserVerified.withError("$error");
  }
}
  Future<RemitResponse> getRemitImages() async {

    var id = UserGetPref().idSearch;

    try{
      var response = await ApiCall().getRemitImage('/viewRemittedList/$id');
      // var bodies = json.decode(response.body);
      // List<ViewRemit> viewRet = [];
      // for(var bodies in bodies){
      //   ViewRemit vr = ViewRemit(
      //  riderId: bodies["riderId"],
      //   name: bodies["name"],
      //   amount: bodies["amount"],
      //   imagePath: bodies["imagePath"],
      //   status: bodies["status"],
      //   createdAt: bodies["created_at"].toString(),
      //   );
      //   viewRet.add(vr);
      // }
      return RemitResponse.fromJson(json.decode(response.body));
    }catch(stacktrace,error){
  print("Error Occurence. $error and $stacktrace" );
      return RemitResponse.withError("$error");
    }
  }

  Future<UnRemitResponse> getUnRemitImages() async{
    var id = UserGetPref().idSearch;
    try{
        var response = await ApiCall().getRemitImage('/viewUnremittedList/$id');
      // var bodies = json.decode(response.body);
      // List<UnViewRemit> unviewRet = [];
      // for(var bodies in bodies){
      //   UnViewRemit vr = UnViewRemit(
      //  riderId: bodies["riderId"],
      //   name: bodies["name"],
      //   amount: bodies["amount"],
      //   imagePath: bodies["imagePath"],
      //   status: bodies["status"],
      //   createdAt: bodies["created_at"].toString(),
      //   );
      //   unviewRet.add(vr);
      // }
      return UnRemitResponse.fromJson(json.decode(response.body));
    }catch(stacktrace, error){
      print("Error Occurence. $error and $stacktrace" );
      return UnRemitResponse.withError("$error");
    }

  }


}