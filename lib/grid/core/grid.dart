library nggrid.core.grid;

import 'dart:async';
import 'dart:html';

import 'package:angular2/angular2.dart';
import 'package:dorm/dorm.dart';
import 'package:ng2_state/ng2_state.dart';
import 'package:ng_grid/grid/core/grid_column.dart';
import 'package:ng_grid/grid/header_renderers/header_renderer_injector.dart';
import 'package:ng_grid/grid/infrastructure/sort_service.dart';
import 'package:ng_grid/grid/item_renderers/item_renderer_injector.dart';
import 'package:rxdart/rxdart.dart' as rx;

@Component(
  changeDetection: ChangeDetectionStrategy.Default,
  directives: const <Type>[HeaderRendererInjector, ItemRendererInjector, State],
  encapsulation: ViewEncapsulation.None,
  preserveWhitespace: false,
  providers: const <dynamic>[SortService, const Provider(StatefulComponent, useExisting: Grid)],
  selector: 'grid',
  templateUrl: 'grid.html',
  styles: const ['tbody {overflow-y: auto}']
)
class Grid implements StatefulComponent, OnDestroy {

  num _tempValue = 0;

  ElementRef _scrollPane;
  ElementRef get scrollPane => _scrollPane;
  @ViewChild('scrollPane') set scrollPane(ElementRef value) {
    _scrollPane = value;

    if (value != null) {
      final Element element = scrollPane.nativeElement;

      element.onScroll
      .listen((Event event) => _scrollTop$ctrl.add(element.scrollTop));

      element.scrollTop = _tempValue;
    }
  }

  final StreamController<bool> _onDestroy$ctrl = new StreamController<bool>.broadcast();
  final StreamController<num> _scrollTop$ctrl = new StreamController<num>.broadcast();

  @override Stream<bool> get onDestroy => _onDestroy$ctrl.stream;

  @override String stateGroup, stateId;

  @override void ngOnDestroy() {
    _onDestroy$ctrl.close();
    _scrollTop$ctrl.close();
  }

  @override Stream<Entity> provideState() => rx.observable(_scrollTop$ctrl.stream)
      .map((num position) => new SerializableTuple1<num>()
    ..item1 = position);

  @override void receiveState(Entity state, StatePhase phase) {
    final SerializableTuple1<num> tuple = state as SerializableTuple1<num>;

    if (scrollPane != null) {
      final Element element = scrollPane.nativeElement;

      element.scrollTop = tuple.item1;
    } else {
      _tempValue = tuple.item1;
    }
  }

  //-----------------------------
  // ContentChildren
  //-----------------------------

  @ContentChildren(GridColumn) QueryList<GridColumn> gridColumns;

  //-----------------------------
  // Input
  //-----------------------------

  List<dynamic> _dataProvider;

  @Input() set dataProvider(List<dynamic> value) {

    _sortService.forceSort();
    _dataProvider = value;
  }
  List<dynamic> get dataProvider => _dataProvider;

  bool _showRowNumbers = false;

  @Input() set showRowNumbers(bool value) {
    _showRowNumbers = value;
  }

  bool get showRowNumbers => _showRowNumbers;

  //-----------------------------
  // Private Properties
  //-----------------------------

  final SortService _sortService;

  //-----------------------------
  // Constructor
  //-----------------------------

  Grid(
    @Inject(SortService) this._sortService) {

    this._sortService.grid = this;
  }

  int trackDataByFunction(index, item) {
    return item.numericValue;
  }

  int trackColumnByFunction(index, item){
    return index;
  }

  bool isScrollBarSpacingShown() {
    return (scrollPane.nativeElement.offsetWidth - scrollPane.nativeElement.clientWidth) > 0;
  }

  String getScrollbarWidth() {
    final int scrollBarWidth = scrollPane.nativeElement.offsetWidth - scrollPane.nativeElement.clientWidth;
    return '0 0 ${scrollBarWidth}px';
  }
}