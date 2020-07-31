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

  function addMember(name, id) {
    let html = `
                <div class="ChatMember">
                  <p class="ChatMember__name">${name}</p>
                  <input name="group[user_ids][]" type="hidden" value="${id}" />
                  <div class="ChatMember__remove ChatMember__button">削除</div>
                </div>
                `;
    $(".ChatMembers").append(html);
  }

  $('#UserSearch__field').on('keyup', function(){
    let input = $('#UserSearch__field').val();    //フォームの値を取得して変数に代入するr
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
    // 後から追加された「追加」ボタンに対するイベント発火
    $("#UserSearchResult").on("click", ".ChatMember__add", function() {
      const userName = $(this).attr("data-user-name");
      const userId = $(this).attr("data-user-id");
      $(this).parent().remove();
      addMember(userName, userId);
    });
    // 「削除」ボタンを押したときに発火するイベント
    $(".ChatMembers").on("click", ".ChatMember__remove", function() {
      $(this).parent().remove();
    });
  })  
});