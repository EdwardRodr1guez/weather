import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:weather/provider/favorites_provider.dart';
import 'package:weather/screens/favorites_screen.dart';

void main() {
  testWidgets("rendering favoriteScreen", (WidgetTester tester) async {
    // Arrange: load UI
    await tester.pumpWidget(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => FavoritesProvider(),
        )
      ],
      child: MaterialApp(
        home: FavoriteScreen(pageController: PageController(initialPage: 2)),
      ),
    ));
    //Act
    Finder title = find.byType(Text);

    //Assert
    expect(title, findsNWidgets(1));
  });
}
