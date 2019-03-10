class SessionsController < ApplicationController
  def new
  end
  
  def create
    # session内のemailとDB内のemailが一致するユーザーを検索
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # session helperのlog_in(user)を呼びだし
      log_in user
      # user_url(user)と同義
      redirect_to user
    else
      # エラーメッセージ用のflashを入れる
      flash.now[:danger] = 'メールアドレスとパスワードの情報が一致しませんでした。'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
  
end
