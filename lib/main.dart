import 'package:flutter/material.dart';
import 'package:flutterrequest/network/api_request_callback.dart';
import 'package:flutterrequest/network/init_api_request.dart';
import 'package:flutterrequest/network/request_method.dart';
import 'package:flutterrequest/network/service_type.dart';
import 'user_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> implements ApiRequestCallBack {
  UserModel _user;

  String url = "https://jsonplaceholder.typicode.com/posts";

  void initApiRequest(ServiceType serviceType, RequestMethod method) {
    InitApiRequest initApiRequest = InitApiRequest(
        url: url,
        serviceType: serviceType,
        method: method,
        bodyParams: createBodyParam(serviceType),
        apiRequestCallBack: this);
    initApiRequest.getResponse();
  }

  // create body parameter for service type
  Map createBodyParam(ServiceType serviceType) {
    Map map = Map();

    switch (serviceType) {
      case ServiceType.HomeData:
        map = {"title": "foo", "body": "bar", "userId": "2"};
        break;
    }
    return map;
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            TextField(),
            TextField(),
            SizedBox(
              height: 32,
            ),
            _user == null
                ? Container()
                : Text(
                    "The user ${_user.name}, ${_user.id} is created successfully at time ${_user.createdAt.toIso8601String()}")
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          initApiRequest(ServiceType.HomeData, RequestMethod.POST);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  @override
  void getApiResponse(ServiceType serviceType, String response) {
    print("On response:" + response);
  }

  @override
  void onApiError(ServiceType serviceType, Exception e) {
    print("Error occured: $e");
  }
}
