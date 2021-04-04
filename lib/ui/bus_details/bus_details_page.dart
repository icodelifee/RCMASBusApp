import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/ui/bus_details/bus_details_viewmodel.dart';
import 'package:rcmasbusapp/ui/home/home_page_viewmodel.dart';

class BusDetailsPage extends HookWidget {
  @override
  Widget build(BuildContext context) {
    final bpProvider = useProvider(yourBusProvider);
    final state = useProvider(busDetailsViewProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Bus Details'),
      ),
      body: Stack(
        children: [
          Positioned(
              bottom: 0,
              right: -100,
              child: Opacity(
                opacity: 0.3,
                child: Image.asset(
                  'assets/bus.png',
                  fit: BoxFit.cover,
                  // height: 100,
                  scale: 0.8,
                ),
              )),
          Container(
              width: Get.width,
              padding: EdgeInsets.all(20),
              child: bpProvider.when(
                  data: (data) {
                    final driver = useFuture(
                        useMemoized(() => state.getDriver(data.bus!.driverId!)),
                        initialData: null);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bus Details',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        Gap(10),
                        Text(
                          'Bus Number',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.bus!.busNo!,
                          style: TextStyle(fontSize: 21),
                        ),
                        Gap(25),
                        Text(
                          'Bus License Number',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          data.bus!.busLicenseNo!,
                          style: TextStyle(fontSize: 21),
                        ),
                        Gap(10),
                        Divider(),
                        Gap(10),
                        Text(
                          'Driver Details',
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        ),
                        driver.hasData
                            ? Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Gap(20),
                                  Text(
                                    'Driver Name',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    '${driver.data!.firstName} ${driver.data!.lastName}',
                                    style: TextStyle(fontSize: 21),
                                  ),
                                  Gap(20),
                                  Text(
                                    'Phone Number',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    driver.data!.phone!,
                                    style: TextStyle(fontSize: 21),
                                  )
                                ],
                              )
                            : SizedBox()
                      ],
                    );
                  },
                  loading: () => CircularProgressIndicator(),
                  error: (error, trace) => SizedBox())),
        ],
      ),
    );
  }
}
