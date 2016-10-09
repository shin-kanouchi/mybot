window.addEventListener("load", function() {
  $(".edit_button button").on("click", function() {

    $(".edit_button button").hide();
    $(".contents div").hide();
    $(".contents ."+this.id).show();
    if (this.id == "edit"){
      $(".left li:last").css("text-decoration", "line-through"); //text-decoration: line-through; span:last-child
      $(".edit_button #new").show();
    }else{
      $(".left li:last").css("text-decoration", "none");
      $(".edit_button #edit").show();
    }
  });

  function show_text(){
    $('#chat').append("<%= j( render(partial: 'sentence_user', locals: { sentence: @sentence}) )%>");
    $("#sentence_sentence").val('');
  }

});
