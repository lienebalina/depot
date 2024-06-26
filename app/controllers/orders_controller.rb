class OrdersController < ApplicationController
  skip_before_action :authorize, only: %i[ new create ]
  include CurrentCart
  before_action :set_cart, only: %i[ new create ]
  before_action :ensure_cart_isnt_empty, only: %i[ new ]
  before_action :set_order, only: %i[ show edit update destroy ship ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
  end

  # GET /orders/new
  def new
    @order = Order.new
    @payment_type_names = PaymentType.pluck(:name)
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
    @payment_type_names = PaymentType.pluck(:name)
  end

  # POST /orders or /orders.json
  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@cart)
    @payment_type_names = PaymentType.pluck(:name)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        ChargeOrderJob.perform_later(@order,pay_type_params.to_h)
        format.html { redirect_to store_index_url, notice:
          I18n.t('.thanks') }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1 or /orders/1.json
  def update
    @order = Order.find(params[:id])
    @payment_type_names = PaymentType.pluck(:name)

    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to order_url(@order), notice: "Order was successfully updated." }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1 or /orders/1.json
  def destroy
    @order.destroy!

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def ship
    @order.update(ship_date: Time.current)
    send_ship_date_notification

    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Order was successfully marked as shipped." }
      format.json { render :show, status: :ok, location: @order }
    end
  end

  private
    def ensure_cart_isnt_empty
      if @cart.line_items.empty?
        redirect_to store_index_url, notice: 'Your cart is empty'
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:name, :address, :email, :pay_type, :routing_number, :account_number, :credit_card_number, :expiration_date, :po_number)
    end

    def pay_type_params
      if order_params[:pay_type] == "Credit card"
        params.require(:order).permit(:credit_card_number, :expiration_date)
      elsif order_params[:pay_type] == "Check"
        params.require(:order).permit(:routing_number, :account_number)
      elsif order_params[:pay_type] == "Purchase order"
        params.require(:order).permit(:po_number)
      else
        {}
      end
    end

    def send_ship_date_notification
      OrderMailer.shipped(@order).deliver_now
    end
end
