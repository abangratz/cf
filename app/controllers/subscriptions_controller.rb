class SubscriptionsController < ApplicationController
  before_filter :authenticate_user!
  respond_to :json, :xml

  # POST /subscriptions
  # POST /subscriptions.xml
  def create
    s_params = params[:subscription]
    s_params.delete(:id)
    @subscription = Subscription.new(s_params)
    @subscription.save
    respond_with(@subscription)
  end

  # PUT /subscriptions/1
  # PUT /subscriptions/1.xml
  def update
    @subscription = Subscription.get(params[:id])
    @subscription.update(params[:subscription])
    respond_with(@subscription.reload)
  end

  def toggle_confirm
    @subscription = Subscription.get(params[:id])
    if (current_user == @subscription.calendar_event.user)
      @subscription.toggle_confirmation
    end
    respond_with(@subscription)
  end

end
