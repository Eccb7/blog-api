require 'rails_helper'

RSpec.describe "Api::V1::Articles", type: :request do
  let(:valid_attributes) {
    {
      title: "Test Article",
      content: "Test content",
      tags: ["tech", "ruby"],
      published_at: Time.current
    }
  }

  let(:invalid_attributes) {
    { title: "", content: "", tags: [] }
  }

  describe "GET /api/v1/articles" do
    let!(:articles) { create_list(:article, 3) }

    it "returns articles" do
      get api_v1_articles_path
      expect(response).to have_http_status(:ok)
      expect(json_data.size).to eq(3)
    end

    it "paginates results" do
      get api_v1_articles_path, params: { page: 1, per_page: 2 }
      expect(json_data.size).to eq(2)
      expect(response.headers["Current-Page"]).to eq("1")
      expect(response.headers["Total-Pages"]).to eq("2")
    end
  end

  describe "GET /api/v1/articles/:slug" do
    let(:article) { create(:article) }

    it "returns article" do
      get api_v1_article_path(article.slug)
      expect(response).to have_http_status(:ok)
      expect(json_data[:id]).to eq(article.slug)
    end

    it "returns 404 for invalid slug" do
      get api_v1_article_path("invalid-slug")
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "POST /api/v1/articles" do
    context "with valid params" do
      it "creates article" do
        expect {
          post api_v1_articles_path, params: { article: valid_attributes }
        }.to change(Article, :count).by(1)
        expect(response).to have_http_status(:created)
      end
    end

    context "with invalid params" do
      it "returns errors" do
        post api_v1_articles_path, params: { article: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_errors).to be_present
      end
    end
  end

  describe "PATCH /api/v1/articles/:slug" do
    let(:article) { create(:article) }

    context "with valid params" do
      it "updates article" do
        patch api_v1_article_path(article.slug), params: { article: { title: "Updated Title" } }
        expect(article.reload.title).to eq("Updated Title")
        expect(response).to have_http_status(:ok)
      end
    end

    context "with invalid params" do
      it "returns errors" do
        patch api_v1_article_path(article.slug), params: { article: { title: "" } }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(json_errors).to be_present
      end
    end
  end

  describe "DELETE /api/v1/articles/:slug" do
    let!(:article) { create(:article) }

    it "destroys article" do
      expect {
        delete api_v1_article_path(article.slug)
      }.to change(Article, :count).by(-1)
      expect(response).to have_http_status(:no_content)
    end
  end

  def json_data
    JSON.parse(response.body, symbolize_names: true)[:data]
  end

  def json_errors
    JSON.parse(response.body, symbolize_names: true)[:errors]
  end
end
