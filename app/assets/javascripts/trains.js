window.addEventListener("load", function() {
  $(".edit_button button").on("click", function() {

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
});

function _submit(){
  //任意の処理
  $(".edit_button #edit").show();
  $(".edit_button").css("display", "block");
}
