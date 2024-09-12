import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:photopulse/features/login/presentation/widgets/animated_logo.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:photopulse/generated/l10n.dart';

void main() {
  testWidgets('AnimatedLogo renders and animates correctly',
      (WidgetTester tester) async {
    // Build the widget tree with ResponsiveWrapper and localization setup
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: ResponsiveBreakpoints.builder(
          child: const Scaffold(
            body: AnimatedLogo(),
          ),
          breakpoints: [
            const Breakpoint(
              start: 0,
              end: 450,
              name: MOBILE,
            ),
            const Breakpoint(
              start: 768,
              end: 1024,
              name: TABLET,
            ),
            const Breakpoint(
              start: 1025,
              end: 1920,
              name: DESKTOP,
            ),
            const Breakpoint(
              start: 1921,
              end: double.infinity,
              name: '4K',
            ),
          ],
        ),
      ),
    );

    // Verify that two FadeTransition widgets are present (one for logo and one for text)
    expect(find.byType(FadeTransition), findsNWidgets(2));

    // Pump to start the animation
    await tester.pump();

    // Pump to move forward in the animation timeline
    await tester.pump(const Duration(milliseconds: 500));

    // Find the specific AnimatedLogo widget
    final animatedLogoFinder = find.byType(AnimatedLogo);
    expect(animatedLogoFinder, findsOneWidget);

    // Find the specific AnimatedBuilder within the AnimatedLogo widget
    final animatedBuilderFinder = find.descendant(
      of: animatedLogoFinder,
      matching: find.byType(AnimatedBuilder),
    );
    expect(animatedBuilderFinder,
        findsWidgets); // More than one AnimatedBuilder may exist

    // Get the first AnimatedBuilder (you can adjust if needed)
    final animatedBuilder =
        tester.widget<AnimatedBuilder>(animatedBuilderFinder.first);

    // Safely ensure the builder output is a Transform widget
    final transformWidget = animatedBuilder.builder(
        tester.element(animatedBuilderFinder.first), null);

    // Verify that the widget returned by the builder is a Transform widget
    expect(transformWidget, isA<Transform>());

    // Extract the transformation scaling
    final scaleTransform =
        (transformWidget as Transform).transform.getMaxScaleOnAxis();
    expect(scaleTransform, greaterThan(0));

    // Complete the animation
    await tester.pumpAndSettle();

    // Check the final state of the animation
    final finalTransform =
        tester.widget<Transform>(find.byType(Transform).first);
    final finalScale = finalTransform.transform.getMaxScaleOnAxis();

    // Ensure the animation completes and the scale reaches 1 (fully animated)
    expect(finalScale, equals(1.05));
  });
}
