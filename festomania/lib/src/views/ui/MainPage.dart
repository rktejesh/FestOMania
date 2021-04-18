import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:festomania/src/views/utils/loading.dart';
import 'package:festomania/src/views/utils/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:festomania/src/views/utils/AppDrawer.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:festomania/src/views/utils/search.dart';
import 'package:festomania/src/views/ui/EventPage.dart';
import 'package:sliver_tools/sliver_tools.dart';

class MainPageUpcoming extends StatefulWidget {
  @override
  _MainPageUpcomingState createState() => _MainPageUpcomingState();
}

class _MainPageUpcomingState extends State<MainPageUpcoming>
    with SingleTickerProviderStateMixin {

  ScrollController _scrollController;
  TabController _tabController;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(
      keepScrollOffset: true,
      initialScrollOffset: 0,
    );
    _tabController = TabController(
      length: 3,
      vsync: this,
      initialIndex: 0,
    );
    setState(() {});
  }

  bool _visible = false;

  void onPressed() {
    setState(() {
      _visible = !_visible;
    });
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  double selected = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Theme(
        data: ThemeData(primaryColor: Colors.white),
        child: Scaffold(
          backgroundColor: Colors.white,
          drawer: AppDrawer(),
          body: Stack(
            fit: StackFit.expand,
            children: [
              NestedScrollView(
                controller: _scrollController,
                headerSliverBuilder: (context, value) {
                  return [
                    SliverAppBar(
                      floating: false,
                      pinned: false,
                      expandedHeight: 50,
                    ),
                    SliverAppBar(
                      leading: Container(),
                      expandedHeight: 250.0,
                      floating: false,
                      pinned: true,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Slideshow(),
                      ),
                    ),
                    SliverPinnedHeader(
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TabBar(
                            indicator: BubbleTabIndicator(
                              indicatorHeight: 45,
                              indicatorRadius: 10,
                              insets: EdgeInsets.only(left: 30, right: 30),
                              indicatorColor: Colors.black12,
                              tabBarIndicatorSize: TabBarIndicatorSize.tab,
                            ),
                            overlayColor:
                            MaterialStateProperty.all(Colors.transparent),
                            enableFeedback: true,
                            controller: _tabController,
                            tabs: [
                              Tab(
                                child: SvgPicture.string(
                                  bookmark,
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Tab(
                                child: Image.asset(
                                  "lib/src/assets/images/live.png",
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Tab(
                                child: Image.asset(
                                  "lib/src/assets/images/2496466-200.png",
                                  height: 25,
                                  width: 25,
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ],
                          ),
                        ),
                        color: Colors.white,
                      ),
                    ),
                  ];
                },
                body: Container(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      Container(
                        height: 300,
                      ),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Events')
                            .snapshots(),
                        builder: (context, eventSnapshot) {
                          return eventSnapshot.hasData
                              ? ListView.builder(
                              itemCount: eventSnapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot eventData =
                                eventSnapshot.data.docs[index];
                                return (eventData
                                    .data()['eventTiming']
                                    .toString() ==
                                    "Live")
                                    ? Container(
                                  padding: EdgeInsets.only(
                                      bottom: 20,
                                      left: 20,
                                      right: 20),
                                  height: 350,
                                  width: double.infinity,
                                  child: Container(
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
                      StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('Events')
                            .snapshots(),
                        builder: (context, eventSnapshot) {
                          return eventSnapshot.hasData
                              ? ListView.builder(
                              itemCount: eventSnapshot.data.docs.length,
                              itemBuilder: (context, index) {
                                DocumentSnapshot eventData =
                                eventSnapshot.data.docs[index];
                                return (eventData
                                    .data()['eventTiming']
                                    .toString() ==
                                    "Upcoming")
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
                    ],
                  ),
                ),
              ),
              SearchBar(
                searchBarTitle: "FestOMania",
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Slideshow extends StatefulWidget {
  @override
  _SlideshowState createState() => _SlideshowState();
}

class _SlideshowState extends State<Slideshow> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Swiper(
        loop: true,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Image.asset(
                SlideshowImages[index],
                fit: BoxFit.fill,
              ),
            ],
          );
        },
        itemCount: SlideshowImages.length,
        pagination: new SwiperPagination(
            margin: EdgeInsets.all(10), builder: SwiperPagination.dots),
        indicatorLayout: PageIndicatorLayout.SCALE,
        layout: SwiperLayout.DEFAULT,
        control: new SwiperControl(color: Colors.white60),
        autoplayDisableOnInteraction: true,
        autoplayDelay: 4000,
      ),
    );
  }
}

// _launchURL(int index) async =>
//    await canLaunch(SlideshowLinks[index]) ? await launch(SlideshowLinks[index]) : throw 'Could not launch $SlideshowLinks[index]';

const String bookmark =
    '<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0 24 24" width="24"><path d="M0 0h24v24H0V0z" fill="none"/><path d="M17 3H7c-1.1 0-2 .9-2 2v16l7-3 7 3V5c0-1.1-.9-2-2-2zm0 15l-5-2.18L7 18V5h10v13z"/></svg>';
