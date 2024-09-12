import 'package:flutter_test/flutter_test.dart';
import 'package:photopulse/features/subscription_management/domain/entities/subscription_package.dart';

void main() {
  group('SubscriptionPackage', () {
    test('free package has correct values', () {
      expect(SubscriptionPackage.free.uploadSizeLimit, 3);
      expect(SubscriptionPackage.free.dailyUploadLimit, 1);
      expect(SubscriptionPackage.free.maxSpend, 0);
    });

    test('pro package has correct values', () {
      expect(SubscriptionPackage.pro.uploadSizeLimit, 10);
      expect(SubscriptionPackage.pro.dailyUploadLimit, 5);
      expect(SubscriptionPackage.pro.maxSpend, 100);
    });

    test('gold package has correct values', () {
      expect(SubscriptionPackage.gold.uploadSizeLimit, 15);
      expect(SubscriptionPackage.gold.dailyUploadLimit, 10);
      expect(SubscriptionPackage.gold.maxSpend, 500);
    });
  });
}
