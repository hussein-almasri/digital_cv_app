import '../entities/cv_entity.dart';

abstract class CvRepository {
  Future<void> saveCv(CvEntity cv);
  Future<CvEntity?> getCv(String userId);
}
