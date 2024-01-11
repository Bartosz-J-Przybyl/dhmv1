import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dhmv1/screens/create_hero_screen.dart';
import 'package:dhmv1/widgets/custom_clipper.dart';
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
                      duration: const Duration(seconds: 5),
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
                                                shape: const StadiumBorder(
                                                  side: BorderSide(
                                                      color: Colors.red),
                                                ),
                                              ),
                                              child: const Text(
                                                "Yes",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              onPressed: () =>
                                                  Navigator.of(context)
                                                      .pop(false),
                                              style: ElevatedButton.styleFrom(
                                                shape: const StadiumBorder(
                                                  side: BorderSide(
                                                      color: Colors.teal),
                                                ),
                                              ),
                                              child: const Text(
                                                "No",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
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
                                Container(
                                  width: 400,
                                  height: 110,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.rectangle,
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.grey.withOpacity(0.5),
                                    ),
                                    boxShadow: const [
                                      BoxShadow(
                                        offset: Offset(0, 0),
                                        color: Color(0xFFB7B7B7),
                                        spreadRadius: 3,
                                        blurRadius: 8,
                                      )
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        right: 0,
                                        top: 0,
                                        bottom: 0,
                                        left: 200,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: Image.network(
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPybfLpFZwT2uA-WiwVrNqjDMB5pyaAjhQFL_G_jwYVaok6Zm_8XXzQzV8Kdm49L0p22E&usqp=CAU",
                                                ).image),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(8.0)),
                                            color: Colors.transparent,
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 0,
                                        top: 0,
                                        bottom: 0,
                                        child: ClipPath(
                                          clipper: CustomClipperClass(),
                                          child: Container(
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Colors.teal,
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            width: 350,
                                            height: 100,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                const Text(
                                                  "Class:",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                CircleAvatar(
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                              255, 36, 34, 34)
                                                          .withOpacity(0.8),
                                                  radius: 25,
                                                  child: Image(
                                                    image: AssetImage(
                                                        documents[index]
                                                            ["ClassImage"]),
                                                    width: 35,
                                                    fit: BoxFit.scaleDown,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                Text(
                                                  documents[index]["Class"],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                    fontStyle: FontStyle.italic,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              children: [
                                                const Text(
                                                  "Hero Name:",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                Text(
                                                  documents[index]["HeroName"],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              width: 20,
                                            ),
                                            Column(
                                              children: [
                                                const Text(
                                                  "Hero Level:",
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ),
                                                ),
                                                Text(
                                                  documents[index]["Herolvl"],
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontStyle: FontStyle.italic,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // ListTile(
                                //   onTap: () {
                                //     // Navigator.push(
                                //     //   context,
                                //     //   MaterialPageRoute(
                                //     //     builder: (context) =>
                                //     //         GamePanelScreen(
                                //     //             id: snapshot
                                //     //                 .data!
                                //     //                 .docs[index]
                                //     //                 .reference
                                //     //                 .id),
                                //     //   ),
                                //     // );
                                //   },
                                //
                                //   title: const Text("Your Hero Name:",
                                //       style: TextStyle(
                                //         color: Colors.white,
                                //         fontSize: 16,
                                //       )),
                                //   subtitle: Text(documents[index]["HeroName"],
                                //       style: const TextStyle(
                                //         color: Colors.white,
                                //         fontWeight: FontWeight.bold,
                                //         fontSize: 21,
                                //       )),
                                //   trailing: const Icon(Icons.arrow_back,
                                //       color: Colors.white),
                                // ),
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
