class Quote < ApplicationRecord
    belongs_to :company
    has_many :line_item_dates, dependent: :destroy
    has_many :line_items, through: :line_item_dates


    validates :name, presence: true

    scope :ordered, -> { order(id: :desc) }

    # after_create_commit -> { 
    #     broadcast_prepend_to "quotes",
    #     partial: "quotes/quote",
    #     locals: { quote: self }, target: "quotes" 
    # }

    # kode diatas bisa dipersingkat dengan kode dibawah ini

    # after_create_commit -> { broadcast_prepend_to "quotes" }
    # after_update_commit -> { broadcast_replace_to "quotes" }
    # after_destroy_commit -> { broadcast_remove_to "quotes" }

    # kode dibawah ini menggunakan metode async untuk peforma yang lebih baik
    # after_create_commit -> { broadcast_prepend_later_to "quotes" }
    # after_update_commit -> { broadcast_replace_later_to "quotes" }
    # after_destroy_commit -> { broadcast_remove_to "quotes" }

    # ketiga kode diatas bisa dipersingkat dengan kode dibawah ini
    broadcasts_to ->(quote) { [quote.company, "quotes"] }, inserts_by: :prepend

    def total_price
        line_items.sum(&:total_price)
    end
end
