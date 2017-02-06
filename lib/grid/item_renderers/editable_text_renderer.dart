library nggrid.item_renderers.editable_text_renderer;

import 'package:angular2/angular2.dart';
import 'package:ng_grid/grid/item_renderers/item_renderer_base.dart';

@Component(
  changeDetection: ChangeDetectionStrategy.Default,
  encapsulation: ViewEncapsulation.Emulated,
  preserveWhitespace: false,
  selector: 'editable-text-renderer',
  template: '<div contentEditable="true">{{resolveLabel()}}</div>'
)
class EditableTextRenderer extends ItemRendererBase {

  //-----------------------------
  // Constructor
  //-----------------------------

  EditableTextRenderer();

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