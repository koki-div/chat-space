# 配列形式でarray!メソッドを使用 -> 理由: メッセージは複数投稿されている可能性があるため、
json.array! @messages do |message|
  json.content message.content
  json.image message.image.url
  json.created_at message.created_at.strftime("%Y年%m月%d日 %H時%M分")
  json.user_name message.user.name
  json.id        message.id # <- 自動更新無限増殖の原因（ここの記述が欠けていた: 山下さん）
end