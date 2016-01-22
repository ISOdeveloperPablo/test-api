require 'rails_helper'

RSpec.describe PoBox, type: :model do
  describe PoBox do
     it { should have_many(:users) }

     it { should validate_presence_of(:box_number) }
     it { should validate_presence_of(:city) }
     it { should validate_presence_of(:country) }

     it "returns a sorted array of PO Boxes that match" do
       a = FactoryGirl.create(:po_box, box_number: 2222, city: "Boston")
       b = FactoryGirl.create(:po_box, box_number: 4565, country: "Brazil")
       c = FactoryGirl.create(:po_box, box_number: 3333, city: "Boston")

       expect(PoBox.search("Kenya")) == [a, c]
       expect(PoBox.search(4565)) == [b]
       expect(PoBox.search("Nairobi")) == [b]
     end
  end
end
