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
//= require jquery 
//= require jquery_ujs 
//= require sweetalert
//= require social-share-button
//= require_tree .





$(function() {
  $('#error-explanation').addClass('alert-danger');
  $('#error-explanation').addClass('py-3');
  $('#error-explanation ul').addClass('mb-0');
  $('#error-explanation').addClass('mb-4');
  $('.alert').fadeOut(2000);
  // Multiple images preview in browser
  var imagesPreview = function(input, placeToInsertImagePreview) {
    if (input.files) {
      var filesAmount = input.files.length;
      for (i = 0; i < filesAmount; i++) {
        var reader = new FileReader();
        reader.onload = function(event) {
          $($.parseHTML('<img>')).attr('src', event.target.result).appendTo(placeToInsertImagePreview);
        }
        reader.readAsDataURL(input.files[i]);
      }
    }
  };
  $('#campaign_image').on('change', function() {
    if ($('#campaign_image').val() != "") {
      $('.new-frm-preview img').hide();
    }
    $('.new-frm-preview').show();
    imagesPreview(this, '.new-frm-preview');
    $('.new-frm-img').hide();
    $('.new-frm-preview').addClass('p-0');
  });
});
