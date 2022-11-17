part of 'subscription_bloc.dart';

@immutable
abstract class SubscriptionQrScannerEvent extends Equatable{
  const SubscriptionQrScannerEvent();
}

class LoadUserSubscriptionsEvent extends SubscriptionQrScannerEvent{
  final String? userId;

  const LoadUserSubscriptionsEvent({required this.userId});
  @override
  List<Object?> get props => [];
}
