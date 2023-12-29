import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
class AppVersionWidget extends StatefulWidget {
  const AppVersionWidget({super.key});

  @override
  _AppVersionWidgetState createState() => _AppVersionWidgetState();
}

class _AppVersionWidgetState extends State<AppVersionWidget> {
  String appVersion = 'Loading...';

  @override
  void initState() {
    super.initState();
    _getAppVersion();
  }

  Future<void> _getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text('Version: $appVersion');
  }
}