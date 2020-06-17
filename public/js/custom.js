/* global jQuery, gon, SimpleMDE */
var $ = jQuery;

$('.multiselect').multiSelect();

$(document).ready(function(){
  if ($('.markdown-editor').length) {
  new SimpleMDE({ element: $('.markdown-editor')[0], toolbar: ["bold", "italic", "|", "unordered-list", "ordered-list", "|", "preview"], });
  }
})