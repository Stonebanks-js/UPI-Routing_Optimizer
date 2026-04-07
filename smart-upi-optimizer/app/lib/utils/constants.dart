import 'package:flutter/material.dart';

/// Global constants for the application

/// Base URL for the FastAPI backend. 10.0.2.2 is used to access localhost from the Android emulator.
const kBaseUrl = 'http://10.0.2.2:8000';

/// The list of supported UPI apps
const kUpiApps = ['gpay', 'phonepe', 'paytm'];

/// Mapping of app identifiers to their Android package names
const kUpiPackageNames = {
  'gpay': 'com.google.android.apps.nbu.paisa.user',
  'phonepe': 'com.phonepe.app',
  'paytm': 'net.one97.paytm',
};

// Colors for the UI
const kGreen = Colors.green;
const kOrange = Colors.orange;
const kRed = Colors.red;
const kPrimary = Colors.blue;
