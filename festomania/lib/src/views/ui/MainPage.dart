import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_swiper_null_safety/flutter_swiper_null_safety.dart';
import 'package:bubble_tab_indicator/bubble_tab_indicator.dart';
import 'package:sliver_tools/sliver_tools.dart';
import 'config.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
        data: ThemeData(
          primaryColor: Colors.white
        ),
        child: Scaffold(
          backgroundColor: Colors.white ,
          body: NestedScrollView(
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
                  StreamBuilder(
                    stream:
                    FirebaseFirestore.instance.collection('Events').snapshots(),
                    builder: (context, eventSnapshot) {
                      return eventSnapshot.hasData
                          ? ListView.builder(
                          itemCount: eventSnapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            DocumentSnapshot eventData =
                            eventSnapshot.data.docs[index];
                              return (eventData.data()['eventCategory'].toString()=="Live") ?
                              Container(
                                padding:
                                EdgeInsets.only(bottom: 20, left: 20, right: 20),
                                height: 240,
                                width: double.infinity,
                                child: Column(
                                  children: [
                                    InkWell(
                                      child: SizedBox(
                                        height: 100,
                                        width: double.infinity,
                                      ),
                                      onTap: () {
                                      },
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Column(
                                            children: [
                                              Text(eventData.data()['eventName'].toString()),
                                              Text(eventData.data()['collegeName'].toString()),
                                            ],
                                          ),
                                          TextButton(onPressed: () {
                                            FirebaseFirestore.instance.collection('Users').doc(FirebaseAuth.instance.currentUser.uid).update({"saved": FieldValue.arrayUnion([eventData.reference.id])});
                                          },
                                          child: Text('bookmark'),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ):Container();
                          })
                          : CircularProgressIndicator();
                    },
                  ),
                  ListView.builder(
                    itemCount: LiveEventImages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding:
                            EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        height: 240,
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(LiveEventImages[index]),
                                fit: BoxFit.fill),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  ListView.builder(
                    itemCount: UpcomingEventImages.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                        padding:
                            EdgeInsets.only(bottom: 20, left: 20, right: 20),
                        height: 240,
                        width: double.infinity,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(UpcomingEventImages[index]),
                                fit: BoxFit.fill),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(15.0),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
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
