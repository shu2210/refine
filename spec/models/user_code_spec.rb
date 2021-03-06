# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserCode, type: :model do
  context '正常な場合' do
    it 'エラーにならない' do
      code = build(:user_code)
      expect(code).to be_valid
    end
  end

  describe 'scope' do
    describe 'latest' do
      let(:old) { create(:user_code, active: true, created_at: Time.now) }

      before do
        create_list(:user_code, 10, active: true, created_at: Time.now + 1.second)
      end

      it '最近投稿されたコードが取得できる' do
        codes = UserCode.latest
        expect(codes).not_to include(old)
      end
    end

    describe 'popular' do
      let(:latest) { create(:user_code, created_at: Time.now + 1.second) }

      before do
        code_with_review = create(:code, reviews: [build(:review)])
        create_list(:user_code, 5, codes: [code_with_review], created_at: Time.now)
      end

      it 'reviewが投稿された数が多いコードが5件まで取得できる' do
        codes = UserCode.popular
        expect(codes).not_to include(latest)
      end
    end
  end

  describe 'title' do
    let(:code) { build(:user_code, title: title) }

    before { code.valid?(:post) }

    context '空白の場合' do
      let(:title) { '' }

      it { expect(code.errors[:title]).not_to be_empty }
    end

    context '200文字以上の場合' do
      let(:title) { Faker::Lorem.characters(number: 201) }

      it { expect(code.errors[:title]).not_to be_empty }
    end
  end

  describe 'description' do
    let(:code) { build(:user_code, description: description) }
    before { code.valid?(:post) }

    context '空白の場合' do
      let(:description) { '' }

      it { expect(code.errors[:description]).not_to be_empty }
    end

    context '300文字以上の場合' do
      let(:description) { Faker::Lorem.characters(number: 301) }

      it { expect(code.errors[:description]).not_to be_empty }
    end
  end

  describe 'draft' do
    let(:user) { build(:user) }
    let(:tags) { %i[tag1 tag2] }
    let(:code) { build(:code) }

    context '全て指定した場合' do
      let(:user_code) { build(:user_code, title: :test, description: :test, codes: [code], user: user) }

      it '下書き保存ができること' do
        expect { user_code.draft(tags) }.to change(UserCode, :count).by(1)
      end

      it 'statusがdraftになること' do
        user_code.draft(tags)
        expect(user_code.status).to eq(:draft)
      end

      it 'trueが返る' do
        expect(user_code.draft(tags)).to be_truthy
      end

      it 'タグが保存される' do
        expect { user_code.draft(tags) }.to change(Tag, :count).by(2)
      end

      it 'コードが保存される' do
        expect { user_code.draft(tags) }.to change(Code, :count).by(1)
      end
    end

    context 'タグだけ指定しない場合' do
      let(:user_code) { build(:user_code, title: :test, description: :test, codes: [code], user: user) }

      it 'タグなしで下書き保存される' do
        expect { user_code.draft([]) }.to change(UserCode, :count).by(1).and change(Code, :count).by(1)
      end

      it 'trueが返る' do
        expect(user_code.draft([])).to be_truthy
      end
    end

    context 'コードだけ指定しない場合' do
      let(:user_code) { build(:user_code, title: :test, description: :test, user: user) }
      let(:user_code) { build(:user_code, title: :test, description: :test, user: user) }

      it 'コードなしで下書き保存される' do
        expect { user_code.draft(tags) }.to change(UserCode, :count).by(1).and change(Tag, :count).by(2)
      end

      it 'trueが返る' do
        expect(user_code.draft(tags)).to be_truthy
      end
    end

    context 'コード・タグを指定しない場合' do
      let(:user_code) { build(:user_code, title: :test, description: :test, user: user) }

      it '下書きが保存される' do
        expect { user_code.draft([]) }.to change(UserCode, :count).by(1)
      end

      it 'trueが返る' do
        expect(user_code.draft([])).to be_truthy
      end
    end

    context 'titleがない場合' do
      let(:user_code) { build(:user_code, title: nil, user: user) }

      it 'レコードは保存されない' do
        expect { user_code.draft(tags) }.not_to change(UserCode, :count)
        expect { user_code.draft(tags) }.not_to change(UserCodeTag, :count)
        expect { user_code.draft(tags) }.not_to change(Tag, :count)
      end

      it 'falseが返る' do
        expect(user_code.draft(tags)).to eq(false)
      end
    end

    context 'descriptionがない場合' do
      let(:user_code) { build(:user_code, description: nil, user: user) }

      it 'レコードは保存されない' do
        expect { user_code.draft(tags) }.not_to change(UserCode, :count)
        expect { user_code.draft(tags) }.not_to change(UserCodeTag, :count)
        expect { user_code.draft(tags) }.not_to change(Tag, :count)
      end

      it 'falseが返る' do
        expect(user_code.draft(tags)).to eq(false)
      end
    end

    context '下書きの数が上限に達している場合' do
      let(:limit) { 15 }
      let(:user_code) { build(:user_code, user_id: user.id) }

      before do
        drafts = build_list(:user_code, limit, status: :draft)
        UserCode.import drafts
      end

      it 'レコードは保存されない' do
        expect { user_code.draft(tags) }.not_to change(UserCode, :count)
      end

      it 'falseが返る' do
        expect(user_code.draft(tags)).to eq(false)
      end
    end
  end

  describe 'drafts' do
    let(:user) { create(:user) }
    let(:old_code) { create(:user_code, status: :draft, code_group_id: 1, active: false, user: user) }
    let!(:user_code) { create(:user_code, status: :draft, code_group_id: 1, active: true, user: user) }

    it '最新のバージョンの下書きを取得する' do
      drafts = UserCode.drafts(user.id)
      expect(drafts.first.id).to eq(user_code.id)
    end
  end

  describe 'post' do
    let(:user) { create(:user) }
    let(:tags) { %i[tag1 tag2] }

    context '成功した場合' do
      let(:code) { build(:user_code, title: :test, description: :test, user: user) }

      it 'レコードが追加される' do
        expect { code.post(tags) }.to change(UserCode, :count).by(1)
      end

      it 'statusがpostになること' do
        code.post(tags)
        expect(code.status).to eq(:post)
      end

      it 'trueが返る' do
        expect(code.post(tags)).to be_truthy
      end

      it 'activeがtrueになる' do
        code.post(tags)
        expect(code.active).to eq(true)
      end

      context '初投稿の場合' do
        it 'group_idが1になる' do
          code.post(tags)
          code.reload
          expect(code.code_group_id).to eq(1)
        end
      end

      context '投稿がある場合' do
        before { create(:user_code, user: user, code_group_id: 1) }

        it '最新のgroup_id + 1になる' do
          code.post(tags)
          code.reload
          expect(code.code_group_id).to eq(2)
        end
      end
    end

    context '失敗した場合' do
      let(:code) { build(:user_code, title: :test, description: nil, user: user) }

      it 'レコードは保存されない' do
        expect { code.post(tags) }.not_to change(UserCode, :count)
        expect { code.post(tags) }.not_to change(UserCodeTag, :count)
        expect { code.post(tags) }.not_to change(Tag, :count)
      end

      it 'falseが返る' do
        expect(code.post(tags)).to eq(false)
      end
    end
  end

  describe 'update_version' do
    let(:user) { build(:user) }
    let(:tags) { %i[tag1 tag2] }

    context '成功した場合' do
      let!(:old_code) { create(:user_code, active: true, user: user) }
      let!(:user_code) { build(:user_code, title: :test, description: :test, user: user) }

      it 'レコードが追加される' do
        expect do
          user_code.update_version(old_code.id, tags, :post)
        end.to change(UserCode, :count).by(1)
      end

      it '渡したstatusにステータスが変更されること' do
        new_code = user_code.update_version(old_code.id, tags, :draft)
        expect(new_code.status).to eq(:draft)
      end

      it 'trueが返る' do
        expect(user_code.update_version(old_code.id, tags, :post)).to be_truthy
      end

      it '過去のコードのactiveが0になること' do
        user_code.update_version(old_code.id, tags, :draft)
        old_code.reload
        expect(old_code.active).to eq(false)
      end

      it '投稿されたコードのactiveになること' do
        new_code = user_code.update_version(old_code.id, tags, :draft)
        expect(new_code.active).to eq(true)
      end
    end

    context '失敗した場合' do
      let!(:old_code) { create(:user_code, user: user) }
      let!(:user_code) { build(:user_code, title: :test, description: nil, user: user) }

      it 'レコードは保存されない' do
        expect { user_code.update_version(old_code.id, tags, :post) }.not_to change(UserCode, :count)
        expect { user_code.update_version(old_code.id, tags, :post) }.not_to change(UserCodeTag, :count)
        expect { user_code.update_version(old_code.id, tags, :post) }.not_to change(Tag, :count)
      end

      it 'falseが返る' do
        expect(user_code.update_version(old_code.id, tags, :post)).to eq(false)
      end
    end
  end

  describe 'likes' do
    let(:code) { create(:user_code) }

    context 'likesがない場合' do
      it '0を返す' do
        expect(code.likes).to eq(0)
      end
    end

    context 'likesがある場合' do
      before do
        create(:user_code_like, user_code_id: code.id)
        create(:user_code_like, user_code_id: code.id)
      end

      it 'likeの数を返す' do
        expect(code.likes).to eq(2)
      end
    end
  end

  describe 'liked?' do
    let(:code) { create(:user_code) }

    context 'likeがある場合' do
      let(:like) { create(:user_code_like, user_code_id: code.id) }

      it 'trueを返す' do
        expect(code.liked?(like.user_id)).to eq(true)
      end
    end

    context 'likeがない場合' do
      it 'falseを返す' do
        expect(code.liked?(0)).to eq(false)
      end
    end
  end

  describe 'dislikes' do
    let(:code) { create(:user_code) }

    context 'dislikesがない場合' do
      it '0を返す' do
        expect(code.dislikes).to eq(0)
      end
    end

    context 'dislikesがある場合' do
      before do
        create(:user_code_dislike, user_code_id: code.id)
        create(:user_code_dislike, user_code_id: code.id)
      end

      it 'likeの数を返す' do
        expect(code.dislikes).to eq(2)
      end
    end
  end

  describe 'disliked?' do
    let(:code) { create(:user_code) }

    context 'dislikeがある場合' do
      let(:dislike) { create(:user_code_dislike, user_code_id: code.id) }

      it 'trueを返す' do
        expect(code.disliked?(dislike.user_id)).to eq(true)
      end
    end

    context 'dislikeがない場合' do
      it 'falseを返す' do
        expect(code.disliked?(0)).to eq(false)
      end
    end
  end

  describe 'histories' do
    let(:code1) { create(:user_code, code_group_id: 1) }
    let(:code2) { create(:user_code, code_group_id: 1) }
    let(:code3) { create(:user_code, code_group_id: 2) }

    context 'code1のidを渡した場合' do
      it 'code1, code2を取得する' do
        codes = UserCode.histories(code1.id)
        expect(codes).to eq([code1, code2])
      end
    end

    context 'code3のidを渡した場合' do
      it 'code3を取得する' do
        codes = UserCode.histories(code3.id)
        expect(codes).to eq([code3])
      end
    end
  end

  describe 'deactivate' do
    let(:user_code) { create(:user_code, active: true) }

    it 'activeをfalseにする' do
      user_code.deactivate
      user_code.reload
      expect(user_code.active).to eq(false)
    end
  end
end
