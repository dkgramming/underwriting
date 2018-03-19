class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :update, :destroy]

  # GET /quotes
  def index
    render json: Quote.all, status: :ok
  end

  # GET /quotes/:id
  def show
    render json: @quote, status: @quote.nil? ? :not_found : :ok
  end

  # POST /quotes
  def create
    begin
      property = Property.create!({
        address: quote_params[:quote][:real_address],
        marketing_expense: quote_params[:quote][:expense_items][:marketing],
        tax_expense: quote_params[:quote][:expense_items][:taxes],
        repair_expense: quote_params[:quote][:expense_items][:repairs],
        admin_expense: quote_params[:quote][:expense_items][:administration],
        payroll_expense: quote_params[:quote][:expense_items][:payroll],
        utility_expense: quote_params[:quote][:expense_items][:utility],
        management_expense: quote_params[:quote][:expense_items][:management],
        cap_rate: quote_params[:quote][:cap_rate]
      })
      quote_params[:quote][:rent_roll].each do |unit_params|
        unit = Unit.create!({
          number: unit_params[:unit_number],
          monthly_rent: unit_params[:monthly_rent],
          is_vacant: unit_params[:is_vacant],
          bedroom_count: unit_params[:bedroom_count],
          bathroom_count: unit_params[:bathroom_count],
          property_id: property.id
        })
      end
      quote = Quote.create!({
        property_id: property.id
      })
      render json: quote.to_h, status: :created
    rescue
      render json: nil, status: :unprocessable_entity
    end
  end

  # PUT /quotes/:id
  def update
    @quote.property.update(quote_params[:quote].to_h)
    head :no_content
  end

  # DELETE /quotes/:id
  def destroy
    @quote.destroy
    head :no_content
  end

  private
    def quote_params
      params
    end

    def set_quote
      begin
        @quote = Quote.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        @quote = nil
      end
    end
end
