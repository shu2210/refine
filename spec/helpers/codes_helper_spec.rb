# encoding: utf-8
# frozen_string_literal: true

require 'rails_helper'

describe CodesHelper, type: :helper do
  describe 'languages' do
    it 'Languageテーブルの中身を全て取得する' do
      expect(helper.languages).to eq(Language.all)
    end
  end

  describe 'badge_label' do
    context 'publishedの場合' do
      it '受付中を返す' do
        expect(helper.badge_label('published')).to eq('受付中')
      end
    end

    context 'closedの場合' do
      it '受付終了を返す' do
        expect(helper.badge_label('closed')).to eq('受付終了')
      end
    end

    context '上記以外の場合' do
      it 'その他を返す' do
        expect(helper.badge_label('etc')).to eq('その他')
      end
    end
  end

  describe 'language_image_path' do
    context 'イメージが見つかった場合' do
      it '言語名からイメージパスを生成する' do
        path = helper.language_image_path('ruby')
        expect(path).to eq('icons/ruby.png')
      end

      it '別の拡張子でも取得できる' do
        path = helper.language_image_path('javascript')
        expect(path).to eq('icons/javascript.jpg')
      end
    end

    context 'イメージが見つからない場合' do
      it '例外を発生させる' do
        expect { helper.language_image_path('not_exist') }.to raise_error(RuntimeError)
      end
    end
  end
end
