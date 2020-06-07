$(function(){
  function buildHTML(message){
    // 画像がある場合の処理
    if ( message.image ) {
      let html =
        `<div class="Message-box">
          <div class="Message-info">
            <div class="Message-info__user-name">
              ${message.user_name}
            </div>
            <div class="Message-info__date">
              ${message.created_at}
            </div>
          </div>
          <div class="Message">
            <p class="Message__content">
              ${message.content}
            </p>
            <img class="Message__image" src="${message.image}">
          </div>
        </div>`
      return html;
    } else {
    // 画像がない場合の処理
      let html =
      `<div class="Message-box">
        <div class="Message-info">
          <div class="Message-info__user-name">
            ${message.user_name}
          </div>
          <div class="Message-info__date">
            ${message.created_at}
          </div>
        </div>
        <div class="Message">
          <p class="Message__content">
            ${message.content}
          </p>
        </div>
      </div>`
      return html;
    };
  }

  $('.Form').on('submit', function(e){
    e.preventDefault()
    let formData = new FormData(this);
    let url = $(this).attr('action');
    $.ajax({
      url: url,  //同期通信でいう『パス』
      type: "POST",             //同期通信でいう『HTTPメソッド』
      data: formData,  
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data){
      let html = buildHTML(data);
      $('.Message-field').append(html); 
      $('.Message-field').animate({ scrollTop: $('.Message-field')[0].scrollHeight});
      $('.Form')[0].reset();
    })
    .fail(function() {
      alert("メッセージ送信に失敗しました");
    })
    .always(function() {
      $('.Form__submit').prop('disabled', false);
    });
  });
})