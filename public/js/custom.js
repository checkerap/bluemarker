/* global jQuery, gon, SimpleMDE */
var $ = jQuery;

$('.multiselect').multiSelect();

$(document).ready(function(){
  if ($('.markdown-editor').length) {
  new SimpleMDE({ element: $('.markdown-editor')[0] });
  }
})