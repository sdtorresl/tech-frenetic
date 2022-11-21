import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({Key? key, required this.sessionId}) : super(key: key);
  final String sessionId;

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late WebViewController _controller;

  final kStripeHtmlPage = '''
<!DOCTYPE html>
<html>
<script src="https://js.stripe.com/v3/"></script>
<head><title>Stripe checkout</title></head>
<body>
</body>
</html>
''';

  String get initialUrl =>
      'data:text/html;base64,${base64Encode(const Utf8Encoder().convert(kStripeHtmlPage))}';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: TFAppBar(),
      body: SafeArea(
        child: WebView(
            initialUrl: initialUrl,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (controller) => _controller = controller,
            onPageFinished: (String url) {
              if (url == initialUrl) {
                _redirectToStripe();
              }
            },
            navigationDelegate: (NavigationRequest request) {
              if (request.url
                  .startsWith('https://techfrenetic.com/en/success')) {
                Navigator.of(context).pop(true);
              } else if (request.url
                  .startsWith('https://techfrenetic.com/en/canceled')) {
                Navigator.of(context).pop(false);
              }

              return NavigationDecision.navigate;
            }),
      ),
    );
  }

  void _redirectToStripe() {
    final redirectToCheckoutJs = '''
var stripe = Stripe('${GlobalConfiguration().getValue('stripe_key')}');

stripe.redirectToCheckout({
  sessionId: '${widget.sessionId}'
}).then(function (result) {
  result.error.message = 'Error'
});
''';
    _controller.runJavascript(redirectToCheckoutJs);
  }
}
