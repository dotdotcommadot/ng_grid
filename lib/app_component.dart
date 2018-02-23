import 'package:angular2/angular2.dart';
import 'package:ng2_state/ng2_state.dart';

import 'package:ng_grid/checkbox_renderer.dart';
import 'package:ng_grid/grid/core/grid.dart';
import 'package:ng_grid/grid/core/grid_column.dart';
import 'package:ng_grid/grid/header_renderers/sortable_header_renderer.dart';
import 'package:ng_grid/grid/item_renderers/editable_text_renderer.dart';
import 'package:ng_grid/grid/item_renderers/simple_text_renderer.dart';
import 'package:ng_grid/grid/domain/data_wrapper.dart';

@Component(
    selector: 'my-app',
    templateUrl: 'app_component.html',
    directives: const <Type>[Grid, GridColumn],
    providers: const <Type>[StateService],
    styleUrls: const <String>['app_component.css'])
class AppComponent {
  List<DataWrapper> data = <DataWrapper>[];

  Type simpleTextRenderer = SimpleTextRenderer;
  Type editableTextRenderer = EditableTextRenderer;
  Type checkBoxRenderer = CheckBoxRenderer;
  Type sortableHeaderRenderer = SortableHeaderRenderer;

  String stringValueHandler(DataWrapper data) => data.stringValue;
  String boolValueHandler(DataWrapper data) => data.boolValue ? "Yes" : "No";
  String numericValueHandler(DataWrapper data) => data.numericValue.toString();
  String dateValueHandler(DataWrapper data) => data.dateValue.toString();

  AppComponent(@Inject(StateService) StateService stateService) {
    print('TEST');
    stateService.stateName = 'ng-grid';
    stateService.init();

    //data = generateData();
  }

  void sortByStringValue(List<DataWrapper> data, int direction) {
    print(new DateTime.now().toString());
    data.sort((DataWrapper a, DataWrapper b) =>
        a.stringValue.toLowerCase().compareTo(b.stringValue.toLowerCase()) *
        direction);
    print(new DateTime.now().toString());
  }

  void sortByNumericValue(List<DataWrapper> data, int direction) {
    List<DataWrapper> newData = new List<DataWrapper>.from(data);
    newData.sort((DataWrapper a, DataWrapper b) =>
        a.numericValue.compareTo(b.numericValue) * direction);
    this.data = newData;
  }

  void addData() {
    DataWrapper item = new DataWrapper()
      ..stringValue = "Item ${data.length}"
      ..boolValue = true
      ..numericValue = data.length
      ..dateValue = new DateTime.now();

    data.add(item);
  }

  List<DataWrapper> generateData() {
    List<DataWrapper> data = <DataWrapper>[];

    for (int i = 0; i < 1000; i++) {
      DataWrapper item = new DataWrapper()
        ..stringValue = "Item $i"
        ..boolValue = true
        ..numericValue = i
        ..dateValue = new DateTime.now();

      data.add(item);
    }

    return data;
  }
}
