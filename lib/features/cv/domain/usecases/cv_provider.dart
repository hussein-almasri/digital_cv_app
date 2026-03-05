import 'package:digital_cv_app/features/cv/presentation/providers/cv_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/usecases/get_cv_usecase.dart';

final getCvUseCaseProvider = Provider<GetCvUseCase>((ref) {
  final repository = ref.read(cvRepositoryProvider);
  return GetCvUseCase(repository);
});