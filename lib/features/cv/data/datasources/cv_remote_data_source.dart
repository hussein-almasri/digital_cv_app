import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/cv_model.dart';

class CvRemoteDataSource {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> saveCv(CvModel cv) async {

    await firestore
        .collection("cvs")
        .doc(cv.userId)
        .set(cv.toMap());
  }
  
  Future<CvModel?> getCv(String userId) async {

  final doc = await firestore
      .collection("cvs")
      .doc(userId)
      .get();

  if (!doc.exists) return null;

  return CvModel.fromMap(doc.data()!);
}
}