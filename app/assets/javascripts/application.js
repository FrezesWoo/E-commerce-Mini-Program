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
//
//= require activestorage
//= require turbolinks
//= require jquery3
//= require jquery_ujs
//= require popper
//= require cocoon
//= require bootstrap
//= require moment
//= require dropzone
//= require pickadate/picker
//= require pickadate/picker.date
//= require pickadate/picker.time
//= require multi-select
//= require chosen-jquery
//= require chartkick
//= require Chart.bundle
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require_tree .

function getSkusData(productId, allProductSkus) {
    $.ajax({
        url: `/api/v1/products/${productId}/skus`,
        method: "GET",
        dataType: "json",
        headers: {"Authorization": ''},
        error: function (xhr, status, error) {
            console.error('AJAX Error: ' + status + error);
        },
        success: function (response) {
            allProductSkus.empty();
            if (response.length === 0) return;
            $.each(response, function (index, value) {
                const title = value.translations.find(it => { return it['locale'] == 'zh-CN' });
                allProductSkus.append('<option value="' + value["id"] + '">' + title["name"] + ' ' + value["sku"] + '</option>');
            });
        }
    });
}
