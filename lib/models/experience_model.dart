class ExperienceModel {

  final String id;
  final String jobTitle;
  final String company;
  final String description;

  ExperienceModel({
    required this.id,
    required this.jobTitle,
    required this.company,
    required this.description,
  });

  Map<String, dynamic> toMap(){

    return {

      "jobTitle": jobTitle,
      "company": company,
      "description": description,

    };

  }

}