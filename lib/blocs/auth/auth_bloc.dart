import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_firebase/blocs/auth/auth.dart';
import 'package:repository/repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState>{

  final UserRepo _userRepo;

  AuthBloc({@required UserRepo userRepo})
    :assert(userRepo != null),
    _userRepo = userRepo;

  @override
  AuthState get initialState => Uninitialized();

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async*{
    if (event is AppStarted){
      yield* _mapAppStartedToState();
    }
  }

  Stream<AuthState> _mapAppStartedToState() async*{
    try{
      final isSignedIn = await _userRepo.isAuthenticated();
      if (!isSignedIn){
        await _userRepo.authenticate();
      }
      final userId = await _userRepo.getUserId();
      yield Authenticated(userId);
    } catch (_){
      yield Unauthenticated();
    }
  }

}