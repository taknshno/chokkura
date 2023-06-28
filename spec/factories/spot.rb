FactoryBot.define do
  factory :spot do
    name { "Default Spot" }
    images { [] }
    area { "県北" }
    address { "Default Address" }
    phone { "000-000-0000" }
    holiday { "Sunday" }
    sales_copy { "Default Sales Copy"}
    detail_description { "Default Detail Description" }
    simple_description { "Default Simple Description" }
  end
end