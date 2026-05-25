import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'endpoints.dart';
import 'request_log.dart';
import 'widgets.dart';

class EndpointRunnerPage extends StatefulWidget {
  final Endpoint endpoint;
  const EndpointRunnerPage({super.key, required this.endpoint});

  @override
  State<EndpointRunnerPage> createState() => _EndpointRunnerPageState();
}

class _EndpointRunnerPageState extends State<EndpointRunnerPage> {
  late final Map<String, TextEditingController> _controllers;
  bool _running = false;
  RequestLogEntry? _lastEntry;

  @override
  void initState() {
    super.initState();
    _controllers = {
      for (final input in widget.endpoint.inputs)
        input.key: TextEditingController(text: input.defaultValue ?? ''),
    };
  }

  @override
  void dispose() {
    for (final c in _controllers.values) {
      c.dispose();
    }
    super.dispose();
  }

  Future<void> _run() async {
    if (_running) return;
    setState(() => _running = true);
    final inputs = {
      for (final e in _controllers.entries) e.key: e.value.text,
    };
    final entry = await runEndpoint(widget.endpoint, inputs);
    if (!mounted) return;
    setState(() {
      _running = false;
      _lastEntry = entry;
    });
    if (widget.endpoint.persistsSession &&
        entry.succeeded &&
        entry.result != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final endpoint = widget.endpoint;
    final entry = _lastEntry;
    return Scaffold(
      appBar: AppBar(
        title: Text(endpoint.title),
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Text(endpoint.description,
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 8),
            Wrap(
              spacing: 6,
              children: [
                Chip(
                    label: Text(endpoint.group),
                    visualDensity: VisualDensity.compact),
                if (endpoint.requiresAuth)
                  const Chip(
                    label: Text('requires auth'),
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            const SizedBox(height: 16),
            if (endpoint.inputs.isNotEmpty) ...[
              Text('Parameters', style: Theme.of(context).textTheme.titleSmall),
              const SizedBox(height: 8),
              for (final input in endpoint.inputs) ...[
                TextField(
                  controller: _controllers[input.key],
                  keyboardType: input.keyboardType,
                  obscureText: input.obscureText,
                  maxLines:
                      input.keyboardType == TextInputType.multiline ? 4 : 1,
                  decoration: InputDecoration(
                    labelText: input.label,
                    hintText: input.hint,
                    border: const OutlineInputBorder(),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ],
            FilledButton.icon(
              onPressed: _running ? null : _run,
              icon: _running
                  ? const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                          strokeWidth: 2, color: Colors.white),
                    )
                  : const Icon(Icons.play_arrow),
              label: Text(_running ? 'Running…' : 'Run'),
            ),
            const SizedBox(height: 24),
            if (entry != null) _ResultCard(entry: entry),
          ],
        ),
      ),
    );
  }
}

class _ResultCard extends StatelessWidget {
  final RequestLogEntry entry;
  const _ResultCard({required this.entry});

  @override
  Widget build(BuildContext context) {
    final success = entry.succeeded;
    final body = entry.error ?? prettyJson(entry.result);
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  success ? Icons.check_circle : Icons.error,
                  color: success ? Colors.green : Colors.red,
                  size: 18,
                ),
                const SizedBox(width: 6),
                Text(
                  success
                      ? (entry.result == null ? 'null response' : 'Success')
                      : 'Error',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                Text('${entry.duration.inMilliseconds} ms',
                    style:
                        TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                IconButton(
                  icon: const Icon(Icons.copy, size: 18),
                  tooltip: 'Copy',
                  onPressed: () {
                    Clipboard.setData(ClipboardData(text: body));
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Copied to clipboard')),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (success && entry.result == null)
              Text(
                'The SDK returned null. This usually means the server returned an error '
                'or an empty result. Enable debugMode on init() to see details in the console.',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 12),
              )
            else
              JsonView(json: body),
          ],
        ),
      ),
    );
  }
}
