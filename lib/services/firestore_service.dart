import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // إنشاء user profile إذا لم يكن موجود
  Future<void> createUserIfNotExists(
      String userId,
      String email,
      ) async {

    final doc = await _db.collection("users").doc(userId).get();

    if (!doc.exists) {

      String username = email.split("@")[0];

      await _db.collection("users").doc(userId).set({

        "name": username,
        "email": email,
        "bio": "",
        "avatar": ""

      });

    }

  }

  // -----------------------------
  // USER PROFILE
  // -----------------------------

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

    }, SetOptions(merge: true));

  }

  Future<void> updateProfileImage(
      String userId,
      String imageUrl) async {

    await _db.collection("users").doc(userId).set({

      "avatar": imageUrl,

    }, SetOptions(merge: true));

  }

  Stream<DocumentSnapshot> getUser(String userId){

    return _db
        .collection("users")
        .doc(userId)
        .snapshots();

  }

  // -----------------------------
  // SKILLS
  // -----------------------------

  Future<void> addSkill(String userId, String skill) async {

    await _db.collection("skills").add({

      "userId": userId,
      "skillName": skill,

    });

  }

  Stream<QuerySnapshot> getSkills(String userId){

    return _db
        .collection("skills")
        .where("userId", isEqualTo: userId)
        .snapshots();

  }

  Future<void> deleteSkill(String id) async {

    await _db.collection("skills").doc(id).delete();

  }

  // -----------------------------
  // EXPERIENCE
  // -----------------------------

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

}