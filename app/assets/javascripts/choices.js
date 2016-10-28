window.addEventListener("load", function() {
  $('.label-checkbox input[type="checkbox"]').change(function(){
    if ($('.label-checkbox input[type="checkbox"]').is(':checked')) {
      $('div.choice button.choice-new').text("選択完了");
    } else {
      $('div.choice button.choice-new').text("応答が全て良くない");
    }
  });
});
