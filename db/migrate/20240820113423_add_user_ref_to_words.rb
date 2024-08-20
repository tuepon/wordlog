class AddUserRefToWords < ActiveRecord::Migration[7.0]
  def change
    add_reference :words, :user, null: true, foreign_key: true

    # ここで既存のレコードに対応するuser_idを設定
    Word.update_all(user_id: 1) # 適切なuser_idに更新

    change_column_null :words, :user_id, false
  end
end
