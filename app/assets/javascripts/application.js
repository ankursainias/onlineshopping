// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require rails-ujs
//= require activestorage
//= require_tree .


var placeSearch, autocomplete, geocoder;

function initAutocomplete() {
  geocoder = new google.maps.Geocoder();
  autocomplete = new google.maps.places.Autocomplete(
      (document.getElementById('store_address'))/*,
      {types: ['(cities)']}*/);

  autocomplete.addListener('place_changed', fillInAddress);
}

function codeAddress(address) {
    geocoder.geocode( { 'address': address}, function(results, status) {
      if (status == 'OK') {
      	debugger
      	var latitude = results[0].geometry.location.lat();
      	var longitude = results[0].geometry.location.lng();
      	document.getElementById('store_lat').value = latitude;
      	document.getElementById('store_lng').value = longitude;
        // alert(results[0].geometry.location);
      } else {
        alert('Geocode was not successful for the following reason: ' + status);
      }
    });
  }
function fillInAddress() {
  var place = autocomplete.getPlace();

  codeAddress(document.getElementById('store_address').value);
}