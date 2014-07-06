require.config({
  baseUrl: '/js',
  paths: {
    jquery: 'lib/jquery',
    d3: 'd3/d3.v3.min',
    ace: 'lib/ace'
  },
  shim: {
    'd3.chart': {
      deps: ['d3']
    },
    'bootstrap/transition': {
      deps: ['jquery']
    },
    'bootstrap/collapse': {
      deps: ['jquery']
    }
  }
});
