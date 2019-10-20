# frozen_string_literal: true

module CodesHelper
  IMAGE_EXT = %w[.png .jpg .gif].freeze

  def languages
    Language.all
  end

  def badge_label(status)
    case status
    when 'published' then '受付中'
    when 'closed' then '受付終了'
    else 'その他'
    end
  end

  def language_image_path(name)
    IMAGE_EXT.each do |ext|
      path = "icons/#{name}#{ext}"
      return path if image_exists?(path)
    end
    raise "イメージが見つかりませんでした。name:#{name}, ext:#{IMAGE_EXT}"
  end

  private

  def image_exists?(path)
    app = Rails.application
    if Rails.env.production?
      app.assets_manifest.find_sources(path).present?
    else
      app.assets.find_asset(path).present?
    end
  end
end
