import 'package:WhereTo/Admin/A_RiderRet/riderApi_Rets.dart';
import 'package:WhereTo/Admin/A_RiderRet/rider_provider.dart';
import 'package:WhereTo/Admin/A_RiderRet/rider_responseRet.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class RetrievStream {

 final RiderProvider riderProvider = RiderProvider();
  final BehaviorSubject<RetrievResponse> _subject = BehaviorSubject<RetrievResponse>();

  getRetieveTransac() async{
    RetrievResponse riderresponse = await riderProvider.getAllTransAll();
    _subject.sink.add(riderresponse);
  }

  void drainStream(){_subject.value = null;}
@mustCallSuper
  void dispose() async{
    
    await _subject.drain();
    _subject.close();
  }
  BehaviorSubject<RetrievResponse> get subject => _subject;

}

final retriveStream  = RetrievStream();