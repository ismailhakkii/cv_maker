// models/education.dart
class Education {
  String school;
  String degree;
  String fieldOfStudy;
  String startDate;
  String endDate;

  Education({
    required this.school,
    required this.degree,
    required this.fieldOfStudy,
    required this.startDate,
    required this.endDate,
  });

  // Create a copy with updated fields
  Education copyWith({
    String? school,
    String? degree,
    String? fieldOfStudy,
    String? startDate,
    String? endDate,
  }) {
    return Education(
      school: school ?? this.school,
      degree: degree ?? this.degree,
      fieldOfStudy: fieldOfStudy ?? this.fieldOfStudy,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
    );
  }

  // Convert to map for potential storage
  Map<String, dynamic> toMap() {
    return {
      'school': school,
      'degree': degree,
      'fieldOfStudy': fieldOfStudy,
      'startDate': startDate,
      'endDate': endDate,
    };
  }

  // Create from map
  factory Education.fromMap(Map<String, dynamic> map) {
    return Education(
      school: map['school'] ?? '',
      degree: map['degree'] ?? '',
      fieldOfStudy: map['fieldOfStudy'] ?? '',
      startDate: map['startDate'] ?? '',
      endDate: map['endDate'] ?? '',
    );
  }
}