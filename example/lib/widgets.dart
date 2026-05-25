import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:woosignal_shopify_api/woosignal_shopify_api.dart';

import 'request_log.dart';

const _jsonEncoder = JsonEncoder.withIndent('  ');

String prettyJson(Object? value) {
  final normalized = _jsonify(value);
  try {
    return _jsonEncoder.convert(normalized);
  } catch (_) {
    return value.toString();
  }
}

Object? _jsonify(Object? value) {
  if (value == null) return null;
  if (value is String || value is num || value is bool) return value;
  if (value is Map) {
    return value.map((k, v) => MapEntry(k.toString(), _jsonify(v)));
  }
  if (value is List) return value.map(_jsonify).toList();
  try {
    return _jsonify((value as dynamic).toJson());
  } catch (_) {
    return value.toString();
  }
}

class JsonView extends StatelessWidget {
  final String json;
  const JsonView({super.key, required this.json});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: SelectableText(
        json,
        style:
            const TextStyle(fontFamily: 'monospace', fontSize: 12, height: 1.4),
      ),
    );
  }
}

class ApiKeyBanner extends StatelessWidget {
  const ApiKeyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.amber.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.orange),
            const SizedBox(width: 8),
            Expanded(
              child: SelectableText(
                'No WooSignal app key configured. Run with:\n'
                'flutter run --dart-define=WOOSIGNAL_KEY=your_key',
                style: TextStyle(color: Colors.brown.shade900, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AuthChip extends StatelessWidget {
  final VoidCallback onLogout;
  const AuthChip({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    bool loggedIn = false;
    try {
      loggedIn = WooSignalShopify.authUserLoggedIn();
    } catch (_) {
      loggedIn = false;
    }
    final scheme = Theme.of(context).colorScheme;
    if (!loggedIn) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Align(
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.person_outline,
                  size: 16, color: scheme.onSurfaceVariant),
              const SizedBox(width: 4),
              Text(
                'Guest',
                style: TextStyle(fontSize: 13, color: scheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton.icon(
        icon: Icon(Icons.person, size: 16, color: scheme.primary),
        label: Text('Log out', style: TextStyle(color: scheme.primary)),
        onPressed: onLogout,
      ),
    );
  }
}

void showRequestLogSheet(BuildContext context) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (ctx) => DraggableScrollableSheet(
      initialChildSize: 0.7,
      maxChildSize: 0.95,
      minChildSize: 0.3,
      expand: false,
      builder: (ctx, scrollController) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Text('Request log',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                  const Spacer(),
                  TextButton.icon(
                    icon: const Icon(Icons.delete_sweep_outlined, size: 18),
                    label: const Text('Clear'),
                    onPressed: () {
                      requestLog.clear();
                    },
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: AnimatedBuilder(
                animation: requestLog,
                builder: (_, __) {
                  final entries = requestLog.entries;
                  if (entries.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(32),
                        child: Text(
                            'No requests yet. Run an endpoint to see it logged here.',
                            textAlign: TextAlign.center),
                      ),
                    );
                  }
                  return ListView.separated(
                    controller: scrollController,
                    itemCount: entries.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (_, idx) {
                      final e = entries[idx];
                      return ListTile(
                        leading: Icon(
                          e.succeeded ? Icons.check_circle : Icons.error,
                          color: e.succeeded ? Colors.green : Colors.red,
                        ),
                        title: Text('${e.group} · ${e.endpoint}'),
                        subtitle: Text(
                          '${e.duration.inMilliseconds}ms · ${_formatTime(e.timestamp)}'
                          '${e.error != null ? '\n${e.error}' : ''}',
                        ),
                        isThreeLine: e.error != null,
                        trailing: IconButton(
                          icon: const Icon(Icons.copy, size: 18),
                          tooltip: 'Copy result JSON',
                          onPressed: () {
                            final body = e.error ?? prettyJson(e.result);
                            Clipboard.setData(ClipboardData(text: body));
                            ScaffoldMessenger.of(ctx).showSnackBar(
                              const SnackBar(
                                  content: Text('Copied to clipboard')),
                            );
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    ),
  );
}

String _formatTime(DateTime t) {
  String two(int v) => v.toString().padLeft(2, '0');
  return '${two(t.hour)}:${two(t.minute)}:${two(t.second)}';
}
