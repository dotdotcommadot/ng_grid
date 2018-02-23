import 'package:angular2/angular2.dart';

import 'package:ng_grid/grid/item_renderers/item_renderer_base.dart';

@Component(
    selector: 'checkbox-renderer',
    template: '<input type="checkbox" [(checked)]="data.boolValue" />')
class CheckBoxRenderer extends ItemRendererBase<dynamic> {
  //-----------------------------
  // Constructor
  //-----------------------------

  CheckBoxRenderer();
}
