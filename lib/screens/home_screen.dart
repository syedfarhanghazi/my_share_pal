import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_share_pal/models/invite_model.dart';
import 'package:my_share_pal/models/ministry_model.dart';
import 'package:my_share_pal/screens/contacts_screen.dart';
import 'package:my_share_pal/screens/invite_screen.dart';
import 'package:my_share_pal/screens/profile.dart';
import 'package:my_share_pal/screens/settings_screen.dart';
import 'package:my_share_pal/styleguide/colors.dart';
import 'package:my_share_pal/styleguide/textstyles.dart';
import 'package:my_share_pal/utils/session_manager.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen() {
    screenTitle = "Dashboard";
    isLoaded = false;
    isMyMinistryLoad = false;

    list.clear();
    invitedByMe.clear();
    inMyMinistry.clear();
    ministryList.clear();
    allMinistryList.clear();

    parentsList.clear();

    parent = new Container();
    parent_ = new Container();
  }

  @override
  State<StatefulWidget> createState() {
    return HomeScreenState();
  }
}

SessionManager _sessionManager = SessionManager();

ImageProvider img;

String screenTitle = "Dashboard";

String drawerIcon = "images/menu.png";

class HomeScreenState extends State<HomeScreen> {

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    if (!isLoaded) {
      loadData();
    } else if (!isMyMinistryLoad) {
      loadMyMinistry();
    }

