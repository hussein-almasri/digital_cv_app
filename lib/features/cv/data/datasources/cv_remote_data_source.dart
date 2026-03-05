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
}