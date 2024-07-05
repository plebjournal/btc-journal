module NotesHelper
  def created_at
    @note.created_at.strftime('%Y-%m-%d')
  end

  def price
    number_to_currency @note.price
  end
end
