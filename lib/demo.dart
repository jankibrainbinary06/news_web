import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:news_web_app/screens/news_screen/widgets/edit_news_popup.dart';

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: dashboardController.Users.snapshots(),
        builder: (context, snapshot) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // HtmlWidget(
                  //   '''<h3>Demo</h3>''',
                  //   textStyle: TextStyle(fontSize: 50),
                  //   // turn on `webView` if you need IFRAME support (it's disabled by default)
                  // ),
                  Text("dsfhs", style: TextStyle(fontSize: 18)),
                ],
              ),
              SizedBox(
                height: 300,
                child: CachedNetworkImage(
                  imageUrl: snapshot.data!.docs[2]['subcategory'][0]['Data']
                      ['ImageUrl'],
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
