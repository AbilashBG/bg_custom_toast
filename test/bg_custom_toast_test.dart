import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bg_custom_toast/bg_custom_toast.dart';

void main() {
  testWidgets('BGCustomToast displays and disappears after duration',
      (WidgetTester tester) async {
    final testKey = GlobalKey<NavigatorState>();

    await tester.pumpWidget(
      MaterialApp(
        navigatorKey: testKey,
        home: Scaffold(
          body: Builder(
            builder: (context) {
              return ElevatedButton(
                onPressed: () {
                  BGCustomToast.show(
                    context: context,
                    message: 'Test Toast Message',
                    position: ToastPosition.center,
                    animation: ToastAnimation.fade,
                    duration: const Duration(seconds: 2),
                  );
                },
                child: const Text('Show Toast'),
              );
            },
          ),
        ),
      ),
    );

    // Tap the button to show the toast
    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();

    // Verify that the toast is displayed
    expect(find.text('Test Toast Message'), findsOneWidget);

    // Wait for the toast duration + extra time for animation
    await tester.pumpAndSettle(const Duration(seconds: 3));

    // Verify that the toast disappears
    expect(find.text('Test Toast Message'), findsNothing);
  });
}
