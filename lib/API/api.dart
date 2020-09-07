import 'dart:convert' show utf8;
// import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;


String utf8convert(String text) {
  List<int> bytes = text.toString().codeUnits;
  return utf8.decode(bytes);
}

Future<RssFeed> loadFeed(url) async {
  try {
    final client = http.Client();
    final response = await client.get(url);
    //  print('+++++++++++++' + response.body);
    var decoded = utf8convert(response.body);
    return RssFeed.parse(decoded);
  } catch (e) {
    print(e);
  }
  return null;
}
