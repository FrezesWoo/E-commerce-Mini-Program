$(document).on('change', '.select-link-type', function(){
  var data= $(this).val();
  $(this.parentElement.parentElement).children('.' + (data === 'Slug' ? 'page_link' : 'slug')).hide();
  $(this.parentElement.parentElement).children('.' + (data === 'Slug' ? 'slug' : 'page_link')).show();
});
