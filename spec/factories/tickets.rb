FactoryBot.define do
    factory :tickets, class: Ticket do
        ticket_name {"radwimps"}
        give_flg {0}
    end

    factory :ticket_update_before, class: Ticket do
        ticket_name {"radwimps"}
        give_flg {0}
    end
    factory :ticket_update_after, class: Ticket do
        give_flg {1}
        give_user_id {"2"}
    end
  end