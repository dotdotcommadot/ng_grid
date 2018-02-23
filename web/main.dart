import 'package:angular2/platform/browser.dart';

import 'package:ng_grid/app_component.dart';
import 'package:ng2_state/ng2_state.dart';

void main() {
  StateContainer.DO_SCAN();
  SerializableTuple1.DO_SCAN<Null>();
  SerializableTuple2.DO_SCAN<Null, Null>();
  SerializableTuple3.DO_SCAN<Null, Null, Null>();
  SerializableTuple4.DO_SCAN<Null, Null, Null, Null>();

  bootstrap(AppComponent);
}
