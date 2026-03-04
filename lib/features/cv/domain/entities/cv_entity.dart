import 'skill_entity.dart';
import 'experience_entity.dart';
import 'education_entity.dart';

class CvEntity {

  final String userId;
  final String username;
  final String email;
  final String bio;

  final List<SkillEntity> skills;
  final List<ExperienceEntity> experiences;
  final List<EducationEntity> education;

  CvEntity({
    required this.userId,
    required this.username,
    required this.email,
    required this.bio,
    required this.skills,
    required this.experiences,
    required this.education,
  });

}