


import 'dart:convert';

import 'package:WhereTo/api/api.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_class.dart';
import 'package:WhereTo/restaurants/New_ViewRestaurant/neWrestaurant_response.dart';

class NewRestaurantApi {



  Future<NewRestaurantResponse> getFeaturedRestaurant() async {
      
    try{

        var response = await ApiCall().getRestarant('/getFeaturedRestaurant');
        List<NeWRestaurant> restaurantnew = [];

        var body = json.decode(response.body);
        for(var body in body){
            NeWRestaurant neWRestaurant = NeWRestaurant(
                id: body['id'],
                restaurantName: body['restaurantName'],
                address: body['address'],
                contactNumber: body['contactNumber'],
                openTime: body['openTime'],
                closingTime: body['closingTime'],
                closeOn: body['closeOn'],
                isFeatured: body['isFeatured'],
                status: body['status']

            );
            restaurantnew.add(neWRestaurant);
        }

        return NewRestaurantResponse.fromJson(restaurantnew);  
        
    }catch(error,stacktrace){
          print("Error Occurence. $error and $stacktrace" );
          return NewRestaurantResponse.withError("$error");
    }
  }

}