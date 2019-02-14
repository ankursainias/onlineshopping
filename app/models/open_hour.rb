class OpenHour < ApplicationRecord
  belongs_to :store
  validates_presence_of :day, :close, :open, :store_id
  validates_inclusion_of :day, :in => 1..7
  validates_uniqueness_of :open, scope: [:store_id, :day]
  validates_uniqueness_of :close, scope: [:store_id, :day]
   validate :opens_before_closes 
  validate :valid_from_before_valid_through 

  def formated_open
    open.strftime("%I:%M%p")
  end

  def formated_close
    close.strftime("%I:%M%p")
  end

  def formated_valid_from
    valid_from.to_date
  end

  def formated_valid_through
    valid_through.to_date
  end

  def english_day
    Date::DAYNAMES[day]
  end


  protected
	  def opens_before_closes
	    errors.add(:close, I18n.t('errors.opens_before_close')) if open && close && open >= close
	  end

	  def valid_from_before_valid_through
	    errors.add(:valid_through, I18n.t('errors.valid_from_before_valid_through')) if valid_from && valid_through && valid_from >= valid_through
	  end
end
