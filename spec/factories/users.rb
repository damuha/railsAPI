FactoryBot.define do
    factory :users, class: User do
        user_name {"dayoung.ham"}
    end
    factory :testuser, class: Ticket do
        
        ticket_name {"radwimps"}
        user_id {users.user_id}
        give_flg {"0"}
    end

    factory :users_create, class: User do
        user_name {"dayoung.ham"}
    end
  end