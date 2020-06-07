$(function(){

  $("#UserSearch__field").on("keyup", function(){
    let input = $("#UserSearch__field").val();    //フォームの値を取得して変数に代入する
    console.log(input);
  })
});