class EmailFormatValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    return if /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.match?(value)

    record.errors.add(attribute, 'の形式が正しくありません')
  end
end
