import 'package:flutter/material.dart';
import 'language.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<Mainscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('공항 키오스크'),
        backgroundColor: Colors.indigo,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'),
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            //배경
            Container(
              margin: EdgeInsets.only(top: 40, left: 190),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Language()),
                  );
                },
                child: Image.asset("assets/images/airportA.png"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 125, left: 80),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Language()),
                  );
                },
                child: Image.asset("assets/images/airportB.png"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 140, left: 240),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Language()),
                  );
                },
                child: Image.asset("assets/images/airportC.png"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
