(function($) {

    var defaults = {};

    $.fn.loginBoxify = function() {
        var html = "<p><label for='email'>Email</label><input id='email' name='email' /></p>" +
                   "<p><label for='password'>Password</label><input type='password' name='password' /></p>" +
                   "<p id='submit_button'><button>login</button></p>";
        $(this).html(html);
        
    };

})(jQuery);

$(document).ready(function(){
    $('#login_box').loginBoxify();
});