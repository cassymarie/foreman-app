// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.


//= require jquery
//= require jquery_ujs
//= require_tree .

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"

import "channels"
import '../css/application.css'

import 'bootstrap'
import 'bootstrap/dist/js/bootstrap.bundle';
import 'bootstrap/js/dist/util';
import 'bootstrap/js/dist/dropdown';

// const Choices = require('choices.js')

// document.addEventListener("turbolinks:load", function() {
//     var dropDownSelects = new Choices('#dropdown-choice-select')
// })

$(document).on('turbolinks:load', function() {
    setTimeout(function() {
      $('.alert').fadeOut();
    }, 3000);
  })
  
Rails.start()
Turbolinks.start()

