import 'package:flutter/material.dart';

Container loader(){
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.only(top:10),
    child: CircularProgressIndicator(backgroundColor: Colors.greenAccent),
  );
}