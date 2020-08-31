require 'rails_helper'

describe User do
  describe '#create' do
    before do
      @user = FactoryBot.build(:user)
    end
    it "email, nickname, image, password, password_confirmationが存在すれば登録できる" do
      expect(@user).to be_valid
    end
    it "is invalid without a nickname" do
      user = FactoryBot.build(:user, nickname: "")
      user.valid?
      expect(user.errors[:nickname]).to include("が入力されていません。")
    end

    it "is invalid without an email" do
      user = FactoryBot.build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("が入力されていません。")
    end

    it "is invalid without an image" do
      user = FactoryBot.build(:user, image: "")
      user.valid?
      expect(user.errors[:image]).to include("が入力されていません。")
    end

    it "is invalid without a password" do
      user = FactoryBot.build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("が入力されていません。")
    end

    it "is invalid without a password confirmation" do
      user = FactoryBot.build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("が入力されていません。")
    end

    it "is invalid if nickname is not unique" do
      duplicate_user = @user.dup
      duplicate_user.nickname=@user.nickname
      @user.save!
      expect(duplicate_user).to be_invalid
    end

    it "is invalid if email is not unique" do
      duplicate_user = @user.dup
      duplicate_user.email=@user.email
      @user.save!
      expect(duplicate_user).to be_invalid
    end

    it "can't contain more than 8 words" do
      @user=FactoryBot.build(:user, nickname:"a"*9)
      expect(@user).to be_invalid
    end

    it "must contain less than 6 words" do
      @user=FactoryBot.build(:user, password:"a"*5)
      expect(@user).to be_invalid
    end

    it "must contain more than 6 words" do
      @user=FactoryBot.build(:user, password_confirmation:"a"*5)
      expect(@user).to be_invalid
    end

  end
end