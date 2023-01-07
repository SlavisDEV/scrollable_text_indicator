import 'package:flutter/material.dart';
import 'package:scrollable_text_indicator/scrollable_text_indicator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Scrollable Text Indicator Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Scrollable Text Indicator Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: const [
            Text(
              'Text title',
              style: TextStyle(
                fontSize: 22.0,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            Flexible(
              child: ScrollableTextIndicator(
                text: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam pulvinar risus sit amet augue viverra ultrices. Aliquam erat volutpat. Proin sagittis ultricies blandit. Donec diam velit, vestibulum commodo leo eu, suscipit condimentum ante. Aenean laoreet sapien mauris. Praesent maximus sagittis felis auctor facilisis. In ullamcorper velit id leo semper, pellentesque luctus risus efficitur. Aenean et tristique diam, vitae volutpat mi. Morbi bibendum ut nibh a ornare. Nulla nec dolor pellentesque, gravida neque ut, condimentum augue. Phasellus mollis metus ac tincidunt venenatis. Aenean at ullamcorper massa. Vestibulum volutpat nunc ut ultrices facilisis. Cras dui lorem, vehicula eu hendrerit non, sollicitudin quis libero. Morbi dapibus libero tincidunt lobortis efficitur.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
