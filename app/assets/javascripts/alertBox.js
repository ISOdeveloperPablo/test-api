$(document).ready(function(){
  // $(".alert-box").animate({backgroundColor: "#fff"}, 'slow');

  function faded() {
    $(".alert-box").fadeOut("slow");
}
setTimeout(function() {
    $(".alert-box").fadeOut("slow", function() {
        $(".alert-box").remove();
    });
}, 3000);
});
