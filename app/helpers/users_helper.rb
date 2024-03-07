# frozen_string_literal: true

# Returns the Gravatar for the given user.
module UsersHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest user.email.downcase # Use to hash email to string(32 character - 128 bits), docs:https://ruby-doc.org/stdlib-2.4.0/libdoc/digest/rdoc/Digest/MD5.html # rubocop:disable Layout/LineLength
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag gravatar_url, alt: user.name, class: "gravatar" # return image tag in html
  end
end
