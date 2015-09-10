require 'player'

describe Player do

  let(:ship) {double :ship, coordinates: :A1}
  let(:ship2) {double :ship2, coordinates: :C2}

  it "we can place on board" do
    expect(subject.place ship).to eq(subject.board)
  end

  it "we can fire at the right coordinates" do
    subject.place(ship)
    expect(subject.fire :A1).to eq "You've hit a ship!"
  end

  it "we missed a ship when we fire" do
    subject.place(ship)
    expect(subject.fire :B2).to eq "You've missed a ship!"
  end

  it 'the game can end' do
    subject.place(ship)
    subject.fire(:A1)
    expect(subject).to be_game_over
  end

  it "the game is not game over" do
    subject.place(ship)
    subject.fire(:B1)
    expect(subject).not_to be_game_over
  end

  it 'can hit a ship' do
    subject.place(ship)
    subject.fire(:A1)
    expect(subject.hits).to eq([:A1])
  end

  it 'record misses' do
    subject.place(ship)
    subject.fire(:B1)
    expect(subject.misses).to eq([:B1])
  end

  it 'place ships within board' do
    expect{subject.place(ship2)}.to raise_error "Wrong coordinates"
  end

  it 'shot outside of range' do
    expect { subject.fire(:B9) }.to raise_error 'You shot outside the range'
  end

end
