import 'package:flutter_bloc/flutter_bloc.dart';

class OnboardingCubit extends Cubit<int> {
  OnboardingCubit() : super(0);

  void setStep(int step) => emit(step.clamp(0, 2));
  void nextStep() => emit((state + 1).clamp(0, 2));
  void previousStep() => emit((state - 1).clamp(0, 2));
}
