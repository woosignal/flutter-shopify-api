import 'package:flutter/foundation.dart';

class RequestLogEntry {
  final DateTime timestamp;
  final String endpoint;
  final String group;
  final Map<String, String> inputs;
  final Duration duration;
  final Object? result;
  final String? error;
  final String? stackTrace;

  RequestLogEntry({
    required this.timestamp,
    required this.endpoint,
    required this.group,
    required this.inputs,
    required this.duration,
    this.result,
    this.error,
    this.stackTrace,
  });

  bool get succeeded => error == null;
  bool get hasResult => result != null;
}

class RequestLog extends ChangeNotifier {
  final List<RequestLogEntry> _entries = [];

  List<RequestLogEntry> get entries => List.unmodifiable(_entries.reversed);
  int get length => _entries.length;

  void add(RequestLogEntry entry) {
    _entries.add(entry);
    if (_entries.length > 100) {
      _entries.removeRange(0, _entries.length - 100);
    }
    notifyListeners();
  }

  void clear() {
    if (_entries.isEmpty) return;
    _entries.clear();
    notifyListeners();
  }
}

final RequestLog requestLog = RequestLog();
