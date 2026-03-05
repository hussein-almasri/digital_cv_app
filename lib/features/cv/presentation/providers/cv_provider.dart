import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/datasources/cv_remote_data_source.dart';
import '../../data/repositories/cv_repository_impl.dart';
import '../../domain/usecases/save_cv_usecase.dart';

final cvRemoteDataSourceProvider = Provider<CvRemoteDataSource>((ref) {
  return CvRemoteDataSource();
});

final cvRepositoryProvider = Provider<CvRepositoryImpl>((ref) {
  final remote = ref.read(cvRemoteDataSourceProvider);
  return CvRepositoryImpl(remote);
});

final saveCvUseCaseProvider = Provider<SaveCvUseCase>((ref) {
  final repository = ref.read(cvRepositoryProvider);
  return SaveCvUseCase(repository);
});