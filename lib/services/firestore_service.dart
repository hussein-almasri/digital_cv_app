import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Add Skill
  Future<void> addSkill(String userId, String skill) async {

    await _db.collection("skills").add({
      "userId": userId,
      "skillName": skill,
    });

  }

  // Get Skills
  Stream<QuerySnapshot> getSkills(String userId){

    return _db
        .collection("skills")
        .where("userId", isEqualTo: userId)
        .snapshots();

  }

  // Delete Skill
  Future<void> deleteSkill(String id) async {

    await _db.collection("skills").doc(id).delete();

  }

  // Add Experience
  Future<void> addExperience(
    String userId,
    String jobTitle,
    String company,
    String description,
  ) async {

    await _db.collection("experience").add({

      "userId": userId,
      "jobTitle": jobTitle,
      "company": company,
      "description": description,

    });

  }

  // Save User Profile
  Future<void> saveUserProfile(
    String userId,
    String name,
    String email,
    String bio,
  ) async {

    await _db.collection("users").doc(userId).set({

      "name": name,
      "email": email,
      "bio": bio,

    });

  }

  // Get User Data
  Stream<DocumentSnapshot> getUser(String userId){

    return _db
        .collection("users")
        .doc(userId)
        .snapshots();

  }

}