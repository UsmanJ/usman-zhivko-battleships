require 'player'

describe Player do

  let(:ship) {double :ship, coordinates: :A1}
  let(:ship2) {double :ship2, coordinates: :C2}
  let(:ship3) {double :ship3, coordinates: :B2}
  let(:ship4) {double :ship4, coordinates: :A1}


  it "can place on board" do
    expect(subject.place ship).to eq(subject.board)
  end

  it "can fire at the right coordinates" do
    subject.place(ship)
    subject.place(ship3)
    expect(subject.fire :A1).to eq "You've hit a ship!"
  end

  it "we missed a ship when we fire" do
    subject.place(ship)
    expect(subject.fire :A2).to eq "You've missed a ship!"
  end

  it 'records a hit' do
    subject.place(ship)
    subject.fire(:A1)
    expect(subject.hits).to eq([:A1])
  end

  it 'record misses' do
    subject.place(ship)
    subject.fire(:B1)
    expect(subject.misses).to eq([:B1])
  end

  it 'place ships only within board' do
    expect{subject.place(ship2)}.to raise_error "Wrong coordinates"
  end

  it 'shot outside of range' do
    expect { subject.fire(:B9) }.to raise_error 'You shot outside the range'
  end

  it 'game over if all ships sink' do
    subject.place(ship)
    subject.place(ship3)
    subject.fire(:A1)
    expect(subject.fire(:B2)).to eq "You've hit a ship! Game over"
  end

  it 'cannot place a ship ontop of another ship' do
    subject.place(ship)
    expect { subject.place(ship4) }.to raise_error 'Ship already in this location!'
  end

end
