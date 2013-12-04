window.addEventListener('load', function() {
  function forEach(collection, fn) {
    for (var i = 0; i < collection.length; ++i) {
      fn(collection[i]);
    }
  }

  function forEachIn(collection, fn) {
    for (var k in collection) {
      fn(k, collection[k]);
    }
  }

  forEach(document.querySelectorAll('textarea.code-mirror-placeholder'), function(textarea) {
    CodeMirror.fromTextArea(textarea, {
      mode: 'javascript',
      lineNumbers: true
    });
  });

  forEachIn(this.charts || {}, function(title, config) {
    var target = document.querySelector(config.target),
        data   = config.data;

    new Highcharts.Chart({
      chart: {
        type: 'bar',
        renderTo: target,
      },
      legend: {
        layout: 'vertical',
        align: 'right',
        verticalAlign: 'top',
        x: -20,
        y: 20,
        floating: true,
        backgroundColor: '#fff'
      },
      title: { text: title },
      xAxis: { categories: ['Upvotes'] },
      credits: { enabled: false },
      series: data
    });
  });
});
