library nggrid.item_renderers.item_renderer_base;

import 'package:angular2/angular2.dart';
import 'package:ng_grid/grid/core/grid_column.dart';

abstract class ItemRendererBase {

  //-----------------------------
  // Public Properties
  //-----------------------------

  GridColumn gridColumn;

  dynamic data;

  //-----------------------------
  // Constructor
  //-----------------------------

  ItemRendererBase();

  //-----------------------------
  // Public Methods
  //-----------------------------

  String resolveLabel() {

    if (gridColumn == null ||
        data == null) {
      return '';
    }

    if (gridColumn.labelHandler != null) {
      return gridColumn.labelHandler(data);
    }

    return '';
  }
}