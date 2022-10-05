import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_analytics_app/tabsPage.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  static FirebaseAnalytics analytics = FirebaseAnalytics();
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      navigatorObservers: [observer],
      home: FirebaseApp(analytics: analytics, observer: observer),
    );
  }
}

class FirebaseApp extends StatefulWidget {
  FirebaseApp({
    Key? key,
    required this.analytics,
    required this.observer,
  }) : super(key: key);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;

  @override
  State<FirebaseApp> createState() => _FirebaseAppState(analytics, observer);
}

class _FirebaseAppState extends State<FirebaseApp> {
  _FirebaseAppState(this.analytics, this.observer);

  final FirebaseAnalytics analytics;
  final FirebaseAnalyticsObserver observer;
  String _message = '';
  void setMessage(String message) {
    setState(() {
      _message = message;
    });
  }

  Future<void> _sendAnalyticsEvent() async {
    //애널리틱스의 로그이벤트를 호출해 test_event 라는 키값으로 데이터 저장
    await analytics.logEvent(
      name: 'test_event',
      parameters: <String, dynamic>{
        'string': 'hello flutter',
        'int': 100,
      },
    );
    setMessage('Analytics 보내기 성공');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('widget.title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _sendAnalyticsEvent,
              child: Text('테스트'),
            ),
            Text(
              _message,
              style: const TextStyle(color: Colors.blueAccent),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.tab),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) {
              return TabsPage(observer);
            }));
          }),
    );
  }
}
