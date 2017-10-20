/*global HTMLWidgets, rcwCharts, x*/
HTMLWidgets.widget({

  name: "rcwChart",

  type: "output",

  factory: function (el, width, height) {
    "use strict";

    return {

      renderValue: function (x) {
        var elementId = el.id,
          container = document.getElementById(elementId);

        if (x.type === "bar") {
          new rcwCharts.BarChart(container, x.options, x.data);
        } else if (x.type === "scatter") {
          new rcwCharts.ScatterChart(container, x.options, x.data);
        } else if (x.type === "row") {
          new rcwCharts.RowChart(container, x.options, x.data);
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
