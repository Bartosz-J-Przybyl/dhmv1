import 'package:dhmv1/widgets/light_container.dart';
import 'package:dhmv1/widgets/shadow_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeroAtributes extends StatelessWidget {
  const HeroAtributes(
      {super.key,
      required this.atribute,
      required this.atributeresult,
      required this.color});
  final String atribute;
  final String atributeresult;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 180,
      width: 180,
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
            atribute,
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
                          color: color,
                          masure: 100,
                        ),
                      ),
                      ClipPath(
                        clipper: HighlightClipper(),
                        child: LightContainer(
                          color: color,
                          masure: 100,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 10),
                        child: CircleAvatar(
                          backgroundColor: color.withOpacity(0.8),
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
                          atributeresult,
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
                  const Padding(padding: EdgeInsets.only(top: 40)),
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
                          color: color,
                          masure: 50,
                        ),
                      ),
                      ClipPath(
                        clipper: HighlightClipper(),
                        child: LightContainer(
                          color: color,
                          masure: 50,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5),
                        child: CircleAvatar(
                          backgroundColor: color.withOpacity(0.3),
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
    );
  }
}
