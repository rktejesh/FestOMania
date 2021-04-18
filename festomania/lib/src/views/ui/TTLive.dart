import 'package:festomania/src/views/ui/EventPage.dart';
import 'package:festomania/src/views/utils/loading.dart';
import 'package:festomania/src/views/utils/search.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Live extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TTLive(),
    );
  }
}

class TTLive extends StatefulWidget {
  @override
  _TTLiveState createState() => _TTLiveState();
}

class _TTLiveState extends State<TTLive> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                              'Live',
                              style: TextStyle(
                                fontFamily: 'Alegreya',
                                fontSize: 27,
                                color: const Color(0xff3f4239),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Expanded(
                            child: SizedBox(
                              height: 200.0,
                              child: StreamBuilder(
                                stream: FirebaseFirestore.instance.collection('Events').snapshots(),
                                builder: (context, eventSnapshot) {
                                  return eventSnapshot.hasData
                                      ? ListView.builder(
                                      itemCount: eventSnapshot.data.docs.length,
                                      itemBuilder: (context, index) {
                                        DocumentSnapshot eventData =
                                        eventSnapshot.data.docs[index];
                                        return (eventData
                                            .data()['eventCategory']
                                            .toString() ==
                                            "Technical Talk Live")
                                            ? Container(
                                          padding: EdgeInsets.only(
                                              bottom: 20,
                                              left: 20,
                                              right: 20),
                                          height: 300,
                                          width: double.infinity,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              boxShadow: [
                                                BoxShadow(
                                                  color:
                                                  Color.fromRGBO(
                                                      149,
                                                      157,
                                                      165,
                                                      0.1),
                                                  offset:
                                                  Offset(0, 0),
                                                  blurRadius: 24,
                                                )
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                InkWell(
                                                  child: Container(
                                                    height: 200,
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color:
                                                          Color.fromRGBO(
                                                              149,
                                                              157,
                                                              165,
                                                              0.1),
                                                          offset:
                                                          Offset(0, 0),
                                                          blurRadius: 24,
                                                        )
                                                      ],
                                                      image: DecorationImage(
                                                          image: NetworkImage(
                                                              eventData
                                                                  .data()[
                                                              'imageLink']
                                                                  .toString()),
                                                          fit: BoxFit.fill),
                                                      borderRadius:
                                                      const BorderRadius
                                                          .only(
                                                        topRight:
                                                        Radius.circular(
                                                            15.0),
                                                        topLeft:
                                                        Radius.circular(
                                                            15.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    Navigator.of(context)
                                                        .push(
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              EventPage(eventData
                                                                  .reference.id),
                                                        ));
                                                  },
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(15.0),
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Color.fromRGBO(
                                                              149,
                                                              157,
                                                              165,
                                                              0.1),
                                                          offset: Offset(0, 0),
                                                          blurRadius: 24,
                                                        )
                                                      ],
                                                      borderRadius:
                                                      const BorderRadius
                                                          .only(
                                                        topRight:
                                                        Radius.circular(
                                                            15.0),
                                                        topLeft:
                                                        Radius.circular(
                                                            15.0),
                                                      ),
                                                    ),
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          children: [
                                                            Text(eventData
                                                                .data()[
                                                            'eventName']
                                                                .toString()),
                                                            Text(eventData
                                                                .data()[
                                                            'collegeName']
                                                                .toString()),
                                                          ],
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                        ),
                                                        TextButton(
                                                          onPressed: () {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                'Users')
                                                                .doc(FirebaseAuth
                                                                .instance
                                                                .currentUser
                                                                .uid)
                                                                .update({
                                                              "saved": FieldValue
                                                                  .arrayUnion([
                                                                eventData
                                                                    .reference
                                                                    .id
                                                              ])
                                                            });
                                                          },
                                                          child: Icon(
                                                            Icons.bookmark,
                                                            color: Colors.black,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                            : Container();
                                      })
                                      : Loading();
                                },
                              ),
                            )
                        )
                      ]
                  )
              ),
            ),
            SearchBar(searchBarTitle: "Live"),
          ],
        ),
      ),
    );
  }
}