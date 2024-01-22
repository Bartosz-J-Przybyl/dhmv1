import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhmv1/widgets/hero_atribute.dart';
import 'package:dhmv1/widgets/hero_info.dart';

import 'package:flutter/material.dart';

class DungeonHeroCard extends StatefulWidget {
  final String id;

  final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents;

  const DungeonHeroCard({super.key, required this.id, required this.documents});

  @override
  State<DungeonHeroCard> createState() => _DungeonHeroCardState();
}

class _DungeonHeroCardState extends State<DungeonHeroCard> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('heromaker')
            .doc(widget.id)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
                child: SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(),
            ));
          }
          var userDocument = snapshot.data;
          return Scaffold(
            appBar: AppBar(),
            bottomNavigationBar: BottomNavigationBar(
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.book,
                    ),
                    label: "Stats"),
                BottomNavigationBarItem(
                  icon: Icon(Icons.ac_unit_rounded),
                  label: "",
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    const HeroInfo(),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeroAtributes(
                          atribute: "Strength",
                          atributeresult: userDocument!["Strength"].toString(),
                          color: Colors.red,
                        ),
                        HeroAtributes(
                          atribute: "Dexterity",
                          atributeresult: userDocument["Dexterity"].toString(),
                          color: Colors.greenAccent,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeroAtributes(
                          atribute: "Constitution",
                          atributeresult:
                              userDocument["Constitution"].toString(),
                          color: Colors.orangeAccent,
                        ),
                        HeroAtributes(
                          atribute: "Wisdom",
                          atributeresult: userDocument["Wisdom"].toString(),
                          color: Colors.blueAccent,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        HeroAtributes(
                          atribute: "Intelligence",
                          atributeresult:
                              userDocument["Intelligence"].toString(),
                          color: Colors.yellow,
                        ),
                        HeroAtributes(
                          atribute: "Charisma",
                          atributeresult: userDocument["Charisma"].toString(),
                          color: Colors.deepPurple,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
