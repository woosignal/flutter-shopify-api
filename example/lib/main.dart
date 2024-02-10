import 'package:flutter/material.dart';
import 'package:woosignal_shopify/models/response/shopify_product_response.dart';
import 'package:woosignal_shopify/woosignal_shopify.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WooSignal Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'WooSignal Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? _productName;

  _incrementCounter() async {
    // Add your WooSignal API key here
    await WooSignalShopify.instance.init(appKey: "your app key");

    ShopifyProductResponse? shopifyProductResponse =
        await WooSignalShopify.instance.getProducts();
    if ((shopifyProductResponse?.products ?? []).isNotEmpty) {
      _productName = shopifyProductResponse?.products?[0].title ?? "";
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Tap the light bulb to get a product'),
            if (_productName != null)
              Text(
                'Shopify product :\n $_productName',
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.lightbulb_outline),
      ),
    );
  }
}
