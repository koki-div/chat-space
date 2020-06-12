class GroupsController < ApplicationController
  def index
  end

  def new
    @group = Group.new
    @group.users << current_user
  end

  def create
    @group = Group.new(group_params)
    if @group.save                                          # 保存がうまくいった場合は
      redirect_to root_path, notice: "グループを作成しました"   # ルートパスに遷移 & flashメッセージを表示
    else
      render :new                                           # 新規登録画面を表示
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    if @group.update(group_params)
      redirect_to group_messages_path(@group), notice: "グループを更新しました"
    else
      render :edit
    end
  end

  private
  def group_params
    params.require(:group).permit(:name, user_ids: [])
  end
end
