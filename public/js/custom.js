/* global jQuery, gon, SimpleMDE */
var $ = jQuery;

$('.multiselect').multiSelect();

$(document).ready(function(){
  if ($('.markdown-editor').length) {
  new SimpleMDE({ element: $('.markdown-editor')[0], toolbar: ["bold", "italic", "heading", "|", "unordered-list", "ordered-list", "|", "preview"], });
  }
})