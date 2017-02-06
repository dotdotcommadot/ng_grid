library nggrid.item_renderers.simple_text_renderer;

import 'package:angular2/angular2.dart';
import 'package:ng_grid/grid/item_renderers/item_renderer_base.dart';

@Component(
  changeDetection: ChangeDetectionStrategy.Default,
  encapsulation: ViewEncapsulation.Emulated,
  preserveWhitespace: false,
  selector: 'simple-text-renderer',
  template: '<div>{{resolveLabel()}}</div>'
)
class SimpleTextRenderer extends ItemRendererBase {

  //-----------------------------
  // Constructor
  //-----------------------------

  SimpleTextRenderer();
}