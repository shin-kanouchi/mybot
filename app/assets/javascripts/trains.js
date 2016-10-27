
function double(btn){
    $("form[name='" + btn + "']").submit();
    $("div." + btn + " button").prop('disabled', true);
}

function double_badq(t_id){
    $('input[name="dummy"]').val(t_id);
    $("form[name='choice-new']").submit();
    $("div.choice-new button").prop('disabled', true);
}

function pair_double(btn){
    $('input[name="inequality_flag"]').val(btn)
    $('form[name="eval-new"]').submit();
    $("div button").prop('disabled', true);
}

/*$(document).on('turbolinks:load page:change', function(){
  $(".edit_button button").on("click", function() {

    //初期化
    $("input#tweet").val("");
    //$("#tweet").val()="";

    $(".edit_button button").hide();
    $(".contents div").hide();
    $(".contents ."+this.id).show();
    if (this.id == "edit"){
      $("#chat-frame .chat-hukidashi:last").css("text-decoration", "line-through"); //text-decoration: line-through; span:last-child
      $(".edit_button #new").show();
    }else{
      $("#chat-frame .chat-hukidashi:last").css("text-decoration", "none");
      $(".edit_button #edit").show();
    }
  });
// window.addEventListener("load", function() {
//   });

  //$("div.new input[type='submit']").on("click", function()
  //  $("input#tweet").val("");
  //});
});

//function edit_button_on() {
//  console.log("Hello world");
//  $(".edit_button button").hide();
//}

*/

