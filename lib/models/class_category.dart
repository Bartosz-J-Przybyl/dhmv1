enum Class {
  fighter,
  druid,
  wizard,
  barbarian,
  bard,
  cleric,
  monk,
  paladin,
  ranger,
  rouge,
  sorcerer,
  warlock,
}

class ClassCategory {
  const ClassCategory({required this.title, required this.image});

  final String title;
  final String image;
}
