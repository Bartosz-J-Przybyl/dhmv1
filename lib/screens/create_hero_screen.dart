import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhmv1/data/class_categories.dart';
import 'package:dhmv1/data/race_categories.dart';
import 'package:dhmv1/models/class_category.dart';
import 'package:dhmv1/models/race_category.dart';
import 'package:dhmv1/widgets/bottom_tab_bar.dart';
import 'package:dhmv1/widgets/enter_value.dart';
import 'package:flutter/material.dart';

class CreateHerocreen extends StatefulWidget {
  const CreateHerocreen({
    super.key,
    required this.title,
    required this.onSave,
  });
  final String title;
  final Function onSave;

  @override
  State<CreateHerocreen> createState() => _CreateHeroState();
}

class _CreateHeroState extends State<CreateHerocreen> {
  _CreateHeroState();
  late TextEditingController _strengthcontrrol;
  late TextEditingController _dexteritycontrrol;
  late TextEditingController _constitutioncontrrol;
  late TextEditingController _intelligencecontrrol;
  late TextEditingController _wisdomcontrrol;
  late TextEditingController _charismacontrrol;
  var heroName = "";
  var herolvl = "1";
  var heroclass = "";
  var heroclassimage = "";
  var herorace = "";
  var heroraceimage = "";
  int strength = 10;
  int dexterity = 10;
  int constitution = 10;
  int intelligence = 10;
  int wisdom = 10;
  int charisma = 10;

