import 'package:angular2/angular2.dart';

import 'package:ng_grid/grid/core/grid_column.dart';
import 'package:ng_grid/grid/item_renderers/item_renderer_base.dart';

@Component(
    changeDetection: ChangeDetectionStrategy.Stateful,
    encapsulation: ViewEncapsulation.None,
    preserveWhitespace: false,
    selector: 'item-renderer-injector',
    template: '')
class ItemRendererInjector extends ComponentState implements AfterContentInit {
  //-----------------------------
  // Public Properties
  //-----------------------------

  GridColumn _gridColumn;

  @Input()
  set gridColumn(GridColumn value) {
    setState(() => _gridColumn = value);
  }

  GridColumn get gridColumn => _gridColumn;

  dynamic _data;

  @Input()
  set data(dynamic value) {
    setState(() => _data = value);
  }

  dynamic get data => _data;

  //-----------------------------
  // Private Properties
  //-----------------------------

  final ViewContainerRef _viewContainer;
  final ComponentResolver _componentResolver;

  //-----------------------------
  // Constructor
  //-----------------------------

  ItemRendererInjector(@Inject(ViewContainerRef) this._viewContainer,
      @Inject(ComponentResolver) this._componentResolver);

  //-----------------------------
  // Lifecycle Methods
  //-----------------------------

  @override
  void ngAfterContentInit() {
    _componentResolver
        .resolveComponent(gridColumn.itemRenderer)
        .then((ComponentFactory itemRendererFactory) {
      final ItemRendererBase<dynamic> itemRendererInst = _viewContainer
          .createComponent(itemRendererFactory, -1, _viewContainer.injector)
          .instance as ItemRendererBase<dynamic>;

      itemRendererInst
        ..gridColumn = gridColumn
        ..data = data;
    });
  }
}
