import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:photopulse/features/subscription_management/domain/entities/subscription_package.dart';
import 'package:photopulse/features/subscription_management/domain/notifiers/subscription_management_notifier.dart';
import 'package:photopulse/features/subscription_management/presentation/widgets/subscription_package_card.dart';

class SubscriptionPackageSlider extends ConsumerWidget {
  const SubscriptionPackageSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final CarouselController carouselController = CarouselController();

    return Column(
      children: [
        SizedBox(
          child: CarouselSlider(
            carouselController: carouselController,
            items: SubscriptionPackage.values
                .map(
                  (subscription) => SubscriptionPackageCard(
                    subscription: subscription,
                    onTap: () {
                      if (ref.read(selectedSubscriptionPackageProvider) ==
                          subscription) return;
                      carouselController.animateToPage(
                        subscription.index,
                      );
                      ref
                          .read(selectedSubscriptionPackageProvider.notifier)
                          .state = subscription;
                    },
                  ),
                )
                .toList(),
            options: CarouselOptions(
              aspectRatio: 1 / 1,
              enlargeFactor: 0,
              viewportFraction: 0.7,
              enlargeCenterPage: true,
              initialPage: 0,
              enableInfiniteScroll: false,
            ),
          ),
        ),
      ],
    );
  }
}
