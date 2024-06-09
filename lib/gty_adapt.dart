adapt<K>(dynamic data, Function(Map<String, dynamic>) toJson) {
  return toJson(data) as K;
}

List<K> adaptList<K>(List<dynamic> data, Function(Map<String, dynamic>) toJson) {
  return data.map((e) => toJson(e) as K).toList();
}
