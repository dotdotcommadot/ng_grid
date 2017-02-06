library nggrid.infrastructure.sort_service;

import 'package:angular2/angular2.dart';
import 'package:ng_grid/grid/core/grid.dart';
import 'package:ng_grid/grid/core/grid_column.dart';

typedef void SortHandler(List<dynamic> dataProvider, int direction);

@Injectable()
class SortService {

  //-----------------------------
  // Public Properties
  //-----------------------------

  static final int SORT_DIRECTION_ASC = 1;
  static final int SORT_DIRECTION_DESC = -1;

  int currentSortDirection = SortService.SORT_DIRECTION_ASC;
  GridColumn currentSortedColumn;

  Grid grid;

  //-----------------------------
  // Constructor
  //-----------------------------

  SortService();

  //-----------------------------
  // Public Methods
  //-----------------------------

  void sortOnColumn(GridColumn column) {

    currentSortDirection = _getSortDirectionFor(column);
    column.sortHandler(grid.dataProvider, currentSortDirection);
    currentSortedColumn = column;
  }

  void forceSort() {

    if (currentSortedColumn != null) {
      currentSortedColumn.sortHandler(grid.dataProvider, currentSortDirection);
    }
  }

  //-----------------------------
  // Private Methods
  //-----------------------------

  int _getSortDirectionFor(GridColumn column) {

    int sortDirection = SortService.SORT_DIRECTION_ASC;

    if (currentSortedColumn != column) {
      sortDirection = SortService.SORT_DIRECTION_ASC;
    } else {
      sortDirection = currentSortDirection * -1;
    }

    return sortDirection;
  }
}
