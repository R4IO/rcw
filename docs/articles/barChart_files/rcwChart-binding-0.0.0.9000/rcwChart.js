/*global HTMLWidgets, rcwCharts, _, x,*/
HTMLWidgets.widget({

  name: "rcwChart",

  type: "output",

  factory: function (el, width, height) {
    'use strict';

    var elementId = el.id,
      container = document.getElementById(elementId);
    
    return {

      renderValue: function (r) {

        var tooltip = function tooltip(color) {
          return '  font-size: 12px;  font-family: \'Signika\';  color: ' + color + ';  padding: 5px;  border: 1px solid ' + color + ';  background: white;  opacity: .8;';
        },
          axis = function axis() {
            return { thickness: 0, font: { family: 'Signika', color: '#575757', size: 12 }, linear: { pivot: { step: 1, color: 'white' } } };
          },
          grid = function grid() {
            return { color: 'white', baselines: [0] };
          },
          commonOptions = function commonOptions() {
            return { axis: { x: axis(), y: axis() }, grid: { x: grid(), y: grid() }, background: { color: '#DBEBF2' }, serie: { colors: ['#8EA4B1'], overColors: ['#39617D'], highlightColors: ['#E73741', '#0F8FD9', '#993484', '#DF521E', '#719E24', '#E1B400', '#32A674', '#0B68AF'], baselineColors: ['#0B1E2D'], annotation: { font: { family: 'Signika', size: 11 } } } };
          },
          barChartOptions = function barChartOptions() {
            return { base: {
              width: r.width,
              height: r.width,
              padding: { top: 20 },
              innerPadding: { left: 20, right: 20, bottom: 10 }
            },
              axis: {
                x: {
                  tick: { thickness: 0, size: 0 },
                  format: {
                    proc: function proc(datum) {
                      return datum;
                    }
                  },
                  ordinal: { gap: 0.3, padding: 0.3 }
                },
                y: { padding: 10,
                    tick: { thickness: 0 },
                    font: { baseline: 'ideographic' },
                    linear: {
                    pivot: { value: 0 }
                  }
                }
              },
              grid: {
                x: { thickness: 0 }
              },
              serie: {
                tooltip: {
                  layout: function layout(serie, datum, color) {
                    return '        <div style="' + tooltip(color) + '">          <div style="text-align: right;">            ' + datum.x + '          </div>          <div style="text-align: right; font-family: \'Signika\'; font-size: 16px;">            ' + _.round(datum.y, 2) + '          </div>        </div>      ';
                  }
                }
              }
              };
          },
          rowChartOptions = function rowChartOptions() {
            return { 
              base: {
                width: r.width,
                height: r.width,
                padding: { top: 20 },
                innerPadding: { left: 20, right: 20, bottom: 10 }
              },
              axis: {
                x: { 
                  padding: 10,
                  tick: { thickness: 0 },
                  font: { baseline: 'ideographic' },
                  linear: {
                    pivot: { value: 0 }
                  }
                },
                y: {
                  tick: { thickness: 0, size: 0 },
                  format: {
                    proc: function proc(datum) {
                      return datum;
                    }
                  },
                  ordinal: { gap: 0.3, padding: 0.3 }
                }
              },
              grid: {
                x: { thickness: 0 }
              },
              serie: {
                tooltip: {
                  layout: function layout(serie, datum, color) {
                    return '        <div style="' + tooltip(color) + '">          <div style="text-align: right;">            ' + datum.y + '          </div>          <div style="text-align: right; font-family: \'Signika\'; font-size: 16px;">            ' + _.round(datum.x, 2) + '          </div>        </div>      ';
                  }
                }
              }
            };
          },
          scatterChartOptions = function scatterChartOptions() {
            return { 
              base: {
                width: r.width,
                height: r.width,
                padding: { top: 40, right: 10 },
                innerPadding: { left: 20, right: 20, bottom: 10 }
              },
              axis: {
                x: { 
                  padding: 10,
                  tick: { thickness: 0, size: 0 },
                  font: { baseline: 'ideographic' },
                  linear: {
                    pivot: { value: 0 }
                  }
                },
                y: {
                  padding: 10,
                  tick: { thickness: 0, size: 0 },
                  format: {
                    proc: function proc(datum) {
                      return datum;
                    }
                  },
                  ordinal: { gap: 0.3, padding: 0.3 }
                }
              },
              grid: {
                x: { thickness: 0 }
              },
              serie: {
                tooltip: {
                  layout: function layout(serie, datum, color) {
                    return '        <div style="' + tooltip(color) + '">          <div style="text-align: right;">          x:' + datum.x + '          </div>          <div style="text-align: right; font-family: \'Signika\'; font-size: 16px;">          y:' + datum.y + '          </div>        </div>      ';
                  }
                }
              }
            };
          };

          if (r.type === "bar") {
            var rcwChart = new rcwCharts.BarChart(container,
                                 _.merge(commonOptions(), barChartOptions()),
                                 r.data);
          } else if (r.type === "scatter") {
            var rcwChart = new rcwCharts.ScatterChart(container,                                  
                                 _.merge(commonOptions(), scatterChartOptions()),
                                 r.data);
          } else if (r.type === "row") {
            var rcwChart = new rcwCharts.RowChart(container, 
                                 _.merge(commonOptions(), rowChartOptions()),
                                 r.data);
          } 

      },

      resize: function (width, height) {

      }

      // Make the rcw object available as a property on the widget
      // instance we're returning from factory(). This is generally a
      // good idea for extensibility--it helps users of this widget
      // interact directly with rcw, if needed.
      // r: rcw
    };
  }
});