  var _selectedClass = categories[Class.bard]!;
  var _selectedRace = races[Race.human]!;

  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _strengthcontrrol = TextEditingController();
    _dexteritycontrrol = TextEditingController();
    _constitutioncontrrol = TextEditingController();
    _intelligencecontrrol = TextEditingController();
    _wisdomcontrrol = TextEditingController();
    _charismacontrrol = TextEditingController();
  }

  @override
  void dispose() {
    _strengthcontrrol.dispose();
    _dexteritycontrrol.dispose();
    _constitutioncontrrol.dispose();
    _intelligencecontrrol.dispose();
    _wisdomcontrrol.dispose();
    _charismacontrrol.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.teal, Theme.of(context).primaryColorDark],
            ),
          ),
        ),
        title: const Text("Create New Hero"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    hintText: "Hero Name",
                  ),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        value.trim().length <= 1 ||
                        value.trim().length > 50) {
                      return "must be between 1 and 50 characters";
                    }
                    return null;
                  },
                  onChanged: (value) {
                    heroName = value;
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const SizedBox(
                      width: 50,
                      child: Text(
                        "Hero Race",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white54),
                      ),
                    ),
                    SizedBox(
                      width: 110,
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        value: _selectedRace,
                        items: [
                          for (final racecategory in races.entries)
                            DropdownMenuItem(
                              value: racecategory.value,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [Text(racecategory.value.title)],
                              ),
                            ),
                        ],
                        onChanged: (newValue) {
                          setState(() {
                            _selectedRace = newValue!;
                            heroraceimage = newValue.image;
                            herorace = newValue.title;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const SizedBox(
                      width: 50,
                      child: Text(
                        "Hero Class",
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white54),
                      ),
                    ),
                    SizedBox(
                      width: 140,
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        value: _selectedClass,
                        items: [
                          for (final classcategory in categories.entries)
                            DropdownMenuItem(
                              value: classcategory.value,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 35,
                                    height: 35,
                                    child: Image.asset(
                                      classcategory.value.image,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 6,
                                  ),
                                  Text(classcategory.value.title)
                                ],
                              ),
                            ),
                        ],
                        onChanged: (nvalue) {
                          setState(() {
                            _selectedClass = nvalue!;
                            heroclassimage = nvalue.image;
                            heroclass = nvalue.title;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const Divider(height: 30),
                if (herorace == "Dragonborn" || herorace == "Half-Orc") ...{
                  EnterValueClass(
                    callback: (value) {
                      strength = value;
                    },
                    text: "Your Strength :",
                    color: Colors.red,
                    textEditingController: _strengthcontrrol,
                    atribute: "+2",
                    style: TextStyle(
                      color: Colors.amber.shade900,
                    ),
                  ),
                } else if (herorace == "Human") ...{
                  EnterValueClass(
                    callback: (value) {
                      strength = value;
                    },
                    text: "Your Strength :",
                    color: Colors.red,
                    textEditingController: _strengthcontrrol,
                    atribute: "+1",
                    style: TextStyle(
                      color: Colors.amber.shade900,
                    ),
                  ),
                } else ...{
                  EnterValueClass(
                    callback: (value) {
                      strength = value;
                    },
                    text: "Your Strength :",
                    color: Colors.red,
                    textEditingController: _strengthcontrrol,
                    atribute: "",
                    style: const TextStyle(color: Colors.white),
                  ),
                },
                const Divider(height: 30),
                if (herorace == "Elf" || herorace == "Halfling") ...{
                  EnterValueClass(
                    callback: (value) {
                      dexterity = value;
                    },
                    text: "Your Dexterity :",
                    color: Colors.greenAccent,
                    textEditingController: _dexteritycontrrol,
                    atribute: "+2",
                    style: TextStyle(
                      color: Colors.amber.shade900,
                    ),
                  ),
                } else if (herorace == "Human") ...{
                  EnterValueClass(
                    callback: (value) {
                      dexterity = value;
                    },
                    text: "Your Dexterity :",
                    color: Colors.greenAccent,
                    textEditingController: _dexteritycontrrol,
                    atribute: "+1",
                    style: TextStyle(
                      color: Colors.amber.shade900,
                    ),
                  ),
                } else ...{
                  EnterValueClass(
                    callback: (value) {
                      dexterity = value;
                    },
                    text: "Your Dexterity :",
                    color: Colors.greenAccent,
                    textEditingController: _dexteritycontrrol,
                    atribute: "",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                },
                const Divider(height: 30),
                if (herorace == "Half-Orc" || herorace == "Human") ...{
                  EnterValueClass(
                    callback: (value) {
                      constitution = value;
                    },
                    text: "Your Constitution :",
                    color: Colors.orangeAccent,
                    textEditingController: _constitutioncontrrol,
                    atribute: "+1",
                    style: TextStyle(
                      color: Colors.amber.shade900,
                    ),
                  ),
                } else if (herorace == "Dwarf") ...{
                  EnterValueClass(
                    callback: (value) {
                      constitution = value;
                    },
                    text: "Your Constitution :",
                    color: Colors.orangeAccent,
                    textEditingController: _constitutioncontrrol,
                    atribute: "+2",
                    style: TextStyle(
                      color: Colors.amber.shade900,
                    ),
                  ),
                } else ...{
                  EnterValueClass(
                    callback: (value) {
                      constitution = value;
                    },
                    text: "Your Constitution :",
                    color: Colors.orangeAccent,
                    textEditingController: _constitutioncontrrol,
                    atribute: "",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                },
                const Divider(height: 30),
                if (herorace == "Human") ...{
                  EnterValueClass(
                    callback: (value) {
                      wisdom = value;
                    },
                    text: "Your Wisdom :",
                    color: Colors.blueAccent,
                    textEditingController: _wisdomcontrrol,
                    atribute: "+1",
                    style: TextStyle(
                      color: Colors.amber.shade900,
                    ),
                  ),
                } else ...{
                  EnterValueClass(
                    callback: (value) {
                      wisdom = value;
                    },
                    text: "Your Wisdom :",
                    color: Colors.blueAccent,
                    textEditingController: _wisdomcontrrol,
                    atribute: "",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                },
                const Divider(height: 30),
                if (herorace == "Human" || herorace == "Tiefling") ...{
                  EnterValueClass(
                    callback: (value) {
                      intelligence = value;
                    },
                    text: "Your Intelligence :",
                    color: Colors.yellow,
                    textEditingController: _intelligencecontrrol,
                    atribute: "+1",
                    style: TextStyle(
                      color: Colors.amber.shade900,
                    ),
                  ),
                } else if (herorace == "Gnome") ...{
                  EnterValueClass(
                    callback: (value) {
                      intelligence = value;
                    },
                    text: "Your Intelligence :",
                    color: Colors.yellow,
                    textEditingController: _intelligencecontrrol,
                    atribute: "+2",
                    style: TextStyle(
                      color: Colors.amber.shade900,
                    ),
                  ),
                } else ...{
                  EnterValueClass(
                    callback: (value) {
                      intelligence = value;
                    },
                    text: "Your Intelligence :",
                    color: Colors.yellow,
                    textEditingController: _intelligencecontrrol,
                    atribute: "",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                },
                const Divider(height: 30),
                if (herorace == "Dragonborn" || herorace == "Human") ...{
                  EnterValueClass(
                    callback: (value) {
                      charisma = value;
                    },
                    text: "Your Charisma :",
                    color: Colors.deepPurple,
                    textEditingController: _charismacontrrol,
                    atribute: "+1",
                    style: TextStyle(
                      color: Colors.amber.shade900,
                    ),
                  ),
                } else if (herorace == "Half-Elf" ||
                    herorace == "Tiefling") ...{
                  EnterValueClass(
                    callback: (value) {
                      charisma = value;
                    },
                    text: "Your Charisma :",
                    color: Colors.deepPurple,
                    textEditingController: _charismacontrrol,
                    atribute: "+2",
                    style: TextStyle(
                      color: Colors.amber.shade900,
                    ),
                  ),
                } else ...{
                  EnterValueClass(
                    callback: (value) {
                      charisma = value;
                    },
                    text: "Your Charisma :",
                    color: Colors.deepPurple,
                    textEditingController: _charismacontrrol,
                    atribute: "",
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                },
                const Divider(height: 30),
                ElevatedButton(
                  onPressed:
                      heroName.isEmpty || herolvl.isEmpty || heroclass.isEmpty
                          ? null
                          : () {
                              FirebaseFirestore.instance
                                  .collection("heromaker")
                                  .add({
                                "HeroName": heroName,
                                "Herolvl": herolvl,
                                "Class": heroclass,
                                "ClassImage": heroclassimage,
                                "Race": herorace,
                                "RaceImage": heroraceimage,
                                "Strength": strength,
                                "Dexterity": dexterity,
                                "Constitution": constitution,
                                "Intelligence": intelligence,
                                "Wisdom": wisdom,
                                "Charisma": charisma
                              }).then((value) => null);

                              widget.onSave();

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const BottomTabBar(),
                                ),
                              );
                            },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                  ),
                  child: const Text("Add your new Hero +",
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
