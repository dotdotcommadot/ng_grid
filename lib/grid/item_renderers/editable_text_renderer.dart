import 'package:angular2/angular2.dart';

import 'package:ng_grid/grid/item_renderers/item_renderer_base.dart';

@Component(
    changeDetection: ChangeDetectionStrategy.Stateful,
    encapsulation: ViewEncapsulation.None,
    preserveWhitespace: false,
    selector: 'editable-text-renderer',
    template: '<div contentEditable="true">{{resolveLabel()}}</div>')
class EditableTextRenderer extends ItemRendererBase<dynamic> {
  //-----------------------------
  // Constructor
  //-----------------------------

  EditableTextRenderer();

  //-----------------------------
  // Public Methods
  //-----------------------------

  @override
  String resolveLabel() {
    if (gridColumn == null || data == null) {
      return '';
    }

    if (gridColumn.labelHandler != null) {
      return gridColumn.labelHandler(data);
    }

    return '';
  }
}
