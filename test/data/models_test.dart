import 'package:flutter_test/flutter_test.dart';
import 'package:sana/app/data/models/consultation_model.dart';
import 'package:sana/app/data/models/message_model.dart';

void main() {
  group('MessageModel', () {
    test('maps botMessage to the "message" column and round-trips', () {
      final model = MessageModel(
        id: 7,
        sessionId: 's1',
        userMessage: 'hi',
        botMessage: 'hello',
        status: 'success',
        usertimestamp: '2026-09-29 10:00:00',
        bottimestamp: '2026-09-29 10:00:05',
      );

      final json = model.toJson();
      expect(json['message'], 'hello');

      final copy = MessageModel.fromJson(json);
      expect(copy.id, 7);
      expect(copy.sessionId, 's1');
      expect(copy.userMessage, 'hi');
      expect(copy.botMessage, 'hello');
      expect(copy.status, 'success');
      expect(copy.usertimestamp, '2026-09-29 10:00:00');
      expect(copy.bottimestamp, '2026-09-29 10:00:05');
    });

    test('omits a null id so sqflite can autoincrement', () {
      expect(
        MessageModel(userMessage: 'x').toJson().containsKey('id'),
        isFalse,
      );
    });

    test('parses an API reply', () {
      final reply = MessageModel.fromJson({
        'status': 'success',
        'message': 'Drink water and rest.',
      });
      expect(reply.status, 'success');
      expect(reply.botMessage, 'Drink water and rest.');
    });
  });

  group('ConsultationModel', () {
    test('round-trips through json', () {
      final model = ConsultationModel(
        id: '123',
        title: 'Headache',
        createdAt: '2026-09-29 10:00:00',
        updatedAt: '2026-09-29 10:05:00',
        lastMessage: 'Rest well.',
      );
      final copy = ConsultationModel.fromJson(model.toJson());
      expect(copy.id, '123');
      expect(copy.title, 'Headache');
      expect(copy.createdAt, '2026-09-29 10:00:00');
      expect(copy.updatedAt, '2026-09-29 10:05:00');
      expect(copy.lastMessage, 'Rest well.');
    });

    test('falls back to defaults for missing fields', () {
      final copy = ConsultationModel.fromJson({'id': 'x'});
      expect(copy.title, 'New Consultation');
      expect(copy.createdAt, '');
      expect(copy.lastMessage, isNull);
    });
  });
}
