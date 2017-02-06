library nggrid.header_renderers.header_renderer_base;

import 'package:ng_grid/grid/core/grid_column.dart';

abstract class HeaderRendererBase {

  //-----------------------------
  // Public Properties
  //-----------------------------

  GridColumn gridColumn;

  //-----------------------------
  // Constructor
  //-----------------------------

  HeaderRendererBase();
}