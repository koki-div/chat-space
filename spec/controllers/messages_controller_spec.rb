require 'rails_helper'

describe MessagesController do
  # let を使用し、テストに使用するインスタンスを定義(複数の exampleで同一のインスタンスを使用したい場合)
  let (:group) { create(:group)}
  let (:user) { create(:user) }
  
  describe '#index' do  
    # ログインしている場合のテストコード
    context 'log in' do
      before do
        login user             # controller_macros.rb にて定義
        get :index, params: { group_id: group.id}
      end

      # アクション内で定義しているインスタンス変数があるか1
      it 'assigns @message' do
        expect(assigns(:message)).to be_a_new(Message)  # assigns(:group) が Messageクラスのインスタンスかつ未保存かどうかをチェック
      end

      # アクション内で定義しているインスタンス変数があるか2
      it 'assigns @group' do
        expect(assigns(:group)).to eq group
      end

      # 該当のビューが表示されているか
      it 'renders index' do
        expect(response).to render_template :index
      end
    end

    # ログインしていない場合のテストコード
    context 'not log in' do
      before do
        get :index, params: { group_id: group.id}
      end

      # 指定されたビュー(new_user_session)にリダイレクトしているか
      it 'redirects to new_user_session_path' do
        expect(response).to redirect_to(new_user_session_path)
      end
      # ※response -> example内でリクエストが行われた後の遷移先のビューの情報を持つインスタンス
    end
  end

  describe '#create' do
    let(:params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message) } }

    # ログインしている場合のテスト
    context 'log in' do
      before do
        login user
      end

      # メッセージの保存に成功した場合のテスト
      context 'can save' do
        # expectの引数subjectを生成（postメソッドでcreateアクションを擬似的にリクエスト）
        subject {
          post :create,
          params: params
        }

        it 'count up message' do
          expect{ subject }.to change(Message, :count).by(1)     # 「Messageモデルのレコードの総数が1個増えたかどうか」を確かめる
        end

        it 'redirect to group_message_path' do
          subject            # createアクションを擬似的にリクエストする
          expect(response).to redirect_to(group_messages_path(group))
        end
      end

      # メッセージの保存に失敗した場合のテスト
      context 'can not save' do
        
        let(:invalid_params) { { group_id: group.id, user_id: user.id, message: attributes_for(:message, content: nil, image: nil) } }

        subject {
          post :create,
          params: invalid_params        # invalid_paramsによって意図的にメッセージの保存に失敗する場合を再現
        }
        
        # 「Messageモデルのレコード数が変化しないこと ≒ 保存に失敗したこと」を確認するテストコード
        it 'does not count up' do
          expect{ subject }.not_to change(Message, :count)
        end

        it 'renders index' do
          subject
          expect(response).to render_template :index
        end
      end
    end

    # ログインしていない場合のテスト
    context 'not log in' do
      it 'redirects to new_user_session_path' do
        post :create, params: params
        expect(response).to redirect_to(new_user_session_path)
      end
    end
    
  end
end