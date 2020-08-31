require 'rails_helper'

describe Post do
  before do
    @user = FactoryBot.create(:user)
    @post =FactoryBot.build(:post)
  end
  describe '#create' do
    it "vocab, definition, example, imageが存在すれば登録できる" do
      user = @user
      post = @post
      expect(post).to be_valid
    end
    it "is invalid without a vocab" do
      post = FactoryBot.build(:post, vocab: "")
      post.valid?
      expect(post.errors).to be_added(:vocab, :blank)
    end

    it "is invalid without a definition" do
      post = FactoryBot.build(:post, definition: "")
      post.valid?
      expect(post.errors).to be_added(:definition, :blank)
    end

    it "is invalid without an example" do
      post = FactoryBot.build(:post, example: "")
      post.valid?
      expect(post.errors).to be_added(:example, :blank)
    end

    it "is invalid without an image" do
      post = FactoryBot.build(:post, image: "")
      post.valid?
      expect(post.errors).to be_added(:image, :blank)
    end

    it "can't be more than 40 words" do
      post = FactoryBot.build(:post, vocab: "ああああああああああああああああああああああああああああああああああああああああああああああああああ")
      post.valid?
      expect(post.errors).to be_added(:vocab, :too_long, count: 40)
    end
  end
end