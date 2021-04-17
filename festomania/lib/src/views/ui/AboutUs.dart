import 'package:festomania/src/views/utils/search.dart';
import 'package:flutter/material.dart';

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
      home: AboutUs(),
    );
  }
}

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffedeff8),
      body: SafeArea(
        top: true,
        child: Stack(
            children: [
              Padding(
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
                              'About Us',
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
                            padding: EdgeInsets.only(top: 30, bottom: 0, left: 10, right: 10),
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
                                style: ButtonStyle(
                                  padding: MaterialStateProperty.all(EdgeInsets.all(25)),
                                  backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.white),
                                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25))),
                                ),
                                child: Text(
                                  'Fest-o-mania is an application, used by programmers and developers to view '
                                      'all the latest coding contests, hackathons, CTFs and technical talks conducted by '
                                      'IITs, NITs and IIITs of India at a single place.\n'
                                      '\n'
                                      'This app aims to promote programming, development and competitive skills among youth.\n'
                                      '\n'
                                      'It automatically updates all the events according to its schedule which will not let you miss any of the tech event.\n'
                                      '\n'
                                      'Also, It helps colleges in promoting their tech events across the nation.',
                                  style: TextStyle(
                                    fontFamily: 'Alegreya',
                                    fontSize: 16,
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
              SearchBar(searchBarTitle: "About us"),
            ]
        ),
      ),
    );
  }
}

