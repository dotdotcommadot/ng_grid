library nggrid.item_renderers.simple_text_renderer;

import 'package:angular2/angular2.dart';
import 'package:ng_grid/grid/item_renderers/item_renderer_base.dart';

@Component(
  changeDetection: ChangeDetectionStrategy.Stateful,
  encapsulation: ViewEncapsulation.None,
  preserveWhitespace: false,
  selector: 'simple-text-renderer',
  template: '<div>{{resolveLabel()}}</div>'
)
class SimpleTextRenderer extends ItemRendererBase {

  @override void set data(dynamic value) {
    setState(() => super.data = value);
  }

  //-----------------------------
  // Constructor
  //-----------------------------

  SimpleTextRenderer() {

    // Fixes null-pointer exception
    stateChangeCallback = (){};
  }
}