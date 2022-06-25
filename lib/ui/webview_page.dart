import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:suitmedia_test_flutter_dev/helper/color_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  static const routeName = '/webViewPage';
  const WebViewPage({Key? key}) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
 final ValueNotifier<double> _progress = ValueNotifier(0.0);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
       navigationBar:  CupertinoNavigationBar(
         leading: GestureDetector(
            child: SvgPicture.asset('assets/images/ic_arrow_left.svg'),
            onTap: () {
              Navigator.of(context).pop();
            }),
        middle: const Text(''),
      ),
      child: SafeArea(
        child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.transparent,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  child: ValueListenableBuilder(
                    valueListenable: _progress,
                    builder: (context,double value,_) {
                      if (value == 100) {
                        return Container();
                      } else {
                        return LinearProgressIndicator(value: value/100,);
                      }
                      
                    }
                  ),
                ),
                Expanded(
                  child: WebView(
                    initialUrl: 'https://suitmedia.com/',
                    javascriptMode: JavascriptMode.unrestricted,
                    onProgress: (int progress) {
                      print('WebView is loading (progress : $progress%)');
                      _progress.value = progress.toDouble();
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
