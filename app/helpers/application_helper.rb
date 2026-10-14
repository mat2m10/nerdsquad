module ApplicationHelper
  # Renders an Active Storage photo through Cloudinary when that is the
  # configured service, and as a plain Active Storage image otherwise
  # (local disk in development without CLOUDINARY_URL, and in tests).
  def photo_tag(photo, options = {})
    if ActiveStorage::Blob.service.name.to_s == "cloudinary"
      cl_image_tag(photo.key, options)
    else
      image_tag(url_for(photo), options)
    end
  end
end
