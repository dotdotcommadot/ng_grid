library nggrid.header_renderers.header_renderer_injector;

import 'package:angular2/angular2.dart';
import 'package:ng_grid/grid/core/grid_column.dart';
import 'package:ng_grid/grid/header_renderers/header_renderer_base.dart';

@Component(
  changeDetection: ChangeDetectionStrategy.Default,
  encapsulation: ViewEncapsulation.Emulated,
  preserveWhitespace: false,
  selector: 'header-renderer-injector',
  template: ''
)
class HeaderRendererInjector implements AfterContentInit {

  //-----------------------------
  // Public Properties
  //-----------------------------

  @Input() GridColumn gridColumn;

  //-----------------------------
  // Private Properties
  //-----------------------------

  final ViewContainerRef _viewContainer;
  final ComponentResolver _componentResolver;

  //-----------------------------
  // Constructor
  //-----------------------------

  HeaderRendererInjector(
    @Inject(ViewContainerRef) this._viewContainer,
    @Inject(ComponentResolver) this._componentResolver);

  //-----------------------------
  // Lifecycle Methods
  //-----------------------------

  @override void ngAfterContentInit() {

    _componentResolver.resolveComponent(gridColumn.headerRenderer)
      .then((headerRendererFactory) {

        final HeaderRendererBase headerRendererInst = _viewContainer.createComponent(
          headerRendererFactory,
          -1,
          _viewContainer.injector)
          .instance;

        headerRendererInst
          ..gridColumn = gridColumn;
    });
  }
}