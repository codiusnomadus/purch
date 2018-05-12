require "image_processing/mini_magick"

class UploadUploader < Shrine
  include ImageProcessing::MiniMagick
  plugin :processing
  plugin :versions
  plugin :remove_attachment
  plugin :delete_raw
  plugin :store_dimensions

  process(:store) do |io, context|
    original = io.download
    pipeline = ImageProcessing::MiniMagick.source(original)

    large = pipeline.resize_to_limit!(800, 800)
    medium = pipeline.resize_to_limit!(500, 500)
    thumb = pipeline.resize_to_limit!(5, 5)

    original.close!

    { original: io, large: large, medium: medium, small: thumb }
  end

  Attacher.validate do
    validate_max_size 10.megabyte, message: "is too large (max is 1 MB)"
    validate_mime_type_inclusion ['image/jpg', 'image/jpeg', 'image/png']
  end

  plugin :default_url do |context|
    Rails.root.join('app', 'assets', 'images', 'blog-img-2.jpg')
  end
end

