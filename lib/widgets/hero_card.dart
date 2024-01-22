import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhmv1/widgets/custom_cliper_second.dart';

import 'package:dhmv1/widgets/custom_clipper.dart';
import 'package:dhmv1/widgets/light_container.dart';
import 'package:dhmv1/widgets/shadow_container.dart';
import 'package:flutter/material.dart';

class HeroCard extends StatelessWidget {
  const HeroCard(
      {super.key,
      required this.documents,
      required this.image,
      required this.textClass,
      required this.textHeroName,
      required this.textHerolvl,
      required this.textRaceImage,
      required this.ontap,
      required this.textRace});

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;
  final AssetImage image;
  final String textClass;
  final String textHeroName;
  final String textHerolvl;
  final String textRace;
  final String textRaceImage;
  final Function() ontap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
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
                                textRaceImage,
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
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(255, 50, 58, 60),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.white.withOpacity(0.1),
                                blurRadius: 16.0,
                                offset: const Offset(-6.0, -6.0),
                              ),
                              BoxShadow(
                                color: Colors.black.withOpacity(0.4),
                                offset: const Offset(6.0, 6.0),
                                blurRadius: 16.0,
                              )
                            ],
                          ),
                          width: 350,
                          height: 100,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      child: ClipPath(
                        clipper: CustomClipperSecondClass(),
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors.lightGreen,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 2, left: 2),
                          child: Column(
                            children: [
                              Text(
                                textHerolvl,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 50, 58, 60),
                                  fontSize: 15,
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: RotationTransition(
                                  turns: AlwaysStoppedAnimation(-53 / 360),
                                  child: Text(
                                    "LVL",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 50, 58, 60),
                                      fontSize: 13,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, left: 5),
                          child: Column(
                            children: [
                              Stack(
                                children: [
                                  ClipPath(
                                    clipper: ShadowClipper(),
                                    child: const ShadowContainer(
                                      color: Colors.transparent,
                                      masure: 60,
                                    ),
                                  ),
                                  ClipPath(
                                    clipper: HighlightClipper(),
                                    child: const LightContainer(
                                      color: Colors.transparent,
                                      masure: 60,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.only(left: 5, top: 5),
                                    child: CircleAvatar(
                                      backgroundColor:
                                          const Color.fromARGB(255, 36, 34, 34)
                                              .withOpacity(0.8),
                                      radius: 25,
                                      child: Image(
                                        image: image,
                                        width: 35,
                                        fit: BoxFit.scaleDown,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 0,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    const Text(
                                      " Name:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      textHeroName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontStyle: FontStyle.italic,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    const Text(
                                      "Class:",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      textClass,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                children: [
                                  const Text(
                                    "Race:",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize: 17,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    textRace,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
