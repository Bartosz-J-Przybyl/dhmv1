import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dhmv1/widgets/custom_clipper.dart';
import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  const HeroCard({
    super.key,
    required this.documents,
    required this.image,
    required this.text,
    required this.text2,
    required this.text3, required this.race,
  });

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final AssetImage image;
  final String text;
  final String text2;
  final String text3;
   final String race;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      margin: const EdgeInsets.only(left: 10, top: 10, right: 10, bottom: 10),
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
                                race,
                              ).image),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8.0)),
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
                          borderRadius: BorderRadius.circular(8),
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
                          mainAxisAlignment: MainAxisAlignment.start,
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
                                  const Color.fromARGB(255, 36, 34, 34)
                                      .withOpacity(0.8),
                              radius: 25,
                              child: Image(
                                image: image,
                                // AssetImage(
                                //   documents[index]["ClassImage"]
                                // ),
                                width: 35,
                                fit: BoxFit.scaleDown,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              text,
                              // documents[index]["Class"],

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
                              text2,
                              // documents[index]["HeroName"],
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
                              text3,
                              // documents[index]["Herolvl"],
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
    );
  }
}
