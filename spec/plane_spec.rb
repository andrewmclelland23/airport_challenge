require "plane"

describe Plane do

  subject { Plane.new(Airport.new) }

  it { is_expected.to respond_to(:location) }
  it { is_expected.to respond_to(:land).with(1).argument }
  it { is_expected.to respond_to(:take_off) }
  it "Sets location to a given airport when instantiated" do
    airport = Airport.new
    plane = Plane.new(airport)
    expect(plane.location).to eq airport
  end
  it "Sets location to a given airport when land method is called" do
    airport = instance_double("Airport", :weather => "sunny", :full? => false, :fleet => [])
    subject.land(airport)
    expect(subject.location).to eq airport
  end
  it "Sets location to 'flying' when take_off method is called and weather is sunny" do
    airport = instance_double("Airport", :weather => "sunny", :full? => false, :fleet => [])
    plane = Plane.new(airport)
    plane.take_off
    expect(plane.location).to eq "flying"
  end
  it "Throws error when take_off method is called and @weather attribute for aiport is stormy" do
    airport = instance_double("Airport", :weather => "stormy", :full? => false, :fleet => [])
    plane = Plane.new(airport)
    expect { plane.take_off }.to raise_error(StandardError, "Can't take off, weather is stormy")
  end
  it "Does not update @location attribute when take_off method is called and @weather attribute for aiport is stormy" do
    airport = instance_double("Airport", :weather => "stormy", :full? => false, :fleet => [])
    plane = Plane.new(airport)
    expect { plane.take_off }.to raise_error(StandardError, "Can't take off, weather is stormy")
    expect(plane.location).to eq airport
  end
  it "Throws error when land method is called and @weather attribute for aiport passed in as argument is stormy" do
    airport1 = instance_double("Airport", :weather => "sunny", :full? => false, :fleet => [])
    airport2 = instance_double("Airport", :weather => "stormy", :full? => false, :fleet => [])
    plane = Plane.new(airport1)
    plane.take_off
    expect { plane.land(airport2) }.to raise_error(StandardError, "Can't land, weather is stormy")
  end
  it "Does not update @location attribute when land method is called and @weather attribute for aiport passed in as argument is stormy" do
    airport1 = instance_double("Airport", :weather => "sunny", :full? => false, :fleet => [])
    airport2 = instance_double("Airport", :weather => "stormy", :full? => false, :fleet => [])
    plane = Plane.new(airport1)
    plane.take_off
    expect { plane.land(airport2) }.to raise_error(StandardError, "Can't land, weather is stormy")
    expect(plane.location).to eq "flying"
  end
  it "Throws error when land method is called and airport is at max capacity" do
    airport1 = instance_double("Airport", :weather => "sunny", :fleet => [])
    airport2 = instance_double("Airport", :weather => "sunny", :full? => true, :fleet => [])
    plane = Plane.new(airport1)
    plane.take_off
    expect { plane.land(airport2) }.to raise_error(StandardError, "Can't land, airport is full")
  end
  it "Does not update @location attribute when land method is called and airport is at max capacity" do
    airport1 = instance_double("Airport", :weather => "sunny", :fleet => [])
    airport2 = instance_double("Airport", :weather => "sunny", :full? => true, :fleet => [])
    plane = Plane.new(airport1)
    plane.take_off
    expect { plane.land(airport2) }.to raise_error(StandardError, "Can't land, airport is full")
    expect(plane.location).to eq "flying"
  end
  it "Pushes a newly instantiated plane to the @fleet array of the airport passed in as the initialize argument" do
    airport1 = Airport.new
    plane1 = Plane.new(airport1)
    plane2 = Plane.new(airport1)
    expect(airport1.fleet).to eq [plane1, plane2]
  end
end
