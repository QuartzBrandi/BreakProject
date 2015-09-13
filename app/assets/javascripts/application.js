// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function() {

  $('select').change(function() {
    if ($(this).val() == "vanity_url") {
      helper = $('.helper-text')
      helper.text("Search using your custom Steam URL.");
      helper.addClass("fade_in").on("animationend", function() { $('.helper-text').removeClass("fade_in") });
    }
    if ($(this).val() == "steamid") {
      helper = $('.helper-text').text("This is your 64-bit Steam ID.");
      helper.text("Search using your Steam ID. Example: 7656119XXXXXXXXXX.");
      helper.addClass("fade_in").on("animationend", function() { $('.helper-text').removeClass("fade_in") });
    }
  });

});
