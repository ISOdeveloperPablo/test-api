/*** WRAPPER ***/
$(function(){
    var windowH = $(window).height();
    var wrapperH = $('.main-content').height();
    if(windowH > wrapperH) {
        $('.main-content').css({'min-height':($(window).height()-289)+'px'});
    }
});



/*** SCROLLBAR ***/
(function($){
	$(window).load(function(){
		$(".scrollbar-wrapper").mCustomScrollbar({
		});
	});
})(jQuery);
