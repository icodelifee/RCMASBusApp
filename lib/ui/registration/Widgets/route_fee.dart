import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/ui/registration/registration_page_viewmodel.dart';

class RouteFeeText extends HookWidget {
  const RouteFeeText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(registrationPageViewModelProvider);
    return Visibility(
      visible: provider.routeMap != null,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Route Fee',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              'Rs ${provider.routeMap?['route_fee'] ?? 'Not Provided'}',
              style: TextStyle(fontSize: 20),
            )
          ],
        ),
      ),
    );
  }
}
