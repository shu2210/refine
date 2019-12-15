# frozen_string_literal: true

require 'rails_helper'

describe CodesHelper, type: :helper do
  describe 'languages' do
    it 'Languageテーブルの中身を全て取得する' do
      expect(helper.languages).to eq(Language.all)
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
