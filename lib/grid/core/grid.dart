import 'dart:async';
import 'dart:html';

import 'package:angular2/angular2.dart';
import 'package:dorm/dorm.dart';
import 'package:ng2_state/ng2_state.dart';
import 'package:rxdart/rxdart.dart' as rx;

import 'package:ng_grid/grid/domain/data_wrapper.dart';
import 'package:ng_grid/grid/core/grid_column.dart';
import 'package:ng_grid/grid/header_renderers/header_renderer_injector.dart';
import 'package:ng_grid/grid/infrastructure/sort_service.dart';
import 'package:ng_grid/grid/item_renderers/item_renderer_injector.dart';

@Component(
    changeDetection: ChangeDetectionStrategy.Stateful,
    directives: const <Type>[
      HeaderRendererInjector,
      ItemRendererInjector,
      State
    ],
    encapsulation: ViewEncapsulation.None,
    preserveWhitespace: false,
    providers: const <dynamic>[
      SortService,
      const Provider(StatefulComponent, useExisting: Grid)
    ],
    selector: 'grid',
    templateUrl: 'grid.html',
    styles: const <String>['tbody {overflow-y: auto}'])
class Grid extends ComponentState implements StatefulComponent, OnDestroy {
  num _tempValue = 0;

  ElementRef _scrollPane;
  ElementRef get scrollPane => _scrollPane;
  @ViewChild('scrollPane')
  set scrollPane(ElementRef value) {
    _scrollPane = value;

    if (value != null) {
      scrollPane.nativeElement
        ..onScroll.listen((Event event) => _scrollTop$ctrl
            .add((scrollPane.nativeElement as Element).scrollTop))
        ..scrollTop = _tempValue;
    }
  }

  final StreamController<bool> _onDestroy$ctrl =
      new StreamController<bool>.broadcast();
  final StreamController<num> _scrollTop$ctrl =
      new StreamController<num>.broadcast();

  @override
  Stream<bool> get onDestroy => _onDestroy$ctrl.stream;

  @override
  String stateGroup, stateId;

  @override
  void ngOnDestroy() {
    _onDestroy$ctrl.close();
    _scrollTop$ctrl.close();
  }

  @override
  Stream<Entity> provideState() =>
      new rx.Observable<num>(_scrollTop$ctrl.stream).map(
          (num position) => new SerializableTuple1<num>()..item1 = position);

  @override
  void receiveState(Entity state, StatePhase phase) {
    final SerializableTuple1<num> tuple = state as SerializableTuple1<num>;

    if (scrollPane != null) {
      final Element element = scrollPane.nativeElement as Element;

      element.scrollTop = tuple.item1.toInt();
    } else {
      _tempValue = tuple.item1;
    }
  }

  //-----------------------------
  // ContentChildren
  //-----------------------------

  @ContentChildren(GridColumn)
  QueryList<GridColumn> gridColumns;

  //-----------------------------
  // Input
  //-----------------------------

  List<dynamic> _dataProvider;

  @Input()
  set dataProvider(List<dynamic> value) {
    _sortService.forceSort();
    setState(() => _dataProvider = value);
  }

  List<dynamic> get dataProvider => _dataProvider;

  bool _showRowNumbers = false;

  @Input()
  set showRowNumbers(bool value) {
    setState(() => _showRowNumbers = value);
  }

  bool get showRowNumbers => _showRowNumbers;

  bool _isLoading = false;
  @Input()
  set isLoading(bool value) {
    setState(() => _isLoading = value);
  }

  bool get isLoading => _isLoading;

  //-----------------------------
  // Private Properties
  //-----------------------------

  final SortService _sortService;

  //-----------------------------
  // Constructor
  //-----------------------------

  Grid(@Inject(SortService) this._sortService) {
    this._sortService.grid = this;
  }

  //-----------------------------
  // Public Methods
  //-----------------------------

  int trackDataByFunction(dynamic _, DataWrapper item) => item.numericValue;

  int trackColumnByFunction(int index, dynamic _) => index;

  bool isScrollBarSpacingShown() {
    final Element element = scrollPane.nativeElement as Element;

    return (element.offsetWidth - element.clientWidth) > 0;
  }

  String getScrollbarWidth() {
    final Element element = scrollPane.nativeElement as Element;
    final int scrollBarWidth = element.offsetWidth - element.clientWidth;

    return '0 0 ${scrollBarWidth}px';
  }

  void setLoading() {
    setState(() => this.isLoading = true);
  }

  void unsetLoading() {
    setState(() => this.isLoading = false);
  }

  void refresh() {
    deliverStateChanges();
  }
}
