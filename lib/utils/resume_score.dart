int calculateScore({

  required bool hasSkills,
  required bool hasExperience,
  required bool hasEducation,
  required bool hasProjects,
  required bool hasAbout,

}){

  int score = 0;

  if(hasSkills) score += 20;
  if(hasExperience) score += 20;
  if(hasEducation) score += 20;
  if(hasProjects) score += 20;
  if(hasAbout) score += 20;

  return score;

}