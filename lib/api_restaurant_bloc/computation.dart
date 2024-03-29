import 'package:WhereTo/Transaction/orders.dart';
import 'package:flutter/foundation.dart';


enum EventType{add,delete,deleteAll,total, getAll}
enum GetType{getuserID}
class Computation {
TransactionOrders transactionOrders;
int index;
EventType eventType;
List<TransactionOrders> order;


Computation();

Computation.add(TransactionOrders transactionOrders){
  this.eventType =EventType.add;
  this.transactionOrders =transactionOrders;
}

Computation.delete(int index){
  this.eventType =EventType.delete;
  this.index =index;
}
Computation.deleteAll(){
  this.eventType =EventType.deleteAll;
}
Computation.total(){
  this.eventType =EventType.total;
}
Computation.getAll(){
  this.eventType =EventType.getAll;
}

}
class Userid{
UserID userID;
GetType eventType;

Userid();

Userid.getUser(UserID userID){
  this.eventType =GetType.getuserID;
  this.userID =userID;
}

}

class TransactionOrders{
  String name;
  String description;
  double price;
  int quantity;
  double total;
  int id;
  String image;
  TransactionOrders({this.name, this.description, this.price, this.quantity, this.total, this.id, this.image});
}
class UserID{
  String userID;
  UserID({this.userID});
}