part of 'subscription_bloc.dart';

@immutable
abstract class SubscriptionState {}

class SubscriptionInitial extends SubscriptionState {}

class SubscriptionLoading extends SubscriptionState{}

class SubscriptionNoState extends SubscriptionState{}

class SubscriptionLoaded extends SubscriptionState{
  final List<SubscriptionEntity> subscriptionList;

  SubscriptionLoaded({required this.subscriptionList});
}

class SubscriptionError extends SubscriptionState{
  final Failure failure;

  SubscriptionError({required this.failure});
}