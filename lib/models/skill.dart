// models/skill.dart
class Skill {
  String name;
  int level; // 1-5 arası bir değer

  Skill({
    required this.name,
    required this.level,
  });

  // Create a copy with updated fields
  Skill copyWith({
    String? name,
    int? level,
  }) {
    return Skill(
      name: name ?? this.name,
      level: level ?? this.level,
    );
  }

  // Convert to map for potential storage
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'level': level,
    };
  }

  // Create from map
  factory Skill.fromMap(Map<String, dynamic> map) {
    return Skill(
      name: map['name'] ?? '',
      level: map['level'] ?? 1,
    );
  }
}