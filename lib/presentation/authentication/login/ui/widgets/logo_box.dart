import 'package:flutter/material.dart';

import '../../../../../utils/constants/image_strings.dart';
class LogoBox extends StatelessWidget {
  const LogoBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 150,
        maxWidth: 150,
      ),
      child: Image.asset(
        AppImages.school,
      ),
    );
  }
}