import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:milestone_tracker_of_infants/features/auth/repository/auth_repository.dart';
import 'package:milestone_tracker_of_infants/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(): super(AuthInitial());
  final authRepository = AuthRepository();
  void signUp ({
    required String phone  
  }) async {
    try {
      emit(AuthLoading());
      final user = await authRepository.signUp(phone: phone);
      emit(AuthSignUp());
      emit(AuthLoggedIn(user));
      
    }
    catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}