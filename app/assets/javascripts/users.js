$(function(){
  // ビューに追加するためのHTMLを作成
  function  addUser(user){
    let html = `
                <div class="ChatMember clearfix">
                  <p class="ChatMember__name">${user.name}</p>
                  <div class="ChatMember__add ChatMember__button" data-user-id="${user.id}" data-user-name="${user.name}">追加</div>
                </div>
                `;
    $("#UserSearchResult").append(html);
  }

  // 引数に値が入っていなかった場合に、ビューに追加するためのHTMLを作成
  function addNoUser() {
    let html = `
                <div class="ChatMember clearfix">
                  <p class="ChatMember__name">ユーザーが見つかりません</p>
                </div>
                `;
    $("#UserSearchResult").append(html);
  }

  $('#UserSearch__field').on('keyup', function(){
    let input = $('#UserSearch__field').val();    //フォームの値を取得して変数に代入する
    $.ajax({
      type: 'GET',    //HTTPメソッド
      url: "/users",       // users_controllerの、indexアクションにリクエストの送信先を設定する
      dataType: "json",
      data: { keyword: input },   //テキストフィールドに入力された文字を設定する
    })
    .done(function(users) {         // users -> index.json.jbuilderにて生成されたjson形式の配列（ハッシュ構造・id/name）
      //emptyメソッドで一度検索結果を空にする
      $("#UserSearchResult").empty();
      //usersが空かどうかで条件分岐
      if (users.length !== 0) {
        users.forEach(function(user) {           // //配列オブジェクト１つ１つに対する処理
          addUser(user);
        });
      } else if (input.length == 0) {
        return false;
      } else {
        addNoUser();
      }
    })
    .fail(function() {
      alert("通信エラーです。ユーザーが表示できません。");
    });
  })  
});