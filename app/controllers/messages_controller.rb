class MessagesController < ApplicationController

  def index 
    @messages = Message.connected(current_user)
  end

  def new
    @message = Message.new
  end

  def create
    @user = current_user
    @request = request_params
    case request[:token_type]
    when 'basic'
      create_basic_message
    when 'super'
      create_boosted_message
    when 'snek'
      create_snek_message
    end
  end

  def boost
    @message = Message.find_by(id: params[:id]).boost(current_user)
  end

  def destroy
    @message = Message.find_by(id: params[:id]).destroy
  end

  private

  def create_basic_message
  end

  def create_boosted_message
  end

  def create_snek_message
    return unless users_connected?

    set_casting_user
    
  end

  def request_params
    params.require(:message).permit(:body, :casting_user_id, :b_chain, :tokens, :token_type)
  end

  def set_casting_user
    @request[:user_id] = @request.delete(:casting_user_id)
  end

  def users_connected?
    return false unless User.find_by(id: @request[:casting_user_id]).receivers.pluck(:castable_id).include?(@user.id)

    true
  end
end