    if (screenTitle == "Dashboard") {
      drawerIcon = "images/menu.png";
    } else {
      drawerIcon = "images/arrow.png";
    }
    return new WillPopScope(
        onWillPop: onBackHandler,
        child: Scaffold(
          key: _scaffoldKey,
          drawer: SideDrawer(),
          body: SafeArea(
              child: Column(
            children: <Widget>[
              Container(
                  padding: EdgeInsets.only(
                      left: 16.0, right: 16.0, top: 16.0, bottom: 16.0),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                          onTap: () {
                            setState(() {
                              if (drawerIcon == "images/arrow.png") {
                                onBackHandler();
                              } else {
                                _scaffoldKey.currentState.openDrawer();
                              }
                            });
                          },
                          child: Image(
                            image: AssetImage(drawerIcon),
                            height: 24.0,
                            width: 24.0,
                          )),
                      Expanded(
                          child: Center(
                              child: Text(
                        screenTitle,
                        style: title,
                      )))
                    ],
                  )),
              Expanded(
                  child: Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.all(16.0),
                      child: DefaultTabController(
                          initialIndex: 0,
                          length: 2,
                          child: Scaffold(
                            appBar: new PreferredSize(
                                preferredSize: Size.fromHeight(kToolbarHeight),
                                child: new Container(
                                    child: new SafeArea(
                                  child: Column(
                                    children: <Widget>[
                                      new TabBar(
                                        //labelStyle: nearbyTabLabelSelected,
                                        labelColor: Color(0XFFFFFFFF),
                                        //unselectedLabelStyle: nearbyTabLabel,
                                        unselectedLabelColor: Color(0XFFA1A3A5),
                                        indicatorWeight: 4.0,
                                        indicatorColor: Color(0XFFCE57D0),
                                        labelPadding:
                                            EdgeInsets.only(bottom: 16.0),
                                        tabs: [
                                          Text(
                                            "Community",
                                          ),
                                          Text("My Ministries")
                                        ],
                                      ),
                                    ],
                                  ),
                                ))),
                            body: TabBarView(
                              children: [tab(), parent_],
                            ),
                          )))),
              Container(
                padding:
                    EdgeInsets.only(left: 16.0, right: 16, top: 12, bottom: 12),
                color: Color(0XFF383838),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    InkWell(
                        onTap: () {
                          onBackHandler();
                        },
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: ImageIcon(AssetImage("images/home.png"),
                                  color: Color(0XFFFFFFFF)),
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 8.0),
                                child: Text(
                                  "Home",
                                  style: bottomBarActive,
                                ))
                          ],
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ContactsScreen()));
                        },
                        child: Container(
                          height: 48.0,
                          child: Image(
                            image: AssetImage("images/chat.png"),
                            height: 24.0,
                          ),
                          decoration: BoxDecoration(
                              color: Color(0XFF2E8ECC), shape: BoxShape.circle),
                        )),
                    InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return SettingsScreen();
                          }));
                        },
                        child: Column(
                          children: <Widget>[
                            ImageIcon(
                              AssetImage("images/settings.png"),
                              color: Color(0XFFA1A3A5),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 8.0),
                              child: Text(
                                "Settings",
                                style: bottomBarInactive,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              )
            ],
          )),
        ));
  }

  Future<bool> onBackHandler() async {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => HomeScreen()),
    );
  }

  Widget tab() {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              gradient: myCommunityGradient),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      "MySharePal Community",
                      style: homeLabel,
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          list.length.toString(),
                          style: homeValues,
                        ),
                        Text(
                          list
                              .where((i) => i.decision == "accepted")
                              .toList()
                              .length
                              .toString(),
                          style: homeValues,
                        )
                      ],
                    ),
                  ))
                ],
              )),
              Container(
                color: Color(0XFF000000).withOpacity(0.15),
                height: 55.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Spirtual Convos",
                      style: homeSmall,
                    ),
                    Text(
                      "Accepted Christ",
                      style: homeSmall,
                    )
                  ],
                ),
              )
            ],
          ),
          height: 176.0,
        ),
        parent,
        Container(
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0), gradient: meGradient),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Me",
                          style: homeLabel,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => InviteScreen(_sessionManager.ministryID)));
                            },
                            child: Image(
                              image: AssetImage("images/open.png"),
                              height: 24.0,
                              width: 24.0,
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          invitedByMe.length.toString(),
                          style: homeValues,
                        ),
                        Text(
                          invitedByMe
                              .where((i) => i.decision == "accepted")
                              .length
                              .toString(),
                          style: homeValues,
                        )
                      ],
                    ),
                  ))
                ],
              )),
              Container(
                color: Color(0XFF000000).withOpacity(0.15),
                height: 55.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Spirtual Convos",
                      style: homeSmall,
                    ),
                    Text(
                      "Accepted Christ",
                      style: homeSmall,
                    )
                  ],
                ),
              )
            ],
          ),
          height: 176.0,
        )
      ],
    );
  }

  Future<void> loadData() async {
    await _sessionManager.load();
    Firestore.instance
        .collection("users")
        .getDocuments()
        .then((snapshots) {
      snapshots.documents.forEach((snapshot) {
        InviteModel model = InviteModel(
            snapshot.data['firstName'],
            snapshot.data['lastName'],
            snapshot.data['mobile'],
            snapshot.data['img'],
            snapshot.data['decision'],
            snapshot.data['invitedBy'],
            snapshot.data['ministryCode'],
            snapshot.data['answers']);
        list.add(model);
      });
      invitedByMe =
          list.where((i) => i.invitedBy == _sessionManager.id).toList();

      setState(() {
        isLoaded = true;
      });
    });
  }

  Future<void> loadMyMinistry() async {

    if (_sessionManager.ministryID != "") {

      await Firestore.instance
          .collection("ministries")
          .getDocuments()
          .then((snapshots) {
        snapshots.documents.forEach((snapshot) {
          MinistryModel ministryModel = MinistryModel(
              snapshot.data['name'], snapshot.data['parent'], snapshot['id']);

          allMinistryList.add(ministryModel);
          if (ministryModel.id == _sessionManager.ministryID) {
            ministryList.add(ministryModel);
          }
        });

        ministryList.addAll(ministryList
            .where((i) => i.parent == _sessionManager.ministryID)
            .toList());

        ministryList.forEach((f) {
          List<InviteModel> dummy =
              list.where((i) => i.ministryCode == f.id).toList();
          inMyMinistry.addAll(dummy);
        });


        List<InviteModel> myMinistry = myMinistryUsers(ministryList[0]);
        parent_ = ListView(
          children: <Widget>[
            InkWell(
                onTap: () {
                  loadSubMinistriesData(ministryList[0]);
                },
                child: Container(
                  margin: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: parentGradient),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  ministryList[0].name,
                                  style: homeLabel,
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InviteScreen(ministryList[0].id)));
                                    },
                                    child: Image(
                                      image: AssetImage("images/open.png"),
                                      height: 24.0,
                                      width: 24.0,
                                    ))
                              ],
                            ),
                          ),
                          Expanded(
                              child: Container(
                            margin: EdgeInsets.only(left: 16.0, right: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  myMinistry.length.toString(),
                                  style: homeValues,
                                ),
                                Text(
                                  myMinistry
                                      .where((i) => i.decision == "accepted")
                                      .toList()
                                      .length
                                      .toString(),
                                  style: homeValues,
                                )
                              ],
                            ),
                          ))
                        ],
                      )),
                      Container(
                        color: Color(0XFF000000).withOpacity(0.15),
                        height: 55.0,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              "Spirtual Convos",
                              style: homeSmall,
                            ),
                            Text(
                              "Accepted Christ",
                              style: homeSmall,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  height: 176.0,
                ))
          ],
        );
        parent = Container(
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              gradient: parentGradient),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          ministryList[0].name,
                          style: homeLabel,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => InviteScreen(ministryList[0].id)));
                            },
                            child: Image(
                              image: AssetImage("images/open.png"),
                              height: 24.0,
                              width: 24.0,
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          myMinistry.length.toString(),
                          style: homeValues,
                        ),
                        Text(
                          myMinistry
                              .where((i) => i.decision == "accepted")
                              .toList()
                              .length
                              .toString(),
                          style: homeValues,
                        )
                      ],
                    ),
                  ))
                ],
              )),
              Container(
                color: Color(0XFF000000).withOpacity(0.15),
                height: 55.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Spirtual Convos",
                      style: homeSmall,
                    ),
                    Text(
                      "Accepted Christ",
                      style: homeSmall,
                    )
                  ],
                ),
              )
            ],
          ),
          height: 176.0,
        );

        setState(() {
          isMyMinistryLoad = true;
        });
      });
    }
  }

  void loadSubMinistriesData(MinistryModel ministryModel) {
    parentsList = List();
    parentsList.clear();

    List<MinistryModel> tempList = List();

    tempList =
        allMinistryList.where((i) => i.parent == ministryModel.id).toList();

    if (tempList.length != 0) {
      tempList.forEach((f) {
        parentsList.add(widgetGenerator(f));
      });

      setState(() {
        screenTitle = ministryModel.name;
        parent_ = ListView(children: parentsList);
      });
    }
  }

  List<InviteModel> myMinistryUsers(MinistryModel ministry) {
    List<InviteModel> temp = List();

    List<MinistryModel> min = allMinistryList.where((i) => i.parent == ministry.id).toList();

    if (min.length > 0) {
      min.forEach((d) {
        temp.addAll(list.where((b) => b.ministryCode == d.id).toList());
        List<MinistryModel> t =
            allMinistryList.where((i) => i.parent == d.id).toList();

        if (t.length > 0) {
          t.forEach((e) {
            temp.addAll(list.where((c) => c.ministryCode == e.id).toList());

            List<MinistryModel> mo =
                allMinistryList.where((v) => v.parent == e.id).toList();

            if (mo.length > 0) {
              mo.forEach((u) {
                temp.addAll(list.where((m) => m.ministryCode == u.id).toList());

                List<MinistryModel> so =
                allMinistryList.where((x) => x.parent == u.id).toList();

                if(so.length>0){
                  so.forEach((z){
                    temp.addAll(list.where((a) => a.ministryCode == z.id).toList());
                  });
                }

              });
            }
          });
        }
      });
    } else {
      temp.addAll(list.where((a) => a.ministryCode == ministry.id).toList());
    }

    return temp;
  }

  Widget widgetGenerator(MinistryModel ministryModel) {
    List<InviteModel> tempList = myMinistryUsers(ministryModel);

    return new InkWell(
        onTap: () {
          loadSubMinistriesData(ministryModel);
        },
        child: Container(
          margin: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25.0),
              gradient: parentGradient),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          ministryModel.name,
                          style: homeLabel,
                        ),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => InviteScreen(ministryModel.id)));
                            },
                            child: Image(
                              image: AssetImage("images/open.png"),
                              height: 24.0,
                              width: 24.0,
                            ))
                      ],
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          tempList.length.toString(),
                          style: homeValues,
                        ),
                        Text(
                          tempList
                              .where((i) => i.decision == "accepted")
                              .toList()
                              .length
                              .toString(),
                          style: homeValues,
                        )
                      ],
                    ),
                  ))
                ],
              )),
              Container(
                color: Color(0XFF000000).withOpacity(0.15),
                height: 55.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Spirtual Convos",
                      style: homeSmall,
                    ),
                    Text(
                      "Accepted Christ",
                      style: homeSmall,
                    )
                  ],
                ),
              )
            ],
          ),
          height: 176.0,
        ));
  }


}

