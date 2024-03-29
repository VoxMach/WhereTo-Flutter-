
import 'dart:convert';
import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/restaurants/restaurant.dart';
import 'package:WhereTo/xtra/restaurant_response.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RestaurantApi {

 List<Restaurant> _rest = List<Restaurant>();
  
  Future<List<RestaurantResponse>> getRestaurants() async {
  
    //  String url = 'http://10.0.2.2:8000/api/getFeaturedRestaurant';
      try{

      final response = await ApiCall().getRestarant('/getFeaturedRestaurant');
      var data =jsonDecode(response.body) as List;
      return data.map((e) => RestaurantResponse.fromJson(e)).toList();
       
        

        // var uri = Uri.https("http://10.0.2.2:8000", "/api/getFeaturedRestaurant",params);
        // var uis = await http.get(uri,headers: _setHeaders());
        // return RestaurantResponse.fromJson(json.decode(uis.body));
   
      }catch(error,stacktrace){
          print("Error Occurence. $error and $stacktrace" );
         
      }
  }



}

