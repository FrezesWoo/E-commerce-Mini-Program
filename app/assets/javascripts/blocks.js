$(document).on('change', '.select-block-template', function() {
  $(this.parentElement.parentElement).children('.hidden-fields').hide();
  var data= $(this).val();
  console.log(data);
  $(this.parentElement.parentElement).children('.' + data).show();
});

$(document).on('change', '.select-campaign-block-template', function() {
    $(this.parentElement.parentElement).children('.hidden-fields').hide();
    var data= $(this).val();
    $(this.parentElement.parentElement).children('.' + data).show();
});

$(document).on('change', '.select-campaign-block-link', function() {
    $(this.parentElement.parentElement).children('.hidden-field-products').hide();
    var data= $(this).val();
    console.log(data);
    $(this.parentElement.parentElement).children('.template' + data).show();
});

$(document).on('change', '.select-product-block-template', function() {
    $(this).parent().parent().children('.hidden-fields').hide().siblings('.' + $(this).val()).show();
});

$(document).on('change', '.select-block-slide-link-type', function() {
    $(this).parent().parent().children('.hidden-fields').hide();
    if($(this).val() != ''){
        $(this).parent().parent().children('.link-type').hide();
        $(this).parent().parent().children('.hidden-fields').siblings('.' + $(this).val()).show();
    }else{
        $(this).parent().parent().children('.link-type').show();
    }
});