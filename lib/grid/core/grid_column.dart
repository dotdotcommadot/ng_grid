import 'dart:async';

import 'package:angular2/angular2.dart';

import 'package:ng_grid/grid/header_renderers/simple_header_renderer.dart';
import 'package:ng_grid/grid/infrastructure/sort_service.dart';
import 'package:ng_grid/grid/item_renderers/simple_text_renderer.dart';

typedef String LabelHandler(dynamic data);

typedef dynamic ValueHandler(dynamic data);

typedef dynamic ActionHandler(dynamic data);

typedef List<dynamic> LinkHandler(dynamic data);

@Component(
    changeDetection: ChangeDetectionStrategy.Stateful,
    encapsulation: ViewEncapsulation.None,
    preserveWhitespace: false,
    selector: 'grid-column',
    template: '')
class GridColumn extends ComponentState implements OnDestroy {
  //-----------------------------
  // Input
  //-----------------------------

  @Input()
  Type itemRenderer = SimpleTextRenderer;

  @Input()
  Type headerRenderer = SimpleHeaderRenderer;

  @Input()
  String title = '';

  @Input()
  LabelHandler labelHandler;

  @Input()
  ValueHandler valueHandler;

  @Input()
  ActionHandler actionHandler;

  @Input()
  LinkHandler linkHandler;

  @Input()
  SortHandler sortHandler;

  @Input()
  Map<String, dynamic> properties = <String, dynamic>{};

  @Output()
  Stream<dynamic> get valueChanged => valueChangedCtrl.stream;

  bool get isSortable => sortHandler != null;

  StreamController<dynamic> valueChangedCtrl =
      new StreamController<dynamic>.broadcast();

  //-----------------------------
  // Constructor
  //-----------------------------

  GridColumn();

  @override
  void ngOnDestroy() {
    valueChangedCtrl.close();
  }
}
