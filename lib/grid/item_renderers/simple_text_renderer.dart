import 'package:angular2/angular2.dart';

import 'package:ng_grid/grid/item_renderers/item_renderer_base.dart';

@Component(
    changeDetection: ChangeDetectionStrategy.Stateful,
    encapsulation: ViewEncapsulation.None,
    preserveWhitespace: false,
    selector: 'simple-text-renderer',
    template: '<div>{{resolveLabel()}}</div>')
class SimpleTextRenderer extends ItemRendererBase<dynamic> {
  //-----------------------------
  // Constructor
  //-----------------------------

  SimpleTextRenderer() {
    // Fixes null-pointer exception
    stateChangeCallback = () {};
  }

  //-----------------------------
  // Public Methods
  //-----------------------------

  @override
  set data(dynamic value) {
    setState(() => super.data = value);
  }
}
