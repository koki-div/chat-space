class UsersController < ApplicationController
  # json用のレスポンスを返せるようにする
  def index
    return nil if params[:keyword] == ""
    @users = User.where(['name LIKE ?', "%#{params[:keyword]}%"] ).where.not(id: current_user.id).limit(10)
    respond_to do |format|
      format.json
    end
  end
  
  def edit
  end

  # updateアクションをコメントアウト状況での動作確認済み（ajaxが正常に機能）
  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.requre(:user).permit(:name, :email)
  end

end
