import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dhmv1/data/class_categories.dart';
import 'package:dhmv1/models/class_category.dart';
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
  _CreateHeroState() {
    _selectnumber = _playern[0];
  }
  late TextEditingController _strengthcontrrol;
  late TextEditingController _dexteritycontrrol;
  late TextEditingController _constitutioncontrrol;
  late TextEditingController _intelligencecontrrol;
  late TextEditingController _wisdomcontrrol;
  late TextEditingController _charismacontrrol;
  var heroName = "";
  var herolvl = "";
  var heroclass = "";
  var heroclassimage = "";
  var strength = "";
  var dexterity = "";
  var constitution = "";
  var intelligence = "";
  var wisdom = "";
  var charisma = "";

  var _selectedClass = categories[Class.warior]!;
  final _playern = List<String>.generate(20, (i) => ' ${i + 1}');
  String? _selectnumber = "";
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
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                TextFormField(
                  maxLength: 50,
                  decoration: const InputDecoration(
                    label: Text("Hero Name"),
                    prefixIcon: Icon(Icons.add_reaction),
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
                  children: [
                    SizedBox(
                      width: 150,
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: "Select Hero lvl",
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                          prefixIcon: Icon(Icons.elevator),
                        ),
                        value: _selectnumber,
                        items: _playern
                            .map((e) => DropdownMenuItem(
                                  value: e,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [Text(e)]),
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectnumber = newValue as String;
                            herolvl = newValue;
                          });
                        },
                      ),
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    SizedBox(
                      width: 175,
                      child: DropdownButtonFormField(
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: "Select Hero class",
                          labelStyle: TextStyle(
                            fontSize: 20,
                          ),
                          prefixIcon: Icon(Icons.accessibility_sharp),
                        ),
                        value: _selectedClass,
                        items: [
                          for (final classcategory in categories.entries)
                            DropdownMenuItem(
                              value: classcategory.value,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                EnterValueClass(
                  text: "Your Strength atribute:",
                  color: Colors.red,
                  onchanged: (value) {
                    setState(() {
                      strength = value;
                    });
                  },
                  textEditingController: _strengthcontrrol,
                ),
                const Divider(height: 30),
                EnterValueClass(
                  text: "Your Dexterity atribute:",
                  color: Colors.greenAccent,
                  onchanged: (value) {
                    setState(() {
                      dexterity = value;
                    });
                  },
                  textEditingController: _dexteritycontrrol,
                ),
                const Divider(height: 30),
                EnterValueClass(
                  text: "Your Constitution atribute:",
                  color: Colors.orangeAccent,
                  onchanged: (value) {
                    setState(() {
                      constitution = value;
                    });
                  },
                  textEditingController: _constitutioncontrrol,
                ),
                const Divider(height: 30),
                EnterValueClass(
                  text: "Your Wisdom atribute:",
                  color: Colors.blueAccent,
                  onchanged: (value) {
                    setState(() {
                      wisdom = value;
                    });
                  },
                  textEditingController: _wisdomcontrrol,
                ),
                const Divider(height: 30),
                EnterValueClass(
                  text: "Your Intelligence atribute:",
                  color: Colors.deepPurple,
                  onchanged: (value) {
                    setState(() {
                      intelligence = value;
                    });
                  },
                  textEditingController: _intelligencecontrrol,
                ),
                const Divider(height: 30),
                EnterValueClass(
                  text: "Your Charisma atribute:",
                  color: Colors.yellow,
                  onchanged: (value) {
                    setState(() {
                      charisma = value;
                    });
                  },
                  textEditingController: _charismacontrrol,
                ),
                const Divider(height: 30),
                ElevatedButton(
                  onPressed: heroName.isEmpty ||
                          herolvl.isEmpty ||
                          heroclass.isEmpty ||
                          strength.isEmpty ||
                          dexterity.isEmpty ||
                          constitution.isEmpty ||
                          intelligence.isEmpty ||
                          wisdom.isEmpty ||
                          charisma.isEmpty
                      ? null
                      : () {
                          FirebaseFirestore.instance
                              .collection("heromaker")
                              .add({
                            "HeroName": heroName,
                            "Herolvl": herolvl,
                            "Class": heroclass,
                            "ClassImage": heroclassimage,
                            "Strength": strength,
                            "Dexterity": dexterity,
                            "Constitution": constitution,
                            "Intelligence": intelligence,
                            "Wisdom": wisdom,
                            "Charisma": charisma
                          });

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
