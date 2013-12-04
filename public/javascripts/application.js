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
    var options = {
      mode: 'javascript',
      lineNumbers: true
    };

    var reaodnly = textarea.getAttribute('data-readonly')
    if (reaodnly) {
      options.readOnly = reaodnly;
    }

    var editor = CodeMirror.fromTextArea(textarea, options);

    if (reaodnly) {
      editor.getWrapperElement().className += ' readonly';
      editor.getWrapperElement().querySelector('.CodeMirror-scroll').className += ' readonly';
    }
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
