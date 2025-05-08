import '../emotion.dart';

class JournalEntry {
  final int? id;
  final Emotion emotion;
  final String note;
  final DateTime timestamp;

  JournalEntry({
    this.id,
    required this.emotion,
    required this.note,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'emotion': emotion.name,
      'note': note,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory JournalEntry.fromMap(Map<String, dynamic> map) {
    return JournalEntry(
      id: map['id'],
      emotion: Emotion.values.byName(map['emotion']),
      note: map['note'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }

  @override
  String toString() {
    return 'JournalEntry{id: $id, emotion: $emotion, note: $note, timestamp: $timestamp}';
  }
}
