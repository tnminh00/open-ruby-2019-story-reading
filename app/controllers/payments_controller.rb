class PaymentsController < ApplicationController
  def create
    story = Story.find_by id: params[:story_id]
    @payment = current_user.payments.new story_id: params[:story_id]
    if @payment.save
      redirect_to @payment.paypal_url story_path(story)
    else
      flash[:danger] = t ".danger"
      redirect_to story_path(story)
    end
  end

  protect_from_forgery except: [:hook]
  def hook
    params.permit!
    status = params[:payment_status]
    if status == "Completed"
      @payment = Payment.find params[:invoice]
      @payment.update_attributes status: status, transaction_id: params[:txn_id], purchased_at: Time.now
    end
    render nothing: true
  end
end
