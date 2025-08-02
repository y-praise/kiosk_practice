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
            onPressed: () {Navigator.pushNamed(context, '/yoon');}, 
            child: Text('주민센터 키오스크')
          ),
          SizedBox(height: 50,),
          ElevatedButton(
            onPressed: () {Navigator.pushNamed(context, '/jung');}, 
            child: Text('음식점 키오스크')
          ),
          SizedBox(height: 50,),
          ElevatedButton(
            onPressed: () {Navigator.pushNamed(context, '/hong');}, 
            child: Text('공항 키오스크')
          ),
          SizedBox(height: 50,),
          ElevatedButton(
            onPressed: () {Navigator.pushNamed(context, '/jang');}, 
            child: Text('테이블 키오스크')
          ),
        ],
            ),
      ),
    );
  }
}