bool isLoaded = false;
bool isMyMinistryLoad = false;

List<InviteModel> list = List();
List<InviteModel> invitedByMe = List();
List<InviteModel> inMyMinistry = List();
List<MinistryModel> ministryList = List();
List<MinistryModel> allMinistryList = List();

List<Widget> parentsList = List();

Widget parent = new Container();
Widget parent_ = new Container();

class SideDrawer extends StatelessWidget {


  Future<void> search() async{

    img = AssetImage("images/circle.png");

    await _sessionManager.load();
    if (_sessionManager.img == "") {
      img = AssetImage("images/circle.png");
    } else {
      img = NetworkImage(_sessionManager.img);
    }
  }
  @override
  Widget build(BuildContext context) {
    search();
    return new SizedBox(
        width: MediaQuery.of(context).size.width * 0.85,
        child: Column(
          children: <Widget>[
            Container(
              height: 310.0,
              color: Color(0XFF333333),
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 88.0,
                    alignment: Alignment.center,
                    child: Stack(
                      children: <Widget>[
                        Container(
                          height: 88.0,
                          width: 88.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: img, fit: BoxFit.cover),
                              border:
                                  Border.all(width: 1.0, color: Colors.white)),
                        ),
                        Positioned(
                            child: InkWell(
                                onTap: () {
                                  Navigator.pop(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ProfileScreen();
                                  }));
                                },
                                child: Container(
                                    height: 34.0,
                                    width: 34.0,
                                    decoration: BoxDecoration(
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey,
                                            offset: Offset(0.0, 2),
                                            blurRadius: 2,
                                          )
                                        ],
                                        shape: BoxShape.circle,
                                        color: Color(0XFF30D158)),
                                    child: Image(
                                        image: AssetImage("images/edit.png")))),
                            top: 52)
                      ],
                    ),
                  ),
                  Container(
                    child: Text(
                      _sessionManager.name,
                      style: drawerName,
                    ),
                    margin: EdgeInsets.only(top: 16.0),
                  )
                ],
              ),
            ),
            Expanded(
                child: Container(
              padding: EdgeInsets.all(16.0),
              color: Color(0XFF2F2F2F),
              child: Column(
                children: <Widget>[
                  InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ProfileScreen();
                        }));
                      },
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ProfileScreen();
                            }));
                          },
                          child: Row(
                            children: <Widget>[
                              Image(
                                image: AssetImage("images/user_big.png"),
                                height: 24.0,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "PROFILE",
                                    style: bottomBarActive,
                                  ))
                            ],
                          ))),
                  Container(
                      margin: EdgeInsets.only(top: 16.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return ContactsScreen();
                            }));
                          },
                          child: Row(
                            children: <Widget>[
                              Image(
                                image: AssetImage("images/contact.png"),
                                height: 24.0,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "CONTACTS",
                                    style: bottomBarActive,
                                  ))
                            ],
                          )))
                ],
              ),
            )),
            Container(
              padding: EdgeInsets.all(16.0),
              color: Color(0XFF2F2F2F),
              child: Column(
                children: <Widget>[
                  Container(
                    height: 1.0,
                    color: Color(0XFF444444),
                    margin: EdgeInsets.only(left: 32.0, right: 32.0),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 16.0),
                      child: InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return SettingsScreen();
                            }));
                          },
                          child: Row(
                            children: <Widget>[
                              Image(
                                image: AssetImage("images/settings.png"),
                                height: 24.0,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "SETTINGS",
                                    style: bottomBarActive,
                                  ))
                            ],
                          ))),
                  Container(
                      margin: EdgeInsets.only(top: 16.0),
                      child: InkWell(
                          onTap: () {
                            _sessionManager.logout(context);
                          },
                          child: Row(
                            children: <Widget>[
                              Image(
                                image: AssetImage("images/contact.png"),
                                height: 24.0,
                              ),
                              Container(
                                  margin: EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "LOGOUT",
                                    style: bottomBarActive,
                                  ))
                            ],
                          )))
                ],
              ),
            )
          ],
        ));
  }
}
