import '../../domain/entities/cv_entity.dart';

class CvModel extends CvEntity {

  CvModel({
    required super.userId,
    required super.username,
    required super.email,
    required super.bio,
    required super.skills,
    required super.experiences,
    required super.education,
  });

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'username': username,
      'email': email,
      'bio': bio,
      'skills': skills.map((e) => e.name).toList(),
      'experiences': experiences.map((e) => {
        'company': e.company,
        'position': e.position,
        'startDate': e.startDate,
        'endDate': e.endDate,
        'description': e.description,
      }).toList(),
      'education': education.map((e) => {
        'school': e.school,
        'degree': e.degree,
        'startYear': e.startYear,
        'endYear': e.endYear,
      }).toList(),
    };
  }
}