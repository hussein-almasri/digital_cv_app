import '../entities/cv_entity.dart';
import '../repositories/cv_repository.dart';

class GetCvUseCase {

  final CvRepository repository;

  GetCvUseCase(this.repository);

  Future<CvEntity?> call(String userId) {
    return repository.getCv(userId);
  }

}