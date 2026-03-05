import '../../domain/entities/cv_entity.dart';
import '../../domain/repositories/cv_repository.dart';
import '../datasources/cv_remote_data_source.dart';
import '../models/cv_model.dart';

class CvRepositoryImpl implements CvRepository {

  final CvRemoteDataSource remoteDataSource;

  CvRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> saveCv(CvEntity cv) {

    final model = CvModel(
      userId: cv.userId,
      username: cv.username,
      email: cv.email,
      bio: cv.bio,
      skills: cv.skills,
      experiences: cv.experiences,
      education: cv.education,
    );

    return remoteDataSource.saveCv(model);
  }
}