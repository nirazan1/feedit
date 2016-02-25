class ConversationsController < ApplicationController
  before_filter :authenticate_user!

  def create
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id],params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    # @conversation.save!
    # redirect_to @conversation
    # render json: { conversation_id: @conversation.id }
    respond_to do |format|
      if @conversation.save
        format.html { redirect_to @conversation, notice: 'Conversation Started.' }
        format.js
      else
        format.html { render action: "show" }
        format.js
      end
    end
  end

  def show
    @conversation = Conversation.find(params[:id])
    if current_user.id  == @conversation.sender_id || current_user.id == @conversation.recipient_id || @conversation.recipient_id == nil ||  @conversation.sender_id == nil
      @reciever = interlocutor(@conversation)
      @messages = @conversation.messages
      @message = Message.new
    else
      redirect_to root_path , notice: 'Unauthorized ! '
    end
  end

  private
  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end

  def interlocutor(conversation)
    current_user == conversation.recipient ? conversation.sender : conversation.recipient
  end
end
