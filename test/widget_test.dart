import 'package:flutter_test/flutter_test.dart';
import 'package:offline_music_player/main.dart';

void main() {
  testWidgets('App launches successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    expect(find.text('Music Player'), findsOneWidget);
  });
}
