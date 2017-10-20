'use strict';

var tooltip = function tooltip(color) {
  return '  font-size: 12px;  font-family: \'Signika\';  color: ' + color + ';  padding: 5px;  border: 1px solid ' + color + ';  background: white;  opacity: .8;';
};

var axis = function axis() {
  return {
  	thickness: 0,
  	font: {
  		family: 'Signika',
  		color: '#575757',
  		size: 12 },
    linear: { pivot: { step: 1,
                       color: 'white' } } };
};

var grid = function grid() {
  return { color: 'white',
           baselines: [0] };
};

var commonOptions = function commonOptions() {
  return { axis: { x: axis(), y: axis() },
           grid: { x: grid(),
                   y: grid() },
           background: { color: '#DBEBF2' },
           serie: { colors: ['#8EA4B1'],
                    overColors: ['#39617D'],
                    highlightColors: ['#E73741', '#0F8FD9', '#993484', '#DF521E', '#719E24', '#E1B400', '#32A674', '#0B68AF'],
                    baselineColors: ['#0B1E2D'],
                    annotation: { font: { family: 'Signika',
                                          size: 11 } } } };
};

var barChartOptions = function barChartOptions() {
  return { base: { width: 800,
                   height: 400, padding: { top: 20 },
                   innerPadding: { left: 20,
                                   right: 20,
                                   bottom: 10 } },
           axis: { x: { tick: { thickness: 0,
                                size: 0 },
                        format: { proc: function proc(datum) {
                          return datum;
                        } },
                        ordinal: { gap: .3,
                                   padding: .3 } },
                   y: { padding: 10,
                        tick: { thickness: 0 },
                        font: { baseline: 'ideographic' },
                        linear: { pivot: { value: 0 } } } },
           grid: { x: { thickness: 0 } },
           serie: { tooltip: { layout: function layout(serie, datum, color) {
             return '        <div style="' + tooltip(color) + '">          <div style="text-align: right;">            ' + datum.x + '          </div>          <div style="text-align: right; font-family: \'Signika\'; font-size: 16px;">            ' + _.round(datum.y, 2) + '          </div>        </div>      ';
           } } } };
};

var barChartData = function barChartData() {
  return [{ datapoints: [{ x: 'Hungary', y: 5.5 },
 { x: 'Sweden', y: 6.6 },
 { x: 'Estonia', y: 5.7 },
 { x: 'Finland', y: 5.8 },
 { x: 'Belgium', y: 5.9 },
 { x: 'Turkey', y: 6 },
 { x: 'France', y: 6.5 },
 { x: 'Poland', y: 6.6 },
 { x: 'Slovenia', y: 6.8 },
 { x: 'European Union', y: 7.4, baselineIndex: 0 },
 { x: 'Euro area (18 countries)', y: 8.2 },
 { x: 'Ireland', y: 8.7, highlightIndex: 0 },
 { x: 'Italy', y: 8.9 },
 { x: 'Slovak Republic', y: 9.9 },
 { x: 'Portugal', y: 10.9 },
 { x: 'South Africa', y: 12.3, highlightIndex: 1 },
 { x: 'Spain (2 digits)', y: 16.86 }] }];
};

var barChart = new rcwCharts.BarChart(document.getElementById('root'), _.merge(commonOptions(), barChartOptions()), barChartData());
