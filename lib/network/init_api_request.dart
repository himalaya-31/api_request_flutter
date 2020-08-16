import 'dart:convert';

import 'package:flutterrequest/network/api_request_callback.dart';
import 'package:flutterrequest/network/request_method.dart';
import 'package:flutterrequest/network/service_type.dart';
import 'package:http/http.dart' as http;

class InitApiRequest {
  String url; // end point url
  ServiceType serviceType; // service type enum
  RequestMethod method; // get or post
  Map bodyParams; // body parameters
  ApiRequestCallBack apiRequestCallBack; // network request callback

  InitApiRequest({
    this.url,
    this.serviceType,
    this.method,
    this.bodyParams,
    this.apiRequestCallBack
  });


  Future<void> getResponse() async {
    try {
      http.Response response;

      if(method == RequestMethod.POST) {
        response = await http.post(url, body: bodyParams);
      } else {
        response = await http.get(url);
      }

      apiRequestCallBack.getApiResponse(serviceType, jsonEncode(response.body));
    } catch (e) {
      apiRequestCallBack.onApiError(serviceType, e);
    }
  }
}