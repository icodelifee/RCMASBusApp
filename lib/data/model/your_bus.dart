import 'package:rcmasbusapp/data/model/bus.dart';
import 'package:rcmasbusapp/data/model/bus_pass.dart';
import 'package:rcmasbusapp/data/model/route.dart';

class YourBus {
  YourBus({this.route, this.bus, this.busPass});
  Route? route;
  BusPass? busPass;
  Bus? bus;
}
