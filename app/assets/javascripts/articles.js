$(document).on('change', '.is-ambassador-input', function() {
  if ($(this).is(':checked')) {
    $('.signature').show();
  } else {
    $('.signature').hide();
  }
});


$(document).on('change', '.select-template', function() {
  $(this.parentElement.parentElement).children('.hidden-fields').hide();
  var data= $(this).val();
  if (!data) {
    return
  }
  $(this.parentElement.parentElement).children('.' + data).show();
});
