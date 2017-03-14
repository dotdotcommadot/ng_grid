library nggrid.core.grid_column;

import 'package:angular2/angular2.dart';
import 'package:ng_grid/grid/header_renderers/simple_header_renderer.dart';
import 'package:ng_grid/grid/infrastructure/sort_service.dart';
import 'package:ng_grid/grid/item_renderers/simple_text_renderer.dart';

typedef dynamic LabelHandler(dynamic data);

@Component(
  changeDetection: ChangeDetectionStrategy.Default,
  encapsulation: ViewEncapsulation.None,
  preserveWhitespace: false,
  selector: 'grid-column',
  template: ''
)
class GridColumn {

  //-----------------------------
  // Input
  //-----------------------------

  @Input() Type itemRenderer = SimpleTextRenderer;

  @Input() Type headerRenderer = SimpleHeaderRenderer;

  @Input() String title = '';

  @Input() LabelHandler labelHandler;

  @Input() SortHandler sortHandler;

  @Input() Map<String, dynamic> properties = {};

  bool get isSortable => sortHandler != null;

  //-----------------------------
  // Constructor
  //-----------------------------

  GridColumn();
}