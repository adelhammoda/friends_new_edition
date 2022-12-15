import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_bloc/user_details_manager/user_details_bloc.dart';
import 'package:friends/core/common_widget/app_bar.dart';
import 'package:friends/core/common_widget/loader.dart';
import 'package:friends/core/common_widget/snackbar_widget.dart';
import 'package:friends/core/common_widget/subscription_widget.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/QRScanner/presentation/manager/subscription_manager/subscription_bloc.dart';
import 'package:friends/features/QRScanner/presentation/widgets/subscribe_checker.dart';
import 'package:friends/features/QRScanner/presentation/widgets/user_section.dart';
import 'package:friends/features/subscription/domain/entities/subscription_entity.dart';
import 'package:responsive_s/responsive_s.dart';

class UserDetailsPage extends StatefulWidget {
  final String userId;

  const UserDetailsPage({Key? key, required this.userId}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  @override
  initState() {
    super.initState();
    BlocProvider.of<SubscriptionQrScannerBloc>(context)
        .add(LoadUserSubscriptionsEvent(userId: widget.userId));
    BlocProvider.of<UserDetailsBloc>(context)
        .add(LoadUserDetailsEvent(userId: widget.userId));
  }

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      appBar: FriendsAppbar(
        containLogo: true,
        backButton: true,
        isGrey: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              width: double.infinity,
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: responsive.responsiveHeight(forUnInitialDevices: 4)),
              child: BlocBuilder<SubscriptionQrScannerBloc,
                  SubscriptionQrScannerState>(
                builder: (context, state) {
                  if (state is SubscriptionQrScannerLoadedState) {
                    return SubscribeChecker(
                        subscriptionEntity: state.subscriptionEntity.first);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            const UserSection(),
            const Divider(
              thickness: 2,
            ),
            SizedBox(
                height: responsive.responsiveHeight(forUnInitialDevices: 40),
                child: BlocConsumer<SubscriptionQrScannerBloc,
                    SubscriptionQrScannerState>(
                  listener: (context, state) {
                    if (state is SubscriptionQrScannerErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          MessageSnackBar(context,
                              responsive: responsive,
                              errorMessage: state.failure.message));
                    }
                  },
                  builder: (context, state) {
                    if (state is SubscriptionQrScannerLoadingState) {
                      return const Center(
                        child: Loader(),
                      );
                    } else if (state is SubscriptionQrScannerLoadedState) {
                      return ListView.builder(
                        itemCount: state.subscriptionEntity.length,
                        itemBuilder: (c, index) => SubscriptionWidget(
                          subscriptionEntity: SubscriptionEntity(
                              borderColor: Colors.black,
                              name: state.subscriptionEntity[index].name,
                              imageUrl:
                                  state.subscriptionEntity[index].imageUrl,
                              backGroundColor: state
                                  .subscriptionEntity[index].backGroundColor,
                              currency:
                                  state.subscriptionEntity[index].currency,
                              endDate: state.subscriptionEntity[index].endDate,
                              price: state.subscriptionEntity[index].price,
                              id: state.subscriptionEntity[index].id,
                              startDate:
                                  state.subscriptionEntity[index].startDate,
                              description:
                                  state.subscriptionEntity[index].description),
                          scannedByValue: state.centerInfo[index],
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          StringManager.noDataErrorMessage,
                        ),
                      );
                    }
                  },
                ))
          ],
        ),
      ),
    );
  }
}
