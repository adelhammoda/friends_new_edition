import 'package:friends/core/network/network_info.dart';
import 'package:friends/features/login/data/data_sources/login_local_data_source.dart';
import 'package:friends/features/login/data/data_sources/login_remote_data_source.dart';
import 'package:friends/features/login/data/repositories/login_repositories_impl.dart';
import 'package:friends/features/login/domain/repositories/login_repositories.dart';
import 'package:friends/features/login/domain/use_cases/create_account_usecase.dart';
import 'package:friends/features/login/domain/use_cases/forget_password_usecase.dart';
import 'package:friends/features/login/domain/use_cases/login_with_apple_usecase.dart';
import 'package:friends/features/login/domain/use_cases/login_with_email_usecase.dart';
import 'package:friends/features/login/domain/use_cases/login_with_facebook_usecase.dart';
import 'package:friends/features/login/domain/use_cases/login_with_google_usecase.dart';
import 'package:friends/features/login/presentation/manager/login_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

GetIt sl = GetIt.asNewInstance();

Future<void> init() async {
  ///Features
  //login:
  sl.registerFactory(() => LoginBloc(
      createAccount: sl(),
      forgetPassword: sl(),
      loginWithEmailAndPassword: sl(),
      loginWithGoogle: sl(),
      loginWithFacebook: sl(),
      loginWithApple: sl()));

  ///use cases
  // login use cases
  sl.registerLazySingleton<CreateAccountUseCases>(
      () => CreateAccountUseCases(sl()));
  sl.registerLazySingleton<ForgetPasswordUseCases>(
      () => ForgetPasswordUseCases(sl()));
  sl.registerLazySingleton<LoginWithEmailAndPasswordUseCases>(
      () => LoginWithEmailAndPasswordUseCases(sl()));
  sl.registerLazySingleton<LoginWithGoogleUseCases>(
      () => LoginWithGoogleUseCases(sl()));
  sl.registerLazySingleton<LoginWithAppleUseCases>(
      () => LoginWithAppleUseCases(sl()));
  sl.registerLazySingleton<LoginWithFacebookUseCases>(
      () => LoginWithFacebookUseCases(sl()));

  ///repositories
  //login repositories
  sl.registerLazySingleton<LoginRepositories>(() =>
      LoginRepositoriesImpl(remote: sl(), local: sl(), networkInfo: sl()));

  ///data source
  //login
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl());
  sl.registerLazySingleton<LoginLocalDataSource>(
      () => LoginLocalDataSourceImpl());

  ///core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  ///External
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());

}
