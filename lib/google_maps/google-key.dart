import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:permission/permission.dart';

import 'package:shared_preferences/shared_preferences.dart';

class ID {
  String googleKey = "AIzaSyCdnmS1dtMXFTu5JHnJluRmEyyRU-sPZFk";
  Future<String> getId() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString('user');
    var user = json.decode(userJson);
    return user['id'].toString();
  }
  Future<LatLng> getCoordinates() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    double lat = localStorage.getDouble('latitude');
    double lng = localStorage.getDouble('longitude');
    LatLng latlng = new LatLng(lat,lng);
    return latlng;
  }
  Future<double> getLat() async{
     Position postion =await getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
     double coor =postion.latitude;
     return coor;
  }
  Future<double> getLng() async{
    Position postion =await getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    double coor =postion.longitude;
    return coor;
  }

  Future<bool> permissions() async{
    var permissions =await Permission.getPermissionsStatus([PermissionName.Location]);
    if(permissions[0].permissionStatus ==PermissionStatus.deny || permissions[0].permissionStatus ==PermissionStatus.notAgain){
      await Permission.requestPermissions([PermissionName.Location]);
      return true;
    }else{
      return false;
    }
  }
  Future<String> getPosition()async{
    // var permissions =await Permission.getPermissionsStatus([PermissionName.Location]);
    // if(permissions[0].permissionStatus ==PermissionStatus.deny || permissions[0].permissionStatus ==PermissionStatus.notAgain){
    //   await Permission.requestPermissions([PermissionName.Location]);
    //   return "ass";
    // }else{
    //   Position postion =await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    //   String coor ="${postion.latitude},${postion.longitude}";
    //   return coor.toString();
    // }
  Position postion =await getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);
  String coor ="${postion.latitude},${postion.longitude}";
  return coor.toString();
  }
  
 
  
}
