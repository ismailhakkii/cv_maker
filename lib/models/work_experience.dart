// models/work_experience.dart
class WorkExperience {
  String company;
  String position;
  String startDate;
  String endDate;
  String description;

  WorkExperience({
    required this.company,
    required this.position,
    required this.startDate,
    required this.endDate,
    required this.description,
  });

  // Create a copy with updated fields
  WorkExperience copyWith({
    String? company,
    String? position,
    String? startDate,
    String? endDate,
    String? description,
  }) {
    return WorkExperience(
      company: company ?? this.company,
      position: position ?? this.position,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      description: description ?? this.description,
    );
  }

  // Convert to map for potential storage
  Map<String, dynamic> toMap() {
    return {
      'company': company,
      'position': position,
      'startDate': startDate,
      'endDate': endDate,
      'description': description,
    };
  }

  // Create from map
  factory WorkExperience.fromMap(Map<String, dynamic> map) {
    return WorkExperience(
      company: map['company'] ?? '',
      position: map['position'] ?? '',
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
      description: map['description'] ?? '',
    );
  }
}