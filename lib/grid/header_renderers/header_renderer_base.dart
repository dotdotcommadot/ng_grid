library nggrid.header_renderers.header_renderer_base;

import 'package:angular2/angular2.dart';
import 'package:ng_grid/grid/core/grid_column.dart';

abstract class HeaderRendererBase extends ComponentState {

  //-----------------------------
  // Public Properties
  //-----------------------------

  GridColumn gridColumn;

  //-----------------------------
  // Constructor
  //-----------------------------

  HeaderRendererBase();
}