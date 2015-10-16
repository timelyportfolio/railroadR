HTMLWidgets.widget({

  name: 'railroad',

  type: 'output',

  initialize: function(el, width, height) {

    return { }

  },

  renderValue: function(el, x, instance) {
    // clean out el for dynamic / Shiny situations
    el.innerHTML = ""
    
    Diagram(x.diagram).addTo(el);
  },

  resize: function(el, width, height, instance) {

  }

});
