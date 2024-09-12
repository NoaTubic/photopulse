// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:photopulse/main.dart' as app;
import 'package:photopulse/main/app_environment.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  FlutterError.onError = (FlutterErrorDetails details) {
    if (details.exception is ArgumentError &&
        details.exception.toString().contains('No host specified in URI')) {
      print('Ignoring ArgumentError: ${details.exception}');
    } else {
      FlutterError.presentError(details);
    }
  };

  group('Subscription Management Flow', () {
    Future<void> login(WidgetTester tester) async {
      await tester.enterText(
          find.byKey(const Key('Email')), 'noatubic@gmail.com');
      await tester.enterText(find.byKey(const Key('Password')), 'password');
      await tester.tap(find.byKey(const Key('LoginButton')));
      await tester.pumpAndSettle(const Duration(seconds: 5));
      print('Logged in');
    }

    Future<void> navigateToSubscriptionPage(WidgetTester tester) async {
      await tester.tap(find.byKey(const Key('Profile')));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      await tester.tap(find.byKey(const Key('SubscriptionManagementTile')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('ChangeSubscriptionButton')));
      await tester.pumpAndSettle(const Duration(seconds: 2));
      print('Navigated to Subscription Management Page');
    }

    testWidgets('User can change subscription from Pro to Free',
        (WidgetTester tester) async {
      app.mainCommon(AppEnvironment.DEV);
      await tester.pumpAndSettle();
      await login(tester);
      await navigateToSubscriptionPage(tester);

      expect(find.text('PRO'), findsOneWidget);
      await tester.tap(find.byKey(const Key('ConfirmChangeButton')));
      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(find.text('FREE'), findsOneWidget);
    });

    testWidgets('User can change subscription from Free to Gold',
        (WidgetTester tester) async {
      app.mainCommon(AppEnvironment.DEV);
      await tester.pumpAndSettle();
      await login(tester);
      await navigateToSubscriptionPage(tester);

      expect(find.text('FREE'), findsOneWidget);
      await tester.tap(find.byKey(const Key('GoldPackageOption')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('ConfirmChangeButton')));
      await tester.pumpAndSettle(const Duration(seconds: 5));
      expect(find.text('GOLD'), findsOneWidget);
    });

    testWidgets('User cannot change subscription when limit reached',
        (WidgetTester tester) async {
      app.mainCommon(AppEnvironment.DEV);
      await tester.pumpAndSettle();
      await login(tester);
      await navigateToSubscriptionPage(tester);

      // Assuming there's a way to set the user's subscription change limit
      // This might require modifying your app to accept a test flag or using a test user
      // For this example, let's assume we've reached the limit

      expect(find.text('PRO'), findsOneWidget);
      expect(find.byKey(const Key('ConfirmChangeButton')), findsNothing);
      expect(find.text('Subscription change limit reached'), findsOneWidget);
    });

    testWidgets('Subscription details are displayed correctly',
        (WidgetTester tester) async {
      app.mainCommon(AppEnvironment.DEV);
      await tester.pumpAndSettle();
      await login(tester);
      await navigateToSubscriptionPage(tester);

      expect(find.text('PRO'), findsOneWidget);
      expect(find.text('Upload Size: 10 MB'), findsOneWidget);
      expect(find.text('Daily Upload Limit: 5'), findsOneWidget);
      expect(find.text('Max Spend: 100'), findsOneWidget);
    });

    testWidgets('User can cancel subscription change',
        (WidgetTester tester) async {
      app.mainCommon(AppEnvironment.DEV);
      await tester.pumpAndSettle();
      await login(tester);
      await navigateToSubscriptionPage(tester);

      expect(find.text('PRO'), findsOneWidget);
      await tester.tap(find.byKey(const Key('GoldPackageOption')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('CancelButton')));
      await tester.pumpAndSettle();

      // Verify we're back on the profile page
      expect(
          find.byKey(const Key('SubscriptionManagementTile')), findsOneWidget);
    });
  });
}
