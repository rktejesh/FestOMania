import 'package:festomania/src/views/utils/search.dart';
import 'package:festomania/src/views/ui/TTLive.dart';
import 'package:flutter/material.dart';
import 'package:festomania/src/views/ui/TTCollection.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TechnicalTalk(),
    );
  }
}

class TechnicalTalk extends StatefulWidget {
  @override
  _TechnicalTalkState createState() => _TechnicalTalkState();
}

class _TechnicalTalkState extends State<TechnicalTalk> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffedeff8),
      body: SafeArea(
        top: true,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: Text(
                              'Technical Talks',
                              style: TextStyle(
                                fontFamily: 'Alegreya',
                                fontSize: 27,
                                color: const Color(0xff3f4239),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(top: 30, bottom: 0, left: 60, right: 60),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(25.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(17, 17, 26, 0.1),
                                      offset: Offset(0, 0),
                                      blurRadius: 16,
                                    )
                                  ]
                              ),
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TTLive(),));
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.white),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25))),
                                ),
                                child: Text(
                                  'Live',
                                  style: TextStyle(
                                    fontFamily: 'Alegreya',
                                    fontSize: 21,
                                    color: const Color(0xff3f4239),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: Padding(
                            padding: EdgeInsets.only(top: 30, bottom: 0, left: 60, right: 60),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(25.0),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color.fromRGBO(17, 17, 26, 0.1),
                                      offset: Offset(0, 0),
                                      blurRadius: 16,
                                    )
                                  ]
                              ),
                              child: OutlinedButton(
                                onPressed: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => TTCollection(),));
                                },
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.white),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25))),
                                ),
                                child: Text(
                                  'Collection',
                                  style: TextStyle(
                                    fontFamily: 'Alegreya',
                                    fontSize: 21,
                                    color: const Color(0xff3f4239),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]
                  )
              ),
            ),
            SearchBar(searchBarTitle: "Technical Talks",
            )
          ],
        ),
      ),
    );
  }
}
