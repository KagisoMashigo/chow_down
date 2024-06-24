import 'package:chow_down/plugins/utils/helpers.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('StringHelper', () {
    group('cookTimeConverter', () {
      test('should convert cook time less than 60 minutes correctly', () {
        expect(StringHelper.cookTimeConverter(45), '45 mins');
        expect(StringHelper.cookTimeConverter(30), '30 mins');
      });

      test('should convert cook time of exactly 60 minutes correctly', () {
        expect(StringHelper.cookTimeConverter(60), '1 hour');
      });

      test('should convert cook time between 60 and 120 minutes correctly', () {
        expect(StringHelper.cookTimeConverter(90), '1 hr 30 mins');
      });

      test('should convert cook time of 120 minutes or more correctly', () {
        expect(StringHelper.cookTimeConverter(120), '2 hrs 00 mins');
        expect(StringHelper.cookTimeConverter(150), '2 hrs 30 mins');
      });
    });

    group('isUrlValid', () {
      test('should return false for null URL', () {
        expect(StringHelper.isUrlValid(null), false);
      });

      test('should return false for invalid URL', () {
        expect(StringHelper.isUrlValid('invalid_url'), false);
        expect(StringHelper.isUrlValid('htp://invalid.com'), false);
      });

      test('should return true for valid URL', () {
        expect(StringHelper.isUrlValid('https://www.example.com'), true);
        expect(StringHelper.isUrlValid('http://example.com'), true);
      });
    });

    group('generateCustomId', () {
      test('should generate a unique ID based on the title', () {
        final title = 'Test Title';
        final expectedId =
            '${title.replaceAll(RegExp(r"[^\s\w]"), '').trim()}-${title.replaceAll(RegExp(r"[^\s\w]"), '').trim().hashCode}';

        expect(StringHelper.generateCustomId(title), expectedId);
      });

      test('should handle titles with special characters correctly', () {
        final title = 'Test @ Title!';
        final expectedId =
            '${title.replaceAll(RegExp(r"[^\s\w]"), '').trim()}-${title.replaceAll(RegExp(r"[^\s\w]"), '').trim().hashCode}';

        expect(StringHelper.generateCustomId(title), expectedId);
      });
    });
  });
}
