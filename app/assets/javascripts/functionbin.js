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

    var readonly = textarea.getAttribute('data-readonly')
    if (readonly) {
      options.readOnly = readonly;
    } else {
      options.viewportMargin = Infinity;
    }

    var editor = CodeMirror.fromTextArea(textarea, options);

    if (readonly) {
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
      plotOptions: {
        series: { animation: false }
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

  forEach(document.querySelectorAll('input[data-filters]'), function(input) {
    var filter   = input.getAttribute('data-filters'),
        targets  = document.querySelectorAll(filter),
        selector = input.getAttribute('data-filters-by');

    if (targets.length === 0) { return; }

    var timeout;
    input.addEventListener('keyup', function() {
      var query = new RegExp('^\\s*' + escapeRegExp(input.value), 'i');

      if (timeout) { clearTimeout(timeout); }

      timeout = afterDelay(300, function filterTable() {
        forEach(targets, function(item) {
          var element = item.querySelector(selector);
          if (!element) { return; }

          if (query.test(element.textContent)) {
            removeClass(item, 'hidden');
          } else {
            addClass(item, 'hidden');
          }
        });
      });
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

  function removeClass(element, className) {
    if (element.classList) {
      element.classList.remove(className);
      return;
    }

    var classes = element.className.split(/\s+/);
    removeFromArray(classes, className);
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

  function removeFromArray(array, value) {
    for (var i = array.length - 1; i >= 0; --i) {
      if (array[i] === value) {
        array.splice(i, 1);
      }
    }
  }

  // Stolen from http://stackoverflow.com/questions/3446170
  function escapeRegExp(str) {
    return str.replace(/[\-\[\]\/\{\}\(\)\*\+\?\.\\\^\$\|]/g, "\\$&");
  }

  // Slide away any alert(s) after 3 seconds
  afterDelay(3000, function() {
    var notice = document.getElementById('notice');
    if (!notice) { return; }

    addClass(notice, 'exiting');
    onNextTransition(notice, removeElement);
  });
});
