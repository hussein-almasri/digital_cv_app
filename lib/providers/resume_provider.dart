import 'package:flutter/material.dart';
import '../services/firestore_service.dart';

class ResumeProvider extends ChangeNotifier {

  final FirestoreService _firestore = FirestoreService();

  void addSkill(String userId, String skill){

    _firestore.addSkill(userId, skill);

  }

  Stream getSkills(String userId){

    return _firestore.getSkills(userId);

  }

  void deleteSkill(String id){

    _firestore.deleteSkill(id);

  }

  void addExperience(
    String userId,
    String jobTitle,
    String company,
    String description,
  ){

    _firestore.addExperience(
      userId,
      jobTitle,
      company,
      description,
    );

  }

}