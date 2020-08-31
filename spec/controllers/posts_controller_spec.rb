require 'rails_helper'
describe PostsController, type: :controller do
  before do
    @user = FactoryBot.create(:user)
    @post = FactoryBot.create(:post)
  end

  describe 'GET #index' do
    # it "populates an array of posts ordered by created_at DESC" do
    #   posts = FactoryBot.create_list(:post, 3) 
    #   get :index
    #   expect(assigns(:posts)).to match(posts.sort{ |a, b| b.created_at <=> a.created_at } )
    # end

    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    it "投稿ページに遷移するか" do
      @user
      sign_in @user
      get :new
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
  end

  describe 'GET #edit' do
    it "assigns the requested post to @post" do
      sign_in @user
      get :edit, params: { id: @post }
      expect(assigns(:post)).to eq @post
    end

    it "renders the :edit template" do
      sign_in @user
      get :edit, params: { id: @post }
      expect(response).to render_template :edit
    end
  end

  describe 'GET #update' do
  end

end