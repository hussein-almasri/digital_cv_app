import 'package:digital_cv_app/features/cv/domain/entities/skill_entity.dart';

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

  factory CvModel.fromMap(Map<String, dynamic> map) {
    return CvModel(
      userId: map['userId'],
      username: map['username'],
      email: map['email'],
      bio: map['bio'],
      skills: (map['skills'] as List)
          .map((e) => SkillEntity(name: e))
          .toList(),
      experiences: [],
      education: [],
    );
  }

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