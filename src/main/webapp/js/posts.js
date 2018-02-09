$(document).ready(function () {

    (function ($) {

        $('#search').keyup(function () {

            var rex = new RegExp($(this).val(), 'i');
            $('#feed tr td').hide();
            $('#feed tr td').filter(function () {
                return rex.test($(this).find('#title').text());
            }).show();

        });

    }(jQuery));

});