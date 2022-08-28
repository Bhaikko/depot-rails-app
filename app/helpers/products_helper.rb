module ProductsHelper
  def format_html_to_overview(html, **truncate_args)
    truncate(strip_tags(html), truncate_args)
  end

  def generate_image_url(image)
    image.present? ? rails_blob_path(image, disposition: 'attachment') : 'default_product.png'
  end
  
  def generate_ratings
    (0.0..5.0).step(0.5).to_a
  end
end
