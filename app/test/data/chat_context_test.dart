import 'package:flutter_test/flutter_test.dart';
import 'package:sana/app/data/models/message_model.dart';
import 'package:sana/app/data/repository/chat_repository.dart';

MessageModel _msg(int id, String user, String? bot) =>
    MessageModel(id: id, sessionId: 's', userMessage: user, botMessage: bot);

void main() {
  group('ChatRepository.buildPromptWithContext', () {
    test('returns the bare prompt when there is no history', () {
      expect(
        ChatRepository.buildPromptWithContext(prompt: 'Hi', history: []),
        'Hi',
      );
    });

    test('embeds earlier exchanges oldest first, skipping failed ones', () {
      final result = ChatRepository.buildPromptWithContext(
        prompt: 'What should I avoid?',
        // Newest first, as returned by the database.
        history: [
          _msg(3, 'Failed question', null),
          _msg(2, 'Is it serious?', 'It can be.'),
          _msg(1, 'I am allergic to penicillin.', 'Noted.'),
        ],
      );

      expect(
        result,
        'Previous conversation:\n'
        'User: I am allergic to penicillin.\nSana: Noted.\n'
        'User: Is it serious?\nSana: It can be.\n\n'
        'Current question: What should I avoid?',
      );
    });

    test('keeps only the most recent exchanges', () {
      final history = [
        for (var i = 1; i <= ChatRepository.maxContextExchanges + 2; i++)
          _msg(i, 'q$i', 'a$i'),
      ];
      final result = ChatRepository.buildPromptWithContext(
        prompt: 'now',
        history: history,
      );

      expect(result.contains('User: q1\n'), isFalse);
      expect(result.contains('User: q2\n'), isFalse);
      expect(result.contains('User: q3\n'), isTrue);
      expect(
        result.contains('User: q${ChatRepository.maxContextExchanges + 2}\n'),
        isTrue,
      );
    });

    test('trims long earlier replies', () {
      final longReply = 'x' * (ChatRepository.maxContextChars + 50);
      final result = ChatRepository.buildPromptWithContext(
        prompt: 'now',
        history: [_msg(1, 'q', longReply)],
      );

      expect(
        result.contains('x' * ChatRepository.maxContextChars + '...'),
        isTrue,
      );
      expect(result.contains(longReply), isFalse);
    });
  });
}
