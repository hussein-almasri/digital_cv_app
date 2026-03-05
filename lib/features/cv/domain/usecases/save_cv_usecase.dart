import '../entities/cv_entity.dart';
import '../repositories/cv_repository.dart';

class SaveCvUseCase {
  final CvRepository repository;

  SaveCvUseCase(this.repository);

  Future<void> call(CvEntity cv) {
    return repository.saveCv(cv);
  }
}