import 'package:flutter/foundation.dart';
import '../utils/log_print.dart';

class AppApiUrl {
  AppApiUrl._privateConstructor();
  static final AppApiUrl _instance = AppApiUrl._privateConstructor();
  static AppApiUrl get instance => _instance;

  // ==================== Domain ====================
  static final String domain = _getDomain();
  static final String socket = _getDomain();
  final String baseUrl = "$domain/api/v1";
  final String imgBaseUrl = domain;

  // ==================== Auth ====================
  final String register = "/users";

  // ==================== Profile ====================
  final String userProfile = "/users/profile";
  final String refreshToken = "/refreshToken";

  // ==================== Banner ====================
  final String banner = "/banners";

// ==================== [ADD YOUR ENDPOINTS BELOW] ====================
// Example:
// final String products = "/products";
// final String orders   = "/orders";
}

String _getDomain() {
  const String liveServer  = "https://your-live-api.com";   // 🔴 Replace with live URL
  const String localServer = "http://10.10.7.41:5005";      // 🟡 Your local dev server

  try {
    if (kDebugMode) return localServer;
    return liveServer;
  } catch (e) {
    errorLog("_getDomain", e);
    return localServer;
  }
}