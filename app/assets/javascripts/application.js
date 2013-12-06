window.addEventListener('load', function() {
  Highcharts.setOptions({
    colors: ['#008cba', '#43ac6a', '#e99002', '#5bc0de', '#f04124']
  });

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
    var target = document.querySelector(config.target);

    if (!target) {
      return;
    }

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
      yAxis: { title: false, min: 0, minRange: 9, minTickInterval: 1 },
      credits: { enabled: false },
      series: config.data
    });
  });

  // I hate writing setTimeout(fn, delay)!
  function afterDelay(delay, fn) {
    return setTimeout(fn, delay);
  }

  function addClass(element, className) {
    if (element.classList) {
      element.classList.add(className);
      return;
    }

    var classes = element.className.split(/\s+/);
    classes.push(className);
    element.className = classes.join(' ');
  }

  function onNextTransition(element, callback) {
    element.addEventListener(transitionEventForBrowser(), function() {
      callback(element);
    });
  }

  // See http://stackoverflow.com/questions/5023514
  function transitionEventForBrowser() {
    var div = document.createElement('DIV');

    var transitions = {
      'transition': 'transitionend',
      'OTransition': 'oTransitionEnd',
      'MozTransition': 'transitionend',
      'WebkitTransition': 'webkitTransitionEnd'
    };

    for (var t in transitions) {
      if (div.style[t] !== undefined) {
        return transitions[t];
      }
    }

    // Return and pray
    return 'transitionend';
  }

  function removeElement(element) {
    element.parentNode.removeChild(element);
  }

  // Slide away alerts after 3 seconds
  afterDelay(3000, function() {
    var notice = document.getElementById('notice');
    addClass(notice, 'exiting');
    onNextTransition(notice, removeElement);
  });
});
