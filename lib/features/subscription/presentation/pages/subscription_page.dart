import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:friends/core/common_widget/loader.dart';
import 'package:friends/core/common_widget/snackbar_widget.dart';
import 'package:friends/core/common_widget/subscription_widget.dart';
import 'package:friends/core/failure/failure.dart';
import 'package:friends/core/manager/string_manager.dart';
import 'package:friends/features/subscription/presentation/manager/subscription_bloc.dart';
import 'package:responsive_s/responsive_s.dart';

class SubscriptionPage extends StatelessWidget {
  const SubscriptionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Responsive responsive = Responsive(context);
    return Scaffold(
      body: BlocConsumer<SubscriptionBloc, SubscriptionState>(
        listener: (context, state) {
          if (state is SubscriptionError) {
            debugPrint(
                "error is ${state.failure.message} code ${state.failure.statusCode}");
            if (state.failure is NetworkFailure) {
              ScaffoldMessenger.of(context).showSnackBar(MessageSnackBar(
                context,
                responsive: responsive,
                errorMessage: state.failure.message,
                animationString: AssetsManager.noNetworkAnimation,
              ));
            } else if (state.failure is NoDataFailure) {
              debugPrint("NO data failure");
            } else {
              ScaffoldMessenger.of(context).showSnackBar(MessageSnackBar(
                  context,
                  responsive: responsive,
                  errorMessage: state.failure.message));
            }
          }
        },
        builder: (context, state) {
          if (state is SubscriptionLoading) {
            return const Center(
              child: Loader(),
            );
          } else if (state is SubscriptionLoaded &&
              state.subscriptionList.isNotEmpty) {
            return ListView.builder(
              itemBuilder: (c, index) => SubscriptionWidget(
                  subscriptionEntity: state.subscriptionList[index]),
              itemCount: state.subscriptionList.length,
            );
          } else if (state is SubscriptionLoaded &&
              state.subscriptionList.isEmpty) {
            return const Center(
              child: Text(StringManager.noDataErrorMessage),
            );
          } else {
            return const Center(
              child: Text(StringManager.noDataErrorMessage),
            );
          }
        },
      ),
    );
  }
}
