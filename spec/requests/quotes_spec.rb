require 'rails_helper'

RSpec.describe 'Quotes API', type: :request do
  let(:num_quotes) { 10 }
  let!(:quotes) { create_list(:quote, num_quotes) }
  let(:quote_id) { quotes.first.id }

  describe 'GET /quotes' do
    before { get '/quotes' }

    it 'returns quotes' do
      expect(JSON.parse(response.body)).not_to be_empty
      expect(JSON.parse(response.body).size).to eq(num_quotes)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /quotes/:id' do
    before { get "/quotes/#{quote_id}" }

    context 'when the record exists' do
      it 'returns the quote' do
        expect(JSON.parse(response.body)).not_to be_empty
        expect(JSON.parse(response.body)['id']).to eq(quote_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:quote_id) { num_quotes + 1 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'return a not found message' do
        expect(response.body).to match(/null/)
      end
    end
  end

  describe 'POST /quotes' do
    let(:valid_attributes) { { quote: {
      real_address: '152 W 57th St, New York, NY 10019',
      rent_roll: [
        {
          unit_number: '1',
          monthly_rent: '4250',
          is_vacant: 'false',
          bedroom_count: '2',
          bathroom_count: '1',
        },
        {
          unit_number: '2',
          monthly_rent: '4350',
          is_vacant: 'false',
          bedroom_count: '2',
          bathroom_count: '2',
        },
      ],
      expense_items: {
        marketing: '2300',
        taxes: '15200',
        insurance: '12000',
        repairs: '7000',
        administration: '9600',
        payroll: '15000',
        utility: '9000',
        management: '8200'
      },
      cap_rate: '0.02'
    } } }

    context 'when the request is valid' do
      before { post '/quotes', params: valid_attributes }

      it 'creates a quote' do
        expect(JSON.parse(response.body)['loan_amount']).to be_kind_of(Numeric)
        expect(JSON.parse(response.body)['debt_rate']).to be_kind_of(Numeric)
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/quotes', params: {
        quote: { real_address: '123 Foo St, Bar City, NY 10010' } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to match(/null/)
      end
    end
  end

  describe 'PUT /quotes/:id' do
    let(:valid_attributes) { { real_address: '350 5th Ave, New York, NY 10118' } }

    context 'when the record exists' do
      before { put "/quotes/#{quote_id}", params: valid_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /quotes/:id' do
    before { delete "/quotes/#{quote_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end
