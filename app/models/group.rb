class Group < ApplicationRecord
  has_many :group_users
  has_many :users, through: :group_users             # group.users によってデータを呼び出すことができるようになる
  has_many :messages
  validates :name, presence: true, uniqueness: true  # null制約 & 一意性制約
  validates :name, presence: true, uniqueness: {case_sensitive: true} # rspec実行時の警告文を非表示にする

# サイドバーの グループ 部分に最新のメッセージが表示されるようにする
  def show_last_message
    if (last_message = messages.last).present?    # もしもメッセージ(もしくは画像)が投稿されている存在する場合は
      if last_message.content?                    # もしも文章が投稿されている場合は
        last_message.content
      else
        '画像が投稿されています'
      end
    else
      'まだメッセージはありません。'
    end
  end
end
