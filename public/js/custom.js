/* global jQuery, gon, SimpleMDE */
var $ = jQuery;

$('.multiselect').multiSelect();

$(document).ready(function(){
  $('.markdown-editor').each(function(el){
    // let editor = new SimpleMDE({ element: el[0], toolbar: ["bold", "italic", "|", "unordered-list", "ordered-list", "|", "preview"], });
  
    var simplemde = new SimpleMDE({
      element: this,
      toolbar: ["bold", "italic", "|", "unordered-list", "ordered-list", "|", "preview"]
    });
  });
})