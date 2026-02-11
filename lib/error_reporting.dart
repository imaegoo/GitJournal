/*
 * SPDX-FileCopyrightText: 2019-2021 Vishesh Handa <me@vhanda.in>
 *
 * SPDX-License-Identifier: AGPL-3.0-or-later
 */

import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:gitjournal/logger/logger.dart';
import 'package:gitjournal/settings/app_config.dart';

Future<void> initSentry() async {
  // Telemetry disabled
}

void flutterOnErrorHandler(FlutterErrorDetails details) {
  if (reportCrashes == true) {
    // vHanda: This doesn't always call our zone error handler, why?
    // Zone.current.handleUncaughtError(details.exception, details.stack);
    reportError(details.exception, details.stack ?? StackTrace.current);
  } else {
    FlutterError.dumpErrorToConsole(details);
  }
}

bool get reportCrashes => _reportCrashes ??= _initReportCrashes();
bool? _reportCrashes;
bool _initReportCrashes() {
  return !kDebugMode && AppConfig.instance.collectCrashReports;
}

Future<void> reportError(Object error, StackTrace stackTrace) async {
  assert(error is Exception || error is Error);
  Log.e("Uncaught Exception", ex: error, stacktrace: stackTrace);
}

// Dart makes a distiction between Errors and Exceptions
// so we need to use dynamic
Future<void> logException(Object e, StackTrace stackTrace) async {
  assert(e is Exception || e is Error);
  Log.e("Got Exception", ex: e, stacktrace: stackTrace);
}

Future<void> logExceptionWarning(Object e, StackTrace stackTrace) async {
  assert(e is Exception || e is Error);
  Log.e("Got Exception", ex: e, stacktrace: stackTrace);
}

void captureErrorBreadcrumb(String name, Map<String, String> parameters) {
  // Telemetry disabled
}
