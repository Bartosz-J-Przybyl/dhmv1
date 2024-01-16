enum Race {
  dragonborn,
  dwarf,
  elf,
  gnome,
  halfelf,
  halfling,
  halforc,
  human,
  tielfling,
}

class RaceCategory {
  const RaceCategory({required this.title, required this.image});

  final String title;
  final String image;
}
