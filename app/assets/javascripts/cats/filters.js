//= require bootstrap-multiselect

var CatFilters = CatFilters || {};

(function (namespace) {
  var filters = ['location', 'breed', 'shop']

  var filterOptions = {
    location: {
      disableIfEmpty: true,
      disabledText: 'No options',
      buttonClass: 'btn btn-link',
      nonSelectedText: 'Any location',
      nSelectedText: '- more locations',
      enableFiltering: true,
      enableCaseInsensitiveFiltering: true,
      includeResetOption: true,
      resetText: "Reset all",
      numberDisplayed: 2,
      onChange: getCount
    },
    breed: {
      disableIfEmpty: true,
      enableFiltering: true,
      enableCaseInsensitiveFiltering: true,
      disabledText: 'No options',
      buttonClass: 'btn btn-link',
      nonSelectedText: 'Any breed',
      nSelectedText: '- more breeds',
      includeResetOption: true,
      resetText: "Reset all",
      numberDisplayed: 2,
      onChange: getCount
    },
    shop: {
      disableIfEmpty: true,
      disabledText: 'No options',
      buttonClass: 'btn btn-link',
      nonSelectedText: 'Any shop',
      nSelectedText: '- more shops',
      includeResetOption: true,
      resetText: "Reset all",
      numberDisplayed: 2,
      onChange: getCount
    }
  }

  function grabParams() {
    var params = {}
    filters.forEach(function (key) {
      $('#' + key + ' option:selected').each(function () {
        params[key] = params[key] || []
        params[key].push($(this).val());
      })
    })
    return params;
  }

  function getCount () {
    $.get('/cats/count', grabParams()).then(function(result){
      $('#results-counter').text(result['count'] || 0)
    })
  }

  function clearAll (filterId) {
    return function(e) {
      e.preventDefault()
      var filter = $('#' + filterId)
      filter.multiselect('deselectAll', false);
      filter.multiselect('updateButtonText');
      getCount()
    }
  }

  function attachListeners(filter){
    $('#' + filter + '-clear').on('click', clearAll(filter));
  }

  function initMultiselect(filter){
    $('#' + filter).multiselect(filterOptions[filter] || {})
  }
  namespace.init = function(){
    filters.forEach(function (filter) {
      attachListeners(filter)
      initMultiselect(filter)
    })
  }

} (CatFilters))

$(document).ready(function() {
  CatFilters.init()
});