import 'package:flutter/material.dart';
import 'package:woosignal_shopify_api/woosignal_shopify_api.dart';

import 'endpoint_runner_page.dart';
import 'endpoints.dart';
import 'widgets.dart';

const String _appKey = String.fromEnvironment('WOOSIGNAL_KEY');

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (_appKey.isNotEmpty) {
    await WooSignalShopify.instance.init(
      appKey: _appKey,
      debugMode: true,
    );
  }
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WooSignal Shopify Explorer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: Colors.indigo,
        useMaterial3: true,
      ),
      home: const ApiExplorerPage(),
    );
  }
}

class ApiExplorerPage extends StatefulWidget {
  const ApiExplorerPage({super.key});

  @override
  State<ApiExplorerPage> createState() => _ApiExplorerPageState();
}

class _ApiExplorerPageState extends State<ApiExplorerPage> {
  String _filter = '';

  Future<void> _openEndpoint(Endpoint endpoint) async {
    if (_appKey.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Set WOOSIGNAL_KEY via --dart-define first.')),
      );
      return;
    }
    await Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => EndpointRunnerPage(endpoint: endpoint)),
    );
    if (mounted) setState(() {});
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Log out?'),
        content: const Text('This clears the persisted customer session.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: const Text('Cancel')),
          FilledButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: const Text('Log out')),
        ],
      ),
    );
    if (confirmed != true) return;
    await WooSignalShopify.authLogout();
    if (mounted) setState(() {});
  }

  List<Endpoint> _filtered(List<Endpoint> all) {
    if (_filter.isEmpty) return all;
    final q = _filter.toLowerCase();
    return all
        .where((e) =>
            e.title.toLowerCase().contains(q) ||
            e.description.toLowerCase().contains(q))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final groups = kEndpointsByGroup;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopify API Explorer'),
        actions: [
          AuthChip(onLogout: _logout),
          IconButton(
            icon: const Icon(Icons.receipt_long),
            tooltip: 'Request log',
            onPressed: () => showRequestLogSheet(context),
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: Column(
          children: [
            if (_appKey.isEmpty) const ApiKeyBanner(),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
              child: TextField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Filter endpoints…',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
                onChanged: (v) => setState(() => _filter = v),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 8),
                children: [
                  for (final group in groups.keys)
                    _GroupSection(
                      title: group,
                      endpoints: _filtered(groups[group]!),
                      onTap: _openEndpoint,
                    ),
                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      'SDK v${WooSignalShopify.instance.version} · '
                      '${kEndpoints.length} endpoints',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GroupSection extends StatelessWidget {
  final String title;
  final List<Endpoint> endpoints;
  final ValueChanged<Endpoint> onTap;
  const _GroupSection({
    required this.title,
    required this.endpoints,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (endpoints.isEmpty) return const SizedBox.shrink();
    return ExpansionTile(
      initiallyExpanded: true,
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text('${endpoints.length} endpoints'),
      children: [
        for (final e in endpoints)
          ListTile(
            title:
                Text(e.title, style: const TextStyle(fontFamily: 'monospace')),
            subtitle: Text(e.description,
                maxLines: 2, overflow: TextOverflow.ellipsis),
            trailing: e.requiresAuth
                ? const Icon(Icons.lock_outline, size: 16)
                : const Icon(Icons.chevron_right),
            onTap: () => onTap(e),
          ),
      ],
    );
  }
}
