import 'package:dhmv1/widgets/light_container.dart';
import 'package:dhmv1/widgets/shadow_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroAtributes extends StatefulWidget {
  const HeroAtributes(
      {super.key,
      required this.atribute,
      required this.atributeresult,
      required this.color});
  final String atribute;
  final String atributeresult;
  final Color color;

  @override
  State<HeroAtributes> createState() => _HeroAtributesState();
}

double boxWidth = 180;
double boxHight = 150;

class _HeroAtributesState extends State<HeroAtributes> {
  void _expand() {
    setState(() {
      if (boxWidth == 376 || boxHight == 200) {
        boxWidth = 180;
        boxHight = 150;
      } else {
        boxWidth = 376;
        boxHight = 200;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _expand,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.all(8),
        height: boxHight,
        width: boxWidth,
        decoration: BoxDecoration(
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
        child: Column(
          children: [
            Text(
              widget.atribute,
              style: GoogleFonts.macondo(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 23.0),
            ),
            Row(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        ClipPath(
                          clipper: ShadowClipper(),
                          child: ShadowContainer(
                            color: widget.color,
                            masure: 100,
                          ),
                        ),
                        ClipPath(
                          clipper: HighlightClipper(),
                          child: LightContainer(
                            color: widget.color,
                            masure: 100,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: CircleAvatar(
                            backgroundColor: widget.color.withOpacity(0.8),
                            radius: 40,
                            child: Image.asset(
                              "lib/assets/images/d20bl.png",
                              height: 100,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 38, left: 37),
                          child: Text(
                            widget.atributeresult,
                            style: GoogleFonts.kaushanScript(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 12),
                Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 20)),
                    Text(
                      "Bonus",
                      style: GoogleFonts.macondo(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 17.0),
                    ),
                    Stack(
                      children: [
                        ClipPath(
                          clipper: ShadowClipper(),
                          child: ShadowContainer(
                            color: widget.color,
                            masure: 50,
                          ),
                        ),
                        ClipPath(
                          clipper: HighlightClipper(),
                          child: LightContainer(
                            color: widget.color,
                            masure: 50,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: CircleAvatar(
                            backgroundColor: widget.color.withOpacity(0.3),
                            radius: 20,
                            child: const ImageIcon(
                              AssetImage(
                                "lib/assets/images/d20bl.png",
                              ),
                              color: Colors.black,
                              size: double.infinity,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 13, left: 12),
                          child: Text(
                            "+3",
                            style: GoogleFonts.kaushanScript(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0),
                          ),
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
