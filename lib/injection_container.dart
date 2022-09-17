import 'package:friends/core/device_info/device_info.dart';
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
import 'package:friends/features/register/data/data_sources/register_local_data_source.dart';
import 'package:friends/features/register/data/data_sources/register_remote_data_source.dart';
import 'package:friends/features/register/data/repositories/register_repositories_impl.dart';
import 'package:friends/features/register/domain/use_cases/Register_with_email_and_password_usecase.dart';
import 'package:friends/features/register/domain/use_cases/already_have_account_navigator_usecase.dart';
import 'package:friends/features/register/domain/use_cases/register_with_apple_usecase.dart';
import 'package:friends/features/register/domain/use_cases/register_with_facebook_usecase.dart';
import 'package:friends/features/register/domain/use_cases/register_with_google_usecase.dart';
import 'package:friends/features/register/presentation/manager/register_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'features/register/domain/repositories/register_repositories.dart';

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
  //register
  sl.registerFactory(() => RegisterBloc(
      alreadyHaveAccountNavigator: sl(),
      registerWithAppleUseCase: sl(),
      registerWithEmailAndPasswordUseCase: sl(),
      registerWithFacebookUseCase: sl(),
      registerWithGoogleUseCase: sl()));

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
  //register use cases
  sl.registerLazySingleton<AlreadyHaveAccountUseCase>(
      () => AlreadyHaveAccountUseCase(repo: sl()));
  sl.registerLazySingleton<RegisterWithGoogleUseCase>(
      () => RegisterWithGoogleUseCase(repo: sl()));
  sl.registerLazySingleton<RegisterWithFacebookUseCase>(
      () => RegisterWithFacebookUseCase(repo: sl()));
  sl.registerLazySingleton<RegisterWithAppleUseCase>(
      () => RegisterWithAppleUseCase(repo: sl()));
  sl.registerLazySingleton<RegisterWithEmailAndPasswordUseCase>(
      () => RegisterWithEmailAndPasswordUseCase(repo: sl()));

  ///repositories
  //login repositories
  sl.registerLazySingleton<LoginRepositories>(() =>
      LoginRepositoriesImpl(remote: sl(), local: sl(), networkInfo: sl()));
  //register repositories
  sl.registerLazySingleton<RegisterRepositories>(() => RegisterRepositoriesImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      deviceInfo: sl(),
      networkInfo: sl()));

  ///data source
  //login
  sl.registerLazySingleton<LoginRemoteDataSource>(
      () => LoginRemoteDataSourceImpl());
  sl.registerLazySingleton<LoginLocalDataSource>(
      () => LoginLocalDataSourceImpl());
//register
  sl.registerLazySingleton<RegisterRemoteDataSource>(() => RegisterRemoteDataSourceImpl());
  sl.registerLazySingleton<RegisterLocalDataSource>(() => RegisterLocalDataSourceImpl());
  ///core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<DeviceInfo>(() => DeviceInfoImpl());

  ///External
  sl.registerLazySingleton<InternetConnectionChecker>(
      () => InternetConnectionChecker());
}
