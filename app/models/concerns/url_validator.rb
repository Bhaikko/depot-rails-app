class UrlValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors.add attribute, "has invalid URL" if value !~ URI.regexp
  end
end