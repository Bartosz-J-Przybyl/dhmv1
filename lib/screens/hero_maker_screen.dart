import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dhmv1/screens/create_hero_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

class HeroMakerScreen extends StatefulWidget {
  const HeroMakerScreen({super.key});

  @override
  State<HeroMakerScreen> createState() => _HeroMakerScreenState();
}

class _HeroMakerScreenState extends State<HeroMakerScreen> {
  final fireStream =
      FirebaseFirestore.instance.collection("heromaker").snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: RippleAnimation(
        color: const Color.fromARGB(255, 3, 116, 104),
        delay: const Duration(milliseconds: 300),
        repeat: true,
        minRadius: 30,
        ripplesCount: 6,
        duration: const Duration(milliseconds: 6 * 700),
        child: FloatingActionButton(
          shape: const CircleBorder(),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateHerocreen(
                    title: "",
                    onSave: () {
                      return const HeroMakerScreen();
                    },
                  ),
                ));
          },
          backgroundColor: const Color.fromARGB(255, 3, 116, 104),
          foregroundColor: Colors.white,
          splashColor: Theme.of(context).primaryColorDark,
          child: const Icon(Icons.add),
        ),
      ),
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              const Color.fromARGB(255, 3, 116, 104),
              Theme.of(context).primaryColorDark
            ],
          )),
        ),
        title: (const Text(
          "Your Dungeon Heroes",
        )),
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Image.asset("lib/assets/images/d20.png"),
            tooltip: 'Show Snackbar',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.only(bottom: 100.0),
                duration: const Duration(seconds: 1),
                content: const Text(
                  'This is a Your Dungeon Heroes Page',
                  textAlign: TextAlign.center,
                  selectionColor: Colors.black,
                ),
                backgroundColor: Theme.of(context).colorScheme.primary,
              ));
            },
          ),
        ],
        backgroundColor: const Color.fromARGB(255, 50, 58, 60),
      ),
      drawer: const Drawer(),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: fireStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text("Loading"));
          }

          final documents = snapshot.data!.docs;

          return ShaderMask(
            shaderCallback: (Rect rect) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.purple,
                  Colors.transparent,
                  Colors.transparent,
                  Colors.purple
                ],
                stops: [0.0, 0.1, 0.9, 1.0],
              ).createShader(rect);
            },
            blendMode: BlendMode.dstOut,
            child: ListView.builder(
              itemCount: documents.length,
              itemBuilder: (BuildContext ctx, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    duration: const Duration(milliseconds: 950),
                    curve: Curves.fastLinearToSlowEaseIn,
                    horizontalOffset: 30,
                    verticalOffset: 300.0,
                    child: FlipAnimation(
                      duration: const Duration(milliseconds: 900),
                      curve: Curves.fastLinearToSlowEaseIn,
                      flipAxis: FlipAxis.y,
                      child: Dismissible(
                        key: ValueKey(documents),
                        direction: DismissDirection.endToStart,
                        confirmDismiss: (DismissDirection direction) async {
                          return await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AlertDialog(
                                    contentPadding: EdgeInsets.zero,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(30.0),
                                      ),
                                    ),
                                    icon: ShaderMask(
                                      shaderCallback: (bounds) =>
                                          RadialGradient(
                                        center: Alignment.center,
                                        radius: 0.5,
                                        colors: [
                                          Colors.white,
                                          Theme.of(context).primaryColorDark,
                                        ],
                                        tileMode: TileMode.mirror,
                                      ).createShader(bounds),
                                      child: Icon(
                                        color:
                                            Theme.of(context).iconTheme.color,
                                        Icons.info,
                                        size: 50,
                                      ),
                                    ),
                                    iconPadding: const EdgeInsets.all(4),
                                    title: const Text(
                                      "Remove Hero",
                                      textAlign: TextAlign.center,
                                    ),
                                    content: const Padding(
                                      padding: EdgeInsets.only(
                                          left: 20,
                                          bottom: 10,
                                          right: 20,
                                          top: 10),
                                      child: Text(
                                        "Are you sure you want to remove this Hero?",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    actions: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20,
                                            bottom: 10,
                                            right: 20,
                                            top: 0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(true),
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60),
                                                  ),
                                                  backgroundColor: Colors.green,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 30,
                                                      vertical: 10),
                                                  textStyle: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              child: const Text("Yes"),
                                            ),
                                            ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              style: ElevatedButton.styleFrom(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            60),
                                                  ),
                                                  backgroundColor: Colors.red,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 30,
                                                      vertical: 10),
                                                  textStyle: const TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold)),
                                              child: const Text(
                                                "No",
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        onDismissed: (_) {
                          FirebaseFirestore.instance
                              .collection("heromaker")
                              .doc(snapshot.data!.docs[index].reference.id)
                              .delete();
                        },
                        background: Container(
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20),
                            ),
                            gradient: LinearGradient(
                              colors: [
                                const Color.fromARGB(255, 224, 74, 74),
                                const Color.fromARGB(255, 194, 206, 31),
                                const Color.fromARGB(255, 240, 3, 3)
                                    .withOpacity(0.8),
                                Theme.of(context).primaryColorDark,
                              ],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                          ),
                          margin: const EdgeInsets.only(
                              left: 20, top: 10, right: 20, bottom: 10),
                          alignment: Alignment.centerRight,
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          margin: const EdgeInsets.only(
                              left: 10, top: 10, right: 10, bottom: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                                bottomRight: Radius.circular(20),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: const Offset(0, 1),
                                ),
                              ],
                              color: const Color.fromARGB(255, 3, 116, 104),
                            ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                  onTap: () {
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) =>
                                    //         GamePanelScreen(
                                    //             id: snapshot
                                    //                 .data!
                                    //                 .docs[index]
                                    //                 .reference
                                    //                 .id),
                                    //   ),
                                    // );
                                  },
                                  contentPadding:
                                      const EdgeInsetsDirectional.all(5),
                                  leading: CircleAvatar(
                                    backgroundColor:
                                        const Color.fromARGB(255, 36, 34, 34)
                                            .withOpacity(0.8),
                                    radius: 50,
                                    child: Image(
                                      image: AssetImage(
                                          documents[index]["ClassImage"]),
                                      width: 37,
                                      fit: BoxFit.scaleDown,
                                      color: Colors.white,
                                    ),
                                  ),
                                  title: const Text("Your Hero Name:",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                      )),
                                  subtitle: Text(documents[index]["HeroName"],
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21,
                                      )),
                                  trailing: const Icon(Icons.arrow_back,
                                      color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
