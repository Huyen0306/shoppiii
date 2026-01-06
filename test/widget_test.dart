import 'package:flutter_test/flutter_test.dart';
import 'package:shop/main.dart';
import 'package:provider/provider.dart';
import 'package:shop/core/services/auth_service.dart';
import 'package:shop/core/services/cart_service.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    // We need to provide the services because main.dart's MyApp does that too.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CartService()),
          ChangeNotifierProvider(create: (_) => AuthService()),
        ],
        child: const MyApp(),
      ),
    );

    // Verify that we are on the login page by looking for the sign in text.
    expect(find.text('Sign in to your account'), findsOneWidget);
  });
}
