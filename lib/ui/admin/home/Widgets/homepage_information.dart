import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:rcmasbusapp/app_theme.dart';
import 'package:rcmasbusapp/data/provider/firestore_repository_provider.dart';
import 'package:rcmasbusapp/data/provider/homepage_info_provider.dart';
import 'package:rcmasbusapp/ui/registration/Widgets/progress_indicator.dart';

class HomepageInformation extends HookWidget {
  const HomepageInformation({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = useProvider(informationStreamProvider);
    final info = useTextEditingController();
    return Card(
        shape: roundedRectangleBorder,
        child: InkWell(
          borderRadius: circularBorder,
          onTap: () {
            Get.generalDialog(
                pageBuilder: (_, __, ___) {
                  return Align(
                    alignment: Alignment.center,
                    child: Container(
                        // height: 300,
                        margin:
                            EdgeInsets.only(bottom: 50, left: 12, right: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(20),
                          child: Material(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Update Information',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                Gap(20),
                                TextField(
                                  minLines: 10,
                                  maxLines: 18,
                                  controller: info,
                                  decoration: inputDecoration('Information'),
                                ),
                                Gap(15),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TextButton(
                                        style: buttonStyle,
                                        onPressed: () => Get.back(),
                                        child: SizedBox(
                                          height: 36,
                                          width: Get.width / 2.8,
                                          child: Center(
                                            child: Text(
                                              'CANCEL',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        )),
                                    TextButton(
                                        style: buttonStyle,
                                        onPressed: () async {
                                          Get.back();
                                          await context
                                              .read(fireStoreRepositoryProvider)
                                              .updateInformation(info.text);
                                        },
                                        child: SizedBox(
                                          height: 36,
                                          width: Get.width / 2.8,
                                          child: Center(
                                            child: Text(
                                              'UPDATE',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ))
                                  ],
                                )
                              ],
                            ),
                          ),
                        )),
                  );
                },
                transitionBuilder: (context, a1, a2, widget) {
                  return Transform.scale(
                      scale: a1.value,
                      child: Opacity(
                        opacity: a1.value,
                        child: widget,
                      ));
                },
                transitionDuration: Duration(milliseconds: 200),
                barrierColor: Colors.black.withOpacity(0.5),
                barrierLabel: 'Barrier',
                barrierDismissible: true);
          },
          child: Container(
              padding: EdgeInsets.all(20),
              child: provider.when(
                  data: (data) {
                    info.text = data['data'] ?? '';
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Homepage Information',
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.w600),
                            ),
                            CupertinoSwitch(
                                value: data['enabled'] ?? '',
                                onChanged: (val) async {
                                  await context
                                      .read(fireStoreRepositoryProvider)
                                      .toggleInformation(val);
                                  await context.refresh(informationProvider);
                                })
                          ],
                        ),
                        Divider(
                          thickness: 0.8,
                        ),
                        Text(
                          data['data'],
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        )
                      ],
                    );
                  },
                  loading: () => CustomIndicator(),
                  error: (error, stack) => SizedBox())),
        ));
  }
}
