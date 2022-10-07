import 'package:friends/core/device_info/device_info.dart';
import 'package:friends/core/network/network_info.dart';
import 'package:friends/features/offer/data/data_sources/offerpage_local_data_source.dart';
import 'package:friends/features/offer/data/data_sources/offerpage_remote_data_source.dart';
import 'package:friends/features/offer/data/repositories/offerpage_repsitory_impl.dart';
import 'package:friends/features/offer/domain/repositories/home_page_repository.dart';
import 'package:friends/features/offer/domain/use_cases/fetch_all_offers_usecase.dart';
import 'package:friends/features/offer/domain/use_cases/get_user_data_use_case.dart';
import 'package:friends/features/offer/domain/use_cases/navigate_to_details_page_usecases.dart';
import 'package:friends/features/offer/domain/use_cases/remove_from_fovorite_usecase.dart';
import 'package:friends/features/offer/domain/use_cases/search_offers_use_case.dart';
import 'package:friends/features/offer/presentation/manager/offerpage_offer_bloc.dart';
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
import 'package:friends/features/on_boarding/data/data_sources/on_boarding_local_datasource.dart';
import 'package:friends/features/on_boarding/data/data_sources/onboarding_remote_datasource.dart';
import 'package:friends/features/on_boarding/data/repositories/on_boarding_repsoitory_impl.dart';
import 'package:friends/features/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:friends/features/on_boarding/domain/use_cases/navigate_to_login_usecase.dart';
import 'package:friends/features/on_boarding/domain/use_cases/navigate_to_register_usecase.dart';
import 'package:friends/features/on_boarding/domain/use_cases/try_auto_login_usecase.dart';
import 'package:friends/features/on_boarding/presentation/manager/on_boarding_bloc.dart';
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

import 'package:friends/features/offer/domain/use_cases/add_to_favorite_use_case.dart';
import 'package:friends/features/offer/domain/use_cases/load_favorite_use_cases.dart';
import 'package:friends/features/register/domain/repositories/register_repositories.dart';

GetIt sl = GetIt.asNewInstance();

Future<void> init() async {
  ///Features
  //login:
  sl.registerFactory(() =>
      LoginBloc(
          createAccount: sl(),
          forgetPassword: sl(),
          loginWithEmailAndPassword: sl(),
          loginWithGoogle: sl(),
          loginWithFacebook: sl(),
          loginWithApple: sl()));
  //register
  sl.registerFactory(() =>
      RegisterBloc(
          alreadyHaveAccountNavigator: sl(),
          registerWithAppleUseCase: sl(),
          registerWithEmailAndPasswordUseCase: sl(),
          registerWithFacebookUseCase: sl(),
          registerWithGoogleUseCase: sl()));
  //on boarding
  sl.registerFactory(() =>
      OnBoardingBloc(
          navigateToLoginUseCase: sl(),
          navigateToRegisterUseCase: sl(),
          tryAutoLoginUseCase: sl()));
  sl.registerFactory(() => RegisterBloc(
      alreadyHaveAccountNavigator: sl(),
      registerWithAppleUseCase: sl(),
      registerWithEmailAndPasswordUseCase: sl(),
      registerWithFacebookUseCase: sl(),
      registerWithGoogleUseCase: sl()));
  //home page
  sl.registerFactory<OfferpageBloc>(() => OfferpageBloc(
        searchOffersUseCase: sl(),
        getUserDataUseCases: sl(),
        fetchAllOffersUseCase: sl(),
        addToFavoriteUseCase: sl(),
        loadFavoriteUseCases: sl(),
        navigateToDetailsUseCases: sl(),
        removerFromFavoriteUseCases: sl(),
      ));

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
//on boarding use cases
  sl.registerLazySingleton<NavigateToLoginUseCase>(() =>
      NavigateToLoginUseCase(sl()));
  sl.registerLazySingleton<NavigateToRegisterUseCase>(() =>
      NavigateToRegisterUseCase(sl()));
  sl.registerLazySingleton<TryAutoLoginUseCase>(() =>
      TryAutoLoginUseCase(sl()));
      () => RegisterWithEmailAndPasswordUseCase(repo: sl()));
  //home page use cases
  sl.registerLazySingleton<SearchOffersUseCase>(
      () => SearchOffersUseCase(sl()));
  sl.registerLazySingleton<GetUserDataUseCases>(
      () => GetUserDataUseCases(sl()));
  sl.registerLazySingleton<FetchAllOffersUseCase>(
      () => FetchAllOffersUseCase(sl()));
  sl.registerLazySingleton<AddToFavoriteUseCase>(
      () => AddToFavoriteUseCase(sl()));
  sl.registerLazySingleton<LoadFavoriteUseCases>(
      () => LoadFavoriteUseCases(sl()));
  sl.registerLazySingleton<NavigateToDetailsUseCases>(
      () => NavigateToDetailsUseCases(sl()));
  sl.registerLazySingleton<RemoveFromFavoriteUseCase>(
      () => RemoveFromFavoriteUseCase(sl()));

  ///repositories
  //login repositories
  sl.registerLazySingleton<LoginRepositories>(() =>
      LoginRepositoriesImpl(remote: sl(), local: sl(), networkInfo: sl()));
  //register repositories
  sl.registerLazySingleton<RegisterRepositories>(() =>
      RegisterRepositoriesImpl(
          remoteDataSource: sl(),
          localDataSource: sl(),
          deviceInfo: sl(),
          networkInfo: sl()));
  //on boarding use cases
  sl.registerLazySingleton<OnBoardingRepository>(() =>
      OnBoardingRepositoryImpl(remoteDataSource: sl(),
          localDataSource: sl(),
          deviceInfo: sl(),
          networkConnection: sl()));
  sl.registerLazySingleton<RegisterRepositories>(() => RegisterRepositoriesImpl(
      remoteDataSource: sl(),
      localDataSource: sl(),
      deviceInfo: sl(),
      networkInfo: sl()));
  //home page repository
  sl.registerLazySingleton<OfferPageRepository>(() =>
      HomepageRepositoryImpl(remote: sl(), local: sl(), networkInfo: sl()));

  ///data source
  //login
  sl.registerLazySingleton<LoginRemoteDataSource>(
          () => LoginRemoteDataSourceImpl());
  sl.registerLazySingleton<LoginLocalDataSource>(
          () => LoginLocalDataSourceImpl());
//register
  sl.registerLazySingleton<RegisterRemoteDataSource>(
          () => RegisterRemoteDataSourceImpl());
  sl.registerLazySingleton<RegisterLocalDataSource>(
          () => RegisterLocalDataSourceImpl());
//on boarding
  sl.registerLazySingleton<OnBoardingLocalDataSource>(() => OnBoardingLocalDataSourceImpl());
  sl.registerLazySingleton<OnBoardingRemoteDataSource>(() => OnBoardingRemoteDataSourceImpl());
  sl.registerLazySingleton<RegisterRemoteDataSource>(
      () => RegisterRemoteDataSourceImpl());
  sl.registerLazySingleton<RegisterLocalDataSource>(
      () => RegisterLocalDataSourceImpl());
  sl.registerLazySingleton<OfferPageRemoteDataSource>(
      () => HomePageRemoteDataSourceImpl());
  sl.registerLazySingleton<OfferpageLocalDataSource>(
      () => HomePageLocalDataSourceImpl());

  ///core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<DeviceInfo>(() => DeviceInfoImpl());

  ///External
  sl.registerLazySingleton<InternetConnectionChecker>(
          () => InternetConnectionChecker());
}
