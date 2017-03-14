library nggrid.header_renderers.simple_header_renderer;

import 'package:angular2/angular2.dart';
import 'package:ng_grid/grid/header_renderers/header_renderer_base.dart';

@Component(
  changeDetection: ChangeDetectionStrategy.Default,
  encapsulation: ViewEncapsulation.None,
  preserveWhitespace: false,
  selector: 'simple-header-renderer',
  template: '<div>{{gridColumn?.title}}</div>'
)
class SimpleHeaderRenderer extends HeaderRendererBase {

  //-----------------------------
  // Constructor
  //-----------------------------

  SimpleHeaderRenderer();
}