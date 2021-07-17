import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:breakq/utils/console.dart';

/// Provides a generic mechanism for loading model data from JSON files
/// (API simulation).
class DataProvider {
  const DataProvider();

  Future<List<dynamic>> get(uri) async {
    try {
      final rawData = await http.get(uri);
      if (rawData.statusCode >= 200 && rawData.statusCode < 300) {
        return rawData.body.isNotEmpty
            ? jsonDecode(rawData.body) as List<dynamic>
            : [];
      }
    } catch (_) {
      Console.log('DataProvider::get', _.toString(), error: _);
      return [];
    }
    return [];
  }

  Future<Map<String, dynamic>> getAsMap(uri) async {
    try {
      final rawData = await http.get(uri);
      if (rawData.statusCode >= 200 && rawData.statusCode < 300) {
        return rawData.body.isNotEmpty
            ? jsonDecode(rawData.body) as Map<String, dynamic>
            : {};
      }
    } catch (_) {
      Console.log('DataProvider::get', _.toString(), error: _);
      return {};
    }
    return {};
  }
}
