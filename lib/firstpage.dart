import 'package:flutter/material.dart';

class Firstpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
        children: [
          SizedBox(height: 100,),
          ElevatedButton(
            onPressed: () {Navigator.pushNamed(context, '/civil_service');}, 
            child: Text('주민센터 키오스크')
          ),
          SizedBox(height: 50,),
          ElevatedButton(
            onPressed: () {Navigator.pushNamed(context, '/food');}, 
            child: Text('음식점 키오스크')
          ),
          SizedBox(height: 50,),
          ElevatedButton(
            onPressed: () {Navigator.pushNamed(context, '/airport');}, 
            child: Text('공항 키오스크')
          ),
          SizedBox(height: 50,),
          ElevatedButton(
            onPressed: () {Navigator.pushNamed(context, '/table');}, 
            child: Text('테이블 키오스크')
          ),
        ],
            ),
      ),
    );
  }
}
