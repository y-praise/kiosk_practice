import 'package:flutter/material.dart';
import 'caution.dart';

class Language extends StatefulWidget {
  const Language({super.key});

  @override
  State<Language> createState() => _LanguageState();
}

class _LanguageState extends State<Language> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('언어 선택'),
        backgroundColor: Colors.indigo,
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/language.png'),
                  fit: BoxFit.contain,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Container(
              width: 130,
              height: 100,
              margin: EdgeInsets.only(top: 30, left: 35),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Caution()),
                  );
                },
                child: Image.asset("assets/images/korean.png"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 350, left: 100),
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Text(
                '언어 중 한국어를 눌러주세요',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
