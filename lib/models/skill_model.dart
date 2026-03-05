class SkillModel {

  final String id;
  final String skill;

  SkillModel({
    required this.id,
    required this.skill,
  });

  factory SkillModel.fromFirestore(Map<String, dynamic> data, String id) {

    return SkillModel(
      id: id,
      skill: data['skillName'],
    );
  }

  Map<String, dynamic> toMap() {

    return {
      "skillName": skill,
    };

  }

}