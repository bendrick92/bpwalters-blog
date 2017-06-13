$(document).ready(function () {
    var hamburger = $(".hamburger");
    var navigation = $("nav");
    
    hamburger.click(function () {
		$(this).toggleClass("open");
        navigation.toggleClass("open");
    });
});