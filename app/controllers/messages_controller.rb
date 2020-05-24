class MessagesController < ApplicationController
  before_action :set_group
  def index
    # ビューに表示するメッセージ一覧を取得し、インスタンス変数に格納
    @message = Message.new                        # インスタンス作成
    @messages =  @group.messages.includes(:user)  # groupテーブル経由でmessageテーブルのレコードを取得する
  end
  
  def create
    @message = @group.messages.new(message_params)  # @group は下部 set_group において定義済み
    # メッセージが正常に保存された場合とそうでない場合で条件分岐
    if @message.save
      redirect_to group_messages_path(@group), notice: 'メッセージが送信されました'
    else
      @messages = @group.messages.includes(:user)
      flash.now[alert] = 'メッセージを入力してください。'
      render :index
    end
  end

  private

  def message_params
    params.require(:message).permit(:content, :image).merge(user_id: current_user.id)
  end

  def set_group
    @group = Group.find(params[:group_id])
    # binding.pry
  end
end
