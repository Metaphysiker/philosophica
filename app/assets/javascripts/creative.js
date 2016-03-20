$(document).ready(function(){

$( ".clickme1" ).click(function() {
    $(this).children(".book").toggle( "slow", function() {
        // Animation complete.$( "div" ).children( ".selected" ).css( "color", "blue" );
    });
});

});